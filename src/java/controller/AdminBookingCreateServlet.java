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
import java.sql.Date;
import java.sql.Time;
import model.Booking;
import model.RestaurantTable;

@WebServlet(name = "AdminBookingCreateServlet", urlPatterns = {"/admin-booking-create"})
public class AdminBookingCreateServlet extends HttpServlet {

    /**
     * doGet: Vẫn hiển thị trang, nhưng không cần tải danh sách bàn nữa
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // (Không cần tải tableList nữa vì form đã bị xóa)
        // RestaurantTableDAO tableDAO = new RestaurantTableDAO();
        // List<RestaurantTable> tableList = tableDAO.getAllTables();
        // request.setAttribute("tableList", tableList);
        
        request.getRequestDispatcher("booking-create.jsp").forward(request, response);
    }

    /**
     * doPost: Xử lý khi Admin nhấn nút "Xác nhận đặt bàn"
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Lấy thông tin từ form
            String customerName = request.getParameter("customerName");
            String phone = request.getParameter("phone");
            Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
            Time bookingTime = Time.valueOf(request.getParameter("bookingTime") + ":00");
            int numPeople = Integer.parseInt(request.getParameter("numPeople"));
            String note = request.getParameter("note");
            String status = request.getParameter("status"); // Lấy trạng thái
            
            // === SỬA LỖI (Làm cho tableId tùy chọn) ===
            String tableIdParam = request.getParameter("tableId");
            Integer tableId = null; // Dùng Integer (đối tượng) để cho phép null
            
            if(tableIdParam != null && !tableIdParam.isEmpty()) {
                tableId = Integer.parseInt(tableIdParam);
            }
            // === KẾT THÚC SỬA LỖI ===

            // 2. Tạo đối tượng Booking
            Booking booking = new Booking();
            booking.setCustomerName(customerName);
            booking.setPhone(phone);
            booking.setBookingDate(bookingDate);
            booking.setBookingTime(bookingTime);
            booking.setNumPeople(numPeople);
            booking.setNote(note);
            booking.setStatus(status);

            // 3. Lưu Booking vào CSDL
            BookingDAO bookingDAO = new BookingDAO();
            int newBookingId = bookingDAO.insertBooking(booking);

            if (newBookingId != -1) {
                
                // === SỬA LỖI: CHỈ LIÊN KẾT BÀN NẾU ADMIN CÓ CHỌN ===
                // (Trong trường hợp này, tableId sẽ luôn là null,
                // nhưng logic này vẫn đúng nếu bạn quyết định thêm lại ô chọn bàn)
                if (tableId != null) { 
                    BookingTablesDAO bookingTablesDAO = new BookingTablesDAO();
                    bookingTablesDAO.linkTableToBooking(newBookingId, tableId);
                    
                    // Cập nhật trạng thái bàn thành "Reserved"
                    RestaurantTableDAO tableDAO = new RestaurantTableDAO();
                    tableDAO.updateTableStatus(tableId, "Reserved");
                }
                
                // 5. Chuyển hướng về trang lịch sử
                response.sendRedirect("admin-booking-history");
            } else {
                // Xử lý lỗi
                request.setAttribute("error", "Không thể tạo đơn đặt bàn.");
                doGet(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu nhập không hợp lệ.");
            doGet(request, response);
        }
    }
}