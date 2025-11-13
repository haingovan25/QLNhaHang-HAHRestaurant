<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
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
        <a href="home" class="<%= "home".equals(pageName) ? "active" : "" %>">Trang ch?</a>
        <a href="menu" class="<%= "menu".equals(pageName) ? "active" : "" %>">Th?c ??n</a>
        <a href="reservation" class="<%= "reservation".equals(pageName) ? "active" : "" %>">??t bàn</a>
        <a href="about.jsp" class="<%= "about.jsp".equals(pageName) ? "active" : "" %>">Gi?i thi?u</a>
        <a href="contact.jsp" class="<%= "contact.jsp".equals(pageName) ? "active" : "" %>">Liên h?</a>
    </nav>

    <div class="right-menu">
        <input type="text" placeholder="Tìm ki?m món ?n">

        <c:if test="${sessionScope.account == null}">
            <button class="login" onclick="window.location.href='login'">??ng nh?p</button>
        </c:if>

        <c:if test="${sessionScope.account != null}">
            <span style="color: white; margin-right: 10px; font-weight: 500;">
                Chào, ${sessionScope.account.fullName}
            </span>
            <button class="login" onclick="window.location.href='logout'" 
                    style="background: #dc3545; border-color: #dc3545; color: white;">
                ??ng xu?t
            </button>
            <button class="cart" onclick="window.location.href='cart'">?</button>
        </c:if>
    </div>
</header>
