package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;

@WebServlet(name = "AdminBookingHistoryServlet", urlPatterns = {"/admin-booking-history"})
public class AdminBookingHistoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        final int PAGE_SIZE = 5; // 5 dòng mỗi trang
        
        // Lấy trạng thái (tab)
        String status = request.getParameter("status");
        if (status == null || status.isEmpty()) {
            status = "all"; // Mặc định là "Tất cả"
        }

        // Lấy từ khóa tìm kiếm
        String searchKey = request.getParameter("searchKey");
        if (searchKey == null) {
            searchKey = ""; // Gán rỗng để tránh lỗi Null
        }

        // Lấy số trang (page)
        String pageParam = request.getParameter("page");
        int pageIndex = 1; // Mặc định là trang 1
        if (pageParam != null) {
            try {
                pageIndex = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                pageIndex = 1; 
            }
        }

        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookingList;

        // 1. Đếm tổng số đơn (Đã truyền searchKey)
        int totalBookings = bookingDAO.countBookings(status, searchKey);
        
        // 2. Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalBookings / PAGE_SIZE);

        // 3. Lấy danh sách đơn cho trang hiện tại (Đã truyền searchKey)
        if (status.equals("all")) {
            bookingList = bookingDAO.getAllBookings(pageIndex, PAGE_SIZE, searchKey);
        } else {
            bookingList = bookingDAO.getBookingsByStatus(status, pageIndex, PAGE_SIZE, searchKey);
        }

        // 4. Gửi tất cả dữ liệu ra JSP
        request.setAttribute("bookingList", bookingList);
        request.setAttribute("activeTab", status);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("searchKey", searchKey); // <-- GỬI LẠI TỪ KHÓA TÌM KIẾM
        
        request.getRequestDispatcher("booking-history.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}