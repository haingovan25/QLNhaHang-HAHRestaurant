
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("account") != null) {
            response.sendRedirect("home");
            return;
        }

        // === THÊM KHỐI NÀY ===
        // Kiểm tra xem có phải vừa đăng ký thành công không
        String registerSuccess = request.getParameter("register");
        if ("success".equals(registerSuccess)) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
        }
        // === KẾT THÚC KHỐI MỚI ===

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        AccountDAO dao = new AccountDAO();
        Account account = dao.login(user, pass);

        if (account != null) {
            // ... (Code kiểm tra 'isActive' của bạn) ...
            if (!account.isActive()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                request.setAttribute("username", user);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            session.setMaxInactiveInterval(60 * 60);

            // === THÊM DÒNG NÀY ===
            // Gửi thông báo đăng nhập thành công qua session
            session.setAttribute("successMessage", "Đăng nhập thành công! Chào mừng, " + account.getFullName() + "!");
            // === KẾT THÚC DÒNG MỚI ===

            int role = account.getRole();
            switch (role) {
                case 1:
                    response.sendRedirect("/QLNhaHang/admin-main.jsp");
                    break;
                case 2:
                    response.sendRedirect("staff-dashboard");
                    break;
                case 0:
                    // ... (Code tìm giỏ hàng của bạn) ...
                    OrderDAO orderDAO = new OrderDAO();
                    Integer activeOrderId = null;
                    try {
                        activeOrderId = orderDAO.findUnpaidOrderId(account.getId());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    session.setAttribute("active_order_id", activeOrderId);
                    response.sendRedirect("home");
                    break;
                default:
                    response.sendRedirect("home");
                    break;
            }

        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.setAttribute("username", user); 
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}