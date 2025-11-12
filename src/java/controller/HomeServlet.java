package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.Product;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        
        // --- (1) Logic đọc thông báo "Đăng nhập thành công" (Màu xanh, giữ nguyên) ---
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("flashSuccess", successMessage);
            session.removeAttribute("successMessage");
        }
        
        // === (2) THÊM KHỐI NÀY ĐỂ ĐỌC THÔNG BÁO "ĐĂNG XUẤT" (Màu đỏ) ===
        String logoutParam = request.getParameter("logout");
        if ("true".equals(logoutParam)) {
            // Gửi thông báo 'error' (màu đỏ) ra cho JSP
            request.setAttribute("flashError", "Bạn đã đăng xuất khỏi tài khoản.");
        }
        // === KẾT THÚC KHỐI MỚI ===

        // (Code cũ của bạn giữ nguyên)
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        
        List<Product> productList = productDAO.getAllProducts(); 
        List<Category> categoryList = categoryDAO.getAllCategories();

        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    
    // (doGet và doPost giữ nguyên)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}