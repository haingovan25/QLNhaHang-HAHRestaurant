<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Lấy tên trang hiện tại (ví dụ: "home", "menu", "reservation")
    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/") + 1);
%>

<header class="navbar 
    <%= "menu".equals(pageName) ? "gray-bg" : "" %>
    <%= "reservation".equals(pageName) ? "gray-bg" : "" %>
    <%= "payment".equals(pageName) ? "gray-bg" : "" %>
">
    <div class="logo">HAH<span>.</span></div>
    <nav>
        <a href="home" class="<%= "home".equals(pageName) ? "active" : "" %>">Trang chủ</a>
        <a href="menu" class="<%= "menu".equals(pageName) ? "active" : "" %>">Thực đơn</a>
        <a href="reservation" class="<%= "reservation".equals(pageName) ? "active" : "" %>">Đặt bàn</a>
        <a href="about.jsp" class="<%= "about.jsp".equals(pageName) ? "active" : "" %>">Giới thiệu</a>
        <a href="contact.jsp" class="<%= "contact.jsp".equals(pageName) ? "active" : "" %>">Liên hệ</a>
    </nav>
    <div class="right-menu">
        <input type="text" placeholder="Tìm kiếm món ăn">

        <c:if test="${sessionScope.account == null}">
            <button class="login" onclick="window.location.href='login'">Đăng nhập</button>
        </c:if>

        <c:if test="${sessionScope.account != null}">
            <span style="color: white; margin-right: 10px; font-weight: 500;">
                Chào, ${sessionScope.account.fullName}
            </span>
            <button class="login" onclick="window.location.href='logout'" style="background: #dc3545; border-color: #dc3545; color: white;">
                Đăng xuất
            </button>
            <button class="cart" onclick="window.location.href='cart'">🛒</button>
        </c:if>
    </div>
</header>