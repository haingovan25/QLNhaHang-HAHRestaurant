package controller;

import dao.BookingTablesDAO;
import dao.RestaurantTableDAO;
import java.io.IOException;
import java.util.List; // <-- THÊM IMPORT NÀY
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminAssignTableServlet", urlPatterns = {"/admin-assign-table"})
public class AdminAssignTableServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int newTableId = Integer.parseInt(request.getParameter("tableId")); // Bàn mới

            BookingTablesDAO btDAO = new BookingTablesDAO();
            RestaurantTableDAO tableDAO = new RestaurantTableDAO();

            // 1. Lấy danh sách các bàn CŨ đã được gán (để giải phóng)
            List<Integer> oldTableIds = btDAO.getTableIdsForBooking(bookingId);
            
            // 2. Cập nhật (Xóa cũ, Thêm mới) trong BookingTables
            //    VÀ giải phóng các bàn cũ
            btDAO.updateAssignedTable(bookingId, newTableId, oldTableIds);
            
            // 3. Cập nhật trạng thái bàn MỚI thành "Reserved" (Đã đặt)
            tableDAO.updateTableStatus(newTableId, "Reserved");
            
            // 4. Quay trở lại trang Lịch đặt bàn
            response.sendRedirect("admin-booking-list");
            
        } catch (Exception e) {
            e.printStackTrace();
            // (Xử lý lỗi)
            response.sendRedirect("admin-booking-list");
        }
    }
}