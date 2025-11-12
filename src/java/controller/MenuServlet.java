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

@WebServlet(name = "MenuServlet", urlPatterns = {"/menu"})
public class MenuServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();

        // --- (1) Logic đọc thông báo "flash" (Giữ nguyên) ---
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("flashSuccess", successMessage);
            session.removeAttribute("successMessage");
        }
        
        // === (2) THÊM LOGIC KIỂM TRA GIỎ HÀNG ===
        // (Rất quan trọng để quyết định có hiển thị nút "Xem thực đơn đã đặt" hay không)
        Integer activeOrderId = (Integer) session.getAttribute("active_order_id");
        if (activeOrderId != null) {
            // Nếu khách đã đặt bàn (có giỏ hàng), gửi tín hiệu "true" ra JSP
            request.setAttribute("hasActiveOrder", true);
        }
        // === KẾT THÚC KHỐI MỚI ===

        // (Code cũ của bạn giữ nguyên)
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        
        List<Product> allProducts = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("allProducts", allProducts);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("menu.jsp").forward(request, response);
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