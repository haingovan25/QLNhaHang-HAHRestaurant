package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false); // Lấy session (nếu có)
        if (session != null) {
            // Hủy phiên làm việc
            session.invalidate();
        }
        
        // === THAY ĐỔI Ở ĐÂY ===
        // 1. Chuyển hướng về HomeServlet (là "home")
        // 2. Gửi kèm 1 tham số (query parameter) để báo hiệu đăng xuất
        response.sendRedirect("home?logout=true");
    }
}