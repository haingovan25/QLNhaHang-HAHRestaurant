
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%
    // Logic này của bạn vẫn đúng, nó sẽ lấy "home" từ URL /home
    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/") + 1);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HAH Restaurant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        #toast-container {
            position: fixed;
            bottom: 25px;
            right: 25px;
            z-index: 2000;
            display: flex; /* Thêm dòng này */
            flex-direction: column; /* Thêm dòng này */
            gap: 10px; /* Thêm dòng này */
        }
        .toast-item {
            background-color: #28a745; /* Màu xanh lá */
            color: white;
            padding: 16px 24px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            font-family: 'Segoe UI', sans-serif;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            opacity: 0;
            transform: translateX(100%);
            transition: all 0.4s ease;
        }
        .toast-item.show {
            opacity: 1;
            transform: translateX(0);
        }
        
        /* === THÊM CSS CHO TOAST MÀU ĐỎ === */
        .toast-item.error {
            background-color: #dc3545; /* Màu đỏ */
        }
    </style>
</head>
<body>
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

    <section id="hero" class="hero">
        <div class="overlay"></div>
        <div class="hero-content">
            <h1>HAH Restaurant<span>.</span></h1>
            <p>Chúng tôi hân hạnh được phục vụ quý khách</p>
                <div class="buttons">
            <a href="menu" class="btn">Thực đơn</a>
            <a href="reservation" class="btn">Đặt bàn</a>
                </div>
        </div>
    </section>

 <section class="menu-section">
    <h2 class="section-title reveal">THỰC ĐƠN</h2>
    <h3 class="section-subtitle reveal">BẠN MUỐN ĂN GÌ?</h3>

    <div class="menu-categories reveal">
        <c:forEach var="cat" items="${categoryList}" varStatus="loop">
            <button class="menu-btn ${loop.first ? 'active' : ''}" onclick="showCategory('cat-${cat.id}', this)">
                ${cat.name}
            </button>
        </c:forEach>
    </div>

    <div class="menu-container">
        <c:forEach var="cat" items="${categoryList}" varStatus="loop">
            <div class="menu-category" id="cat-${cat.id}" style="${loop.first ? 'display:flex;' : 'display:none;'}">
                <c:forEach var="p" items="${productList}">
                    <c:if test="${p.categoryId == cat.id}">
                        <div class="menu-item reveal">
                            <img src="${p.imageUrl}" alt="${p.name}">
                            <h4>${p.name}</h4> 
                            <p><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" minFractionDigits="0"/></p>
                            <div class="menu-buttons">
                                <a href="orderitem?action=add&productId=${p.id}" class="btn">Đặt món</a>
                                <button class="btn">Xem chi tiết</button>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <div class="menu-viewall reveal">
        <button class="btn-viewall" onclick="window.location.href='menu'">
            Xem tất cả
        </button>
    </div>
</section>

