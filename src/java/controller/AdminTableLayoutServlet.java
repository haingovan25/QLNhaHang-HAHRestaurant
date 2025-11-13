package controller;

import dao.RestaurantTableDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.RestaurantTable;

@WebServlet(name = "AdminTableLayoutServlet", urlPatterns = {"/admin-table-layout"})
public class AdminTableLayoutServlet extends HttpServlet {

    // (Bên trong AdminTableLayoutServlet.java)
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // === THÊM LOGIC NÀY ===
        // Kiểm tra xem có phải đang ở chế độ "chọn bàn" không
        String bookingId = request.getParameter("bookingId");
        if (bookingId != null) {
            request.setAttribute("bookingId", bookingId); // Gửi bookingId ra JSP
            request.setAttribute("pageTitle", "Chọn bàn cho đơn đặt"); // Đổi tiêu đề
        } else {
            request.setAttribute("pageTitle", "Sơ đồ bàn"); // Tiêu đề cũ
        }
        // === KẾT THÚC LOGIC MỚI ===

        RestaurantTableDAO tableDAO = new RestaurantTableDAO();
        List<String> areaList = tableDAO.getDistinctAreas();
        String activeArea = request.getParameter("area");

        if (activeArea == null && !areaList.isEmpty()) {
            activeArea = areaList.get(0);
        }

        List<RestaurantTable> tableList = tableDAO.getTablesByArea(activeArea);

        request.setAttribute("areaList", areaList);
        request.setAttribute("tableList", tableList);
        request.setAttribute("activeArea", activeArea);

        request.getRequestDispatcher("table-layout.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}