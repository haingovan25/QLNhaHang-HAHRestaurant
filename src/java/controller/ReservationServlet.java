package controller;

import dao.BookingDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.Time;
import model.Account;
import model.Booking;

@WebServlet(name = "ReservationServlet", urlPatterns = {"/reservation"})
public class ReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer activeOrderId = (Integer) session.getAttribute("active_order_id");

        if (activeOrderId != null) {
            // Đã có giỏ hàng (đã đặt bàn) -> chuyển sang menu
            response.sendRedirect("menu");
            return;
        }

        // Chưa có giỏ hàng -> hiển thị form đặt bàn
        request.getRequestDispatcher("reservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Lấy dữ liệu từ form
            String customerName = request.getParameter("customerName");
            String phone = request.getParameter("phone");
            Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
            Time bookingTime = Time.valueOf(request.getParameter("bookingTime") + ":00");
            int numPeople = Integer.parseInt(request.getParameter("numPeople"));
            String note = request.getParameter("note");
            String branch = request.getParameter("branch"); 

            Booking booking = new Booking();
            booking.setCustomerName(customerName);
            booking.setPhone(phone);
            booking.setBookingDate(bookingDate);
            booking.setBookingTime(bookingTime);
            booking.setNumPeople(numPeople);
            booking.setNote(note);
            // (Bạn có thể set thêm branch nếu model Booking có)

            BookingDAO bookingDAO = new BookingDAO();
            int newBookingId = bookingDAO.insertBooking(booking); 

            if (newBookingId != -1) {
                OrderDAO orderDAO = new OrderDAO();
                int newOrderId = orderDAO.createEmptyOrder(account.getId(), newBookingId);

                if (newOrderId != -1) {
                    session.setAttribute("active_order_id", newOrderId);
                    
                    // === THÊM DÒNG NÀY ===
                    // Lưu thông báo thành công vào session để MenuServlet đọc
                    session.setAttribute("successMessage", "Đã đặt bàn thành công! Giờ bạn hãy chọn món cho bàn của mình.");
                    
                    // Chuyển sang trang chọn món
                    response.sendRedirect("menu");
                } else {
                    request.setAttribute("error", "Lỗi khi tạo đơn hàng, vui lòng thử lại!");
                    request.getRequestDispatcher("reservation.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Lỗi khi đặt bàn, vui lòng thử lại!");
                request.getRequestDispatcher("reservation.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
        }
    }
}