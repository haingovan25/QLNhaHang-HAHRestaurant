<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .success-container {
            text-align: center;
            padding: 60px 20px;
            margin: 50px auto;
            max-width: 600px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .success-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }
        h2 { color: #244b2c; margin-bottom: 15px; }
        p { color: #555; font-size: 16px; margin-bottom: 30px; }
        .btn-home {
            display: inline-block;
            padding: 10px 25px;
            background: #ffc107;
            color: #000;
            text-decoration: none;
            font-weight: 600;
            border-radius: 5px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="success-container">
        <div class="success-icon"><i class="fa-solid fa-circle-check"></i></div>
        <h2>Đặt hàng thành công!</h2>
        <p>Đơn hàng của bạn đã được ghi nhận. Quý khách vui lòng thanh toán tại quầy khi đến nhà hàng. Cảm ơn quý khách!</p>
        <a href="home" class="btn-home">Về trang chủ</a>
    </div>
</body>
</html>