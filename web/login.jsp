<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    
    <style>
        .success {
            color: #155724; /* Màu xanh lá cây */
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px 15px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 15px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>
        
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <p class="success">${successMessage}</p>
        </c:if>
        <form action="login" method="POST">
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" value="${param.username}" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn-submit">Đăng nhập</button>
        </form>
        
        <p class="auth-switch">
            Chưa có tài khoản? <a href="register">Đăng ký ngay</a>
        </p>
    </div>
</body>
</html>