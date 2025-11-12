package controller;

import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer activeOrderId = (Integer) session.getAttribute("active_order_id");

        if (activeOrderId == null) {
            // Nếu không có giỏ hàng (chưa đặt bàn), chuyển hướng về trang đặt bàn
            response.sendRedirect("reservation");
            return;
        }
        
        // Nếu CÓ giỏ hàng, lấy thông tin giỏ hàng từ CSDL
        OrderDAO orderDAO = new OrderDAO();
        Order currentCart = orderDAO.getOrderById(activeOrderId);
        
        // Gửi giỏ hàng (Order object) ra trang JSP
        request.setAttribute("currentCart", currentCart);
        
        // Hiển thị trang cart.jsp
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}