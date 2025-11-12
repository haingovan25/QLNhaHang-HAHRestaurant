package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.VnpayConfig;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay-return"})
public class VnpayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = req.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = req.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = req.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHash");

        // (Code check chữ ký VNPAY)
        // String signValue = VnpayConfig.hashAllFields(fields); // (Bạn cần hàm này trong VnpayConfig)
        
        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        
        // Tạm thời bỏ qua check chữ ký (bạn phải thêm sau)
        // if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(vnp_ResponseCode)) {
                // THANH TOÁN THÀNH CÔNG
                HttpSession session = req.getSession();
                Integer orderId = (Integer) session.getAttribute("active_order_id");
                
                if (orderId != null) {
                    OrderDAO orderDAO = new OrderDAO();
                    // Cập nhật CSDL
                    orderDAO.updatePaymentStatus(orderId, "Paid", "Confirmed", "VNPAY");
                    // Xóa giỏ hàng khỏi session
                    session.removeAttribute("active_order_id");
                }
                
                // Gửi thông báo thành công ra vnpay_return.jsp
                req.setAttribute("paymentStatus", "Success");
            } else {
                // THANH TOÁN THẤT BẠI
                req.setAttribute("paymentStatus", "Failed");
            }
        // } else {
        //     req.setAttribute("paymentStatus", "InvalidSignature");
        // }

        req.getRequestDispatcher("vnpay_return.jsp").forward(req, resp);
    }
}