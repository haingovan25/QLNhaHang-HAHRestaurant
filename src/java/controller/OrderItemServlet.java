package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

@WebServlet(name = "OrderItemServlet", urlPatterns = {"/orderitem"})
public class OrderItemServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer orderId = (Integer) session.getAttribute("active_order_id");

        if (orderId == null) {
            response.sendRedirect("reservation");
            return;
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        OrderDAO orderDAO = new OrderDAO();
        String toastMessage = null; // Biến lưu thông báo
        
        try {
            if ("add".equals(action)) {
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    orderDAO.addProductToOrder(orderId, product);
                    // === THÊM DÒNG NÀY ===
                    toastMessage = "Đã thêm món " + product.getName() + " vào thực đơn 🍽️";
                }
            } 
            else if ("update".equals(action)) {
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                orderDAO.updateProductQuantity(orderId, productId, quantity);
            }
            else if ("remove".equals(action)) {
                orderDAO.removeProductFromOrder(orderId, productId);
                toastMessage = "Đã xóa món khỏi giỏ hàng.";
            }
            else if ("clearall".equals(action)) {
                orderDAO.clearCart(orderId);
                toastMessage = "Đã xóa toàn bộ giỏ hàng.";
            }
            
            // === THÊM DÒNG NÀY ===
            // Lưu thông báo vào session (nếu có)
            if (toastMessage != null) {
                session.setAttribute("successMessage", toastMessage);
            }
            
            // Chuyển hướng (tải lại) trang
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "menu");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("menu");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}