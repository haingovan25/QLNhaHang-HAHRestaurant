package controller;

import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProcessPaymentServlet", urlPatterns = {"/process-payment"})
public class ProcessPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String paymentMethod = request.getParameter("paymentMethod");

        OrderDAO orderDAO = new OrderDAO();

        if ("cod".equals(paymentMethod)) {
            // XỬ LÝ 1: Thanh toán tại nhà hàng
            try {
                // (Bạn đã thêm hàm này vào OrderDAO)
                orderDAO.updatePaymentStatus(orderId, "Paid", "Confirmed", "Thanh toán tại nhà hàng");
                
                // Xóa giỏ hàng (active_order_id) khỏi session
                session.removeAttribute("active_order_id");
                
                // Chuyển đến trang thành công
                response.sendRedirect("order-success.jsp");
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        } else if ("vnpay".equals(paymentMethod)) {
            // XỬ LÝ 2: Thanh toán VNPAY
            // Chuyển tiếp (forward) sang VnpayPaymentServlet để xử lý
            request.getRequestDispatcher("VnpayPayment").forward(request, response);
        }
    }
}