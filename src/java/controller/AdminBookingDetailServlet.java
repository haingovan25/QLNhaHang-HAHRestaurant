package controller;

import dao.BookingDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Order;

@WebServlet(name = "AdminBookingDetailServlet", urlPatterns = {"/admin-booking-detail"})
public class AdminBookingDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));

            BookingDAO bookingDAO = new BookingDAO();
            OrderDAO orderDAO = new OrderDAO();

            // 1. Lấy thông tin đặt bàn (Tên, SĐT, Giờ...)
            Booking booking = bookingDAO.getBookingById(bookingId);
            
            // 2. Lấy thông tin hóa đơn (Các món đã chọn, tổng tiền...)
            Order order = orderDAO.getOrderByBookingId(bookingId);

            // 3. Gửi cả 2 đối tượng ra JSP
            request.setAttribute("booking", booking);
            request.setAttribute("order", order);

            request.getRequestDispatcher("booking-details.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // (Xử lý lỗi)
            response.sendRedirect("admin-booking-list");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}