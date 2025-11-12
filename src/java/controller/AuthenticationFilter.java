package controller; 

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        HttpSession session = req.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;

        boolean isPublicResource = 
                // === THÊM DÒNG NÀY VÀO DANH SÁCH ===
                uri.equals(contextPath + "/") || // Cho phép truy cập đường dẫn gốc
                
                // (Các dòng cũ giữ nguyên)
                uri.equals(contextPath + "/login") ||
                uri.equals(contextPath + "/register") ||
                uri.equals(contextPath + "/") || // <-- THÊM DÒNG NÀY
                uri.equals(contextPath + "/home") ||
                
                uri.equals(contextPath + "/login.jsp") ||
                uri.equals(contextPath + "/register.jsp") ||
                uri.equals(contextPath + "/home.jsp") ||
                
                uri.startsWith(contextPath + "/css/") ||
                uri.startsWith(contextPath + "/images/") ||
                uri.startsWith(contextPath + "/js/");

        if (account != null || isPublicResource) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void destroy() {}
}