<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Kết quả thanh toán VNPAY</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="text-center p-5">
  <h2>Kết quả thanh toán</h2>

  <c:if test="${requestScope.paymentStatus == 'Success'}">
      <h3 class="text-success">🎉 Thanh toán thành công!</h3>
      <p>Mã đơn hàng: <b>${param.vnp_TxnRef}</b></p>
      <%-- Hiển thị số tiền đã chia 100 --%>
      <p>Số tiền: <b><fmt:formatNumber value="${param.vnp_Amount / 100}" type="number" /> ₫</b></p> 
  </c:if>
  
  <c:if test="${requestScope.paymentStatus != 'Success'}">
      <h3 class="text-danger">❌ Thanh toán thất bại hoặc bị hủy!</h3>
      <p>Mã lỗi: ${param.vnp_ResponseCode}</p>
  </c:if>
  
  <a href="home" class="btn btn-primary mt-3">Về trang chủ</a>
</body>
</html>