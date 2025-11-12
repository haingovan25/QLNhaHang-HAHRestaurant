<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <%-- XÓA BỎ CSS INLINE VÀ LINK CSS MỚI --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
    <div class="login-container">
        <h2>Đăng ký tài khoản</h2>
        
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        
        <form action="register" method="POST">
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" value="${param.username}" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="repassword">Nhập lại mật khẩu:</label>
                <input type="password" id="repassword" name="repassword" required>
            </div>
            <hr style="border: 0; border-top: 1px solid #eee; margin: 25px 0;">
            <div class="form-group">
                <label for="fullName">Họ và tên:</label>
                <input type="text" id="fullName" name="fullName" value="${param.fullName}" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${param.email}">
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại:</label>
                <input type="tel" id="phone" name="phone" value="${param.phone}">
            </div>
            
            <button type="submit" class="btn-submit">Đăng ký</button>
        </form>
        
        <%-- Thêm class "auth-switch" --%>
        <p class="auth-switch">
            Đã có tài khoản? <a href="login">Đăng nhập ngay</a>
        </p>
    </div>
</body>
</html>