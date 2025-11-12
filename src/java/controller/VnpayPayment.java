package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.TreeMap;
import util.VnpayConfig; // Import file config

@WebServlet(name = "VnpayPayment", urlPatterns = {"/VnpayPayment"})
public class VnpayPayment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other"; 
        
        long amount = (long) Double.parseDouble(req.getParameter("totalAmount")) * 100;
        String bankCode = ""; 
        
        String vnp_TxnRef = VnpayConfig.getRandomNumber(8); 
        String vnp_IpAddr = VnpayConfig.getIpAddress(req);
        String vnp_TmnCode = VnpayConfig.vnp_TmnCode;
        
        // === SỬA LỖI Ở ĐÂY ===
        // Thay "HashMap" bằng "TreeMap" để tự động sắp xếp A-Z
        Map<String, String> vnp_Params = new TreeMap<>();
        
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_BankCode", bankCode);
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VnpayConfig.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        
        // Build query URL
        StringBuilder query = new StringBuilder();
        // (Vòng lặp for này giờ sẽ tự động lấy key theo thứ tự A-Z)
        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty()) {
                query.append(URLEncoder.encode(entry.getKey(), StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(entry.getValue(), StandardCharsets.US_ASCII.toString()));
                query.append('&');
            }
        }
        query.deleteCharAt(query.length() - 1); // Remove last &
        
        // Chữ ký (hash) giờ sẽ được tạo từ chuỗi đã sắp xếp
        String vnp_SecureHash = VnpayConfig.hmacSHA512(VnpayConfig.vnp_HashSecret, query.toString());
        query.append("&vnp_SecureHash=" + vnp_SecureHash);
        
        String paymentUrl = VnpayConfig.vnp_PayUrl + "?" + query.toString();
        
        // Chuyển hướng người dùng sang VNPAY
        resp.sendRedirect(paymentUrl);
    }
}