<section class="about-section reveal">
    <div class="about-container">
        <div class="about-image">
            <img src="images/about.jpg" alt="Không gian nhà hàng">
        </div>
        <div class="about-content">
            <h3 class="about-subtitle">GIỚI THIỆU</h3>
            <h2 class="about-title">LỰA CHỌN CHÚNG TÔI?</h2>
            <div class="about-feature">
                <i class="fa fa-utensils icon"></i>
                <div class="text">
                    <h4>Thực đơn phong phú</h4>
                    <p>Đa dạng món ăn cùng nhiều combo hấp dẫn, phục vụ mọi khẩu vị thực khách.</p>
                </div>
            </div>
            <div class="about-feature">
                <i class="fa fa-chair icon"></i>
                <div class="text">
                    <h4>Không gian rộng rãi</h4>
                    <p>Ấm cúng - Độc đáo - Thoải mái check-in. Có phòng riêng cho hội họp, sinh nhật.</p>
                </div>
            </div>
            <div class="about-feature">
                <i class="fa fa-heart icon"></i>
                <div class="text">
                    <h4>Phục vụ tận tâm</h4>
                    <p>Chu đáo - Tận tình - Hết mình vì khách hàng, mang lại trải nghiệm tốt nhất.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-column">
            <h3 class="footer-logo">HAH<span>.</span></h3>
            <p>A108 Adam Street<br>NY 535022, USA</p>
            <p><strong>Phone:</strong> 0865.787.333</p>
            <p><strong>Email:</strong> hah@gmail.com</p>
            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-youtube"></i></a>
                <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            </div>
        </div>
        <div class="footer-column">
            <h4>Liên kết</h4>
            <ul>
                <li><a href="home">Trang chủ</a></li>
                <li><a href="menu">Thực đơn</a></li>
                <li><a href="about.jsp">Giới thiệu</a></li>
                <li><a href="contact.jsp">Liên hệ</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h4>Hỗ trợ</h4>
            <ul>
                <li><a href="#">Điều khoản sử dụng</a></li>
                <li><a href="#">Hướng dẫn đặt bàn</a></li>
                <li><a href="#">Hướng dẫn đăng ký</a></li>
                <li><a href="#">Thẻ thành viên</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h4>Đăng ký nhận tin</h4>
            <p>Đăng ký để luôn cập nhật thông tin mới nhất về chúng tôi</p>
            <div class="subscribe">
                <input type="email" placeholder="Nhập email của bạn...">
                <button>Đăng ký</button>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 HAH Restaurant. All Rights Reserved.</p>
    </div>
</footer>

<div id="toast-container">
        <c:if test="${not empty flashSuccess}">
            <div id="toastNotificationSuccess" class="toast-item">
                <i class="fa-solid fa-circle-check"></i>
                <span>${flashSuccess}</span>
            </div>
        </c:if>
        
        <c:if test="${not empty flashError}">
            <div id="toastNotificationError" class="toast-item error">
                <i class="fa-solid fa-circle-info"></i>
                <span>${flashError}</span>
            </div>
        </c:if>
    </div>

<script>
    // Hàm reveal (Giữ nguyên)
    function reveal() {
        const reveals = document.querySelectorAll(".reveal");
        for (let i = 0; i < reveals.length; i++) {
            const windowHeight = window.innerHeight;
            const revealTop = reveals[i].getBoundingClientRect().top;
            const revealPoint = 100;
            if (revealTop < windowHeight - revealPoint) {
                reveals[i].classList.add("active");
            }
        }
    }
    window.addEventListener("scroll", reveal);
    reveal();

    // Hàm showCategory (Giữ nguyên)
    function showCategory(id, btn) {
        const categories = document.querySelectorAll(".menu-category");
        const buttons = document.querySelectorAll(".menu-btn");
        categories.forEach(cat => {
            cat.style.display = "none";
            cat.classList.remove("fadeIn");
        });
        const selectedCategory = document.getElementById(id);
        if (selectedCategory) {
            selectedCategory.style.display = "flex";
            selectedCategory.classList.add("fadeIn");
        }
        buttons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    }
    
    // === SỬA ĐỔI LOGIC KÍCH HOẠT ===
        document.addEventListener("DOMContentLoaded", () => {
            // Kích hoạt tab (code cũ của bạn)
            const firstCategoryLink = document.querySelector(".menu-sidebar li.active a");
            if (firstCategoryLink) {
                 showCategory('all', firstCategoryLink, null);
            }
            
            // Logic hiển thị TẤT CẢ thông báo (cả xanh và đỏ)
            const toasts = document.querySelectorAll(".toast-item");
            toasts.forEach((toast, index) => {
                // 1. Hiển thị (so le 100ms)
                setTimeout(() => {
                    toast.classList.add("show");
                }, 100 * (index + 1)); 

                // 2. Ẩn sau 5 giây
                setTimeout(() => {
                    toast.classList.remove("show");
                    setTimeout(() => { toast.remove(); }, 400); 
                }, 5000 + (100 * index)); 
            });
        });
</script>

</body>
</html>