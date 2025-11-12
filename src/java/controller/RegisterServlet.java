/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Lấy tất cả dữ liệu và .trim() để loại bỏ khoảng trắng thừa
        String user = request.getParameter("username").trim();
        String pass = request.getParameter("password").trim();
        String rePass = request.getParameter("repassword").trim();
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();

        // Giữ lại các giá trị đã nhập (kể cả khi lỗi)
        request.setAttribute("username", user);
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        
        // === BẮT ĐẦU KHỐI VALIDATION MỚI ===
        
        // 1. Kiểm tra rỗng (Yêu cầu "điền toàn bộ")
        if (user.isEmpty() || pass.isEmpty() || rePass.isEmpty() || fullName.isEmpty() || email.isEmpty() || phone.isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ tất cả thông tin.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // Dừng thực thi
        }

        // 2. Kiểm tra độ dài mật khẩu
        // "trên 6 kí tự" nghĩa là phải > 6 (tức là ít nhất 7)
        if (pass.length() <= 6) { 
            request.setAttribute("error", "Mật khẩu phải có nhiều hơn 6 ký tự.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra định dạng Email (Regex)
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        if (!email.matches(emailRegex)) {
            request.setAttribute("error", "Email không đúng định dạng (ví dụ: example@mail.com).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // 4. Kiểm tra định dạng SĐT (Regex cho SĐT Việt Nam 10 số)
        String phoneRegex = "^0\\d{9}$"; // Bắt đầu bằng 0, theo sau là 9 chữ số
        if (!phone.matches(phoneRegex)) {
            request.setAttribute("error", "Số điện thoại phải là 10 chữ số và bắt đầu bằng 0.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // === KẾT THÚC KHỐI VALIDATION MỚI ===

        // 5. Kiểm tra mật khẩu có khớp không (Logic cũ của bạn)
        if (!pass.equals(rePass)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        AccountDAO dao = new AccountDAO();
        
        // 6. Kiểm tra tên đăng nhập đã tồn tại chưa (Logic cũ của bạn)
        boolean isExist = dao.checkAccountExist(user); 
        if (isExist) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // 7. Nếu mọi thứ OK -> Đăng ký
            // (Bạn nên mã hóa 'pass' trước khi lưu vào CSDL)
            dao.register(user, pass, fullName, email, phone); 
            
            // Đăng ký thành công, chuyển hướng sang trang đăng nhập
            // Gửi thêm 1 tham số "success" để trang login biết mà hiển thị
            response.sendRedirect("login?register=success");
        }
    }
}