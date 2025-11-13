package controller;

import dao.BookingDAO;
import dao.BookingTablesDAO;
import dao.RestaurantTableDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminUpdateBookingServlet", urlPatterns = {"/admin-update-booking"})
public class AdminUpdateBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            String newStatus = request.getParameter("status"); // "Confirmed" hoặc "Canceled"

            BookingDAO bookingDAO = new BookingDAO();
            RestaurantTableDAO tableDAO = new RestaurantTableDAO();
            BookingTablesDAO btDAO = new BookingTablesDAO();

            // 1. Cập nhật trạng thái đơn đặt bàn (Bookings)
            bookingDAO.updateBookingStatus(bookingId, newStatus);

            // 2. Lấy ID của(các) bàn được gán cho đơn này
            List<Integer> tableIds = btDAO.getTableIdsForBooking(bookingId);

            // 3. Cập nhật trạng thái cho các bàn đó
            for (int tableId : tableIds) {
                if (newStatus.equals("Confirmed")) {
                    // Nếu "Khách nhận bàn" -> Bàn chuyển sang "Occupied" (Bận)
                    tableDAO.updateTableStatus(tableId, "Occupied");
                } 
                else if (newStatus.equals("Canceled") || newStatus.equals("Completed")) {
                    // Nếu "Hủy" hoặc "Hoàn thành" -> Bàn quay lại "Available" (Trống)
                    tableDAO.updateTableStatus(tableId, "Available");
                }
            }

            // 4. Chuyển hướng Admin về lại trang danh sách (trang trước đó)
            response.sendRedirect("admin-booking-list");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-booking-list");
        }
    }
}