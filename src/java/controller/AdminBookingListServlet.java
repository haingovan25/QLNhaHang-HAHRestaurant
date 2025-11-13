package controller;

import dao.BookingDAO;
import dao.OrderDAO;
import dao.RestaurantTableDAO; // <-- THÊM IMPORT NÀY
import java.io.IOException;
import java.util.ArrayList; 
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.BookingDetailView;
import model.Order; 
import model.RestaurantTable; // <-- THÊM IMPORT NÀY

@WebServlet(name = "AdminBookingListServlet", urlPatterns = {"/admin-booking-list"})
public class AdminBookingListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        BookingDAO bookingDAO = new BookingDAO();
        OrderDAO orderDAO = new OrderDAO(); 
        RestaurantTableDAO tableDAO = new RestaurantTableDAO(); // <-- KHỞI TẠO TABLE DAO

        // 1. Lấy danh sách Booking (Pending)
        // (Lấy 100 đơn "Pending" đầu tiên, không tìm kiếm)
        List<Booking> pendingBookings = bookingDAO.getBookingsByStatus("Pending", 1, 100, ""); 

        // 2. Tạo danh sách ViewModel (danh sách mới)
        List<BookingDetailView> bookingDetailList = new ArrayList<>();
        
        // 3. Lặp qua từng Booking và tìm Order (hóa đơn) + Bàn tương ứng
        for (Booking b : pendingBookings) {
            // Lấy hóa đơn (giỏ hàng) liên kết
            Order o = orderDAO.getOrderByBookingId(b.getId());
            
            // Lấy thông tin bàn đã gán (Bạn phải thêm hàm getAssignedTableForBooking vào DAO)
            RestaurantTable t = tableDAO.getAssignedTableForBooking(b.getId());
            
            // Gộp cả 3 vào ViewModel (Sử dụng constructor 3 tham số mới)
            bookingDetailList.add(new BookingDetailView(b, o, t));
        }

        // 4. Gửi danh sách ViewModel (mới) ra JSP
        request.setAttribute("bookingDetailList", bookingDetailList); 
        
        request.getRequestDispatcher("booking-list.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}