<!-- ===== ADMIN HEADER (DÙNG CHUNG CHO TẤT CẢ TRANG ADMIN) ===== -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header class="header">

    <!-- Nút thu gọn sidebar -->
    <div class="menu-toggle">
        <i class="fa fa-bars"></i>
    </div>

    <!-- Ô tìm kiếm -->
    <div class="search">
        <input type="text" placeholder="Tìm kiếm...">
        <i class="fa fa-search"></i>
    </div>

    <!-- User -->
    <div class="user">
        <div class="user-info" id="userMenuToggle">
            <img src="https://i.imgur.com/4M34hi2.png" alt="avatar">
            <span>Quản trị viên <i class="fa fa-chevron-down"></i></span>
        </div>

        <ul class="dropdown-menu" id="userDropdown">
            <li><a href="#">Hồ sơ cá nhân</a></li>
            <li><a href="login.jsp">Đăng xuất</a></li>
        </ul>
    </div>

</header>

<!-- ==== SCRIPT CHUNG CHO HEADER ==== -->
<script>
/* Toggle sidebar (dùng chung tất cả trang) */
document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.querySelector(".menu-toggle");
    const sidebar = document.querySelector(".sidebar");
    const main = document.querySelector(".main");

    if (toggle && sidebar && main) {
        toggle.addEventListener("click", () => {
            sidebar.classList.toggle("hide");
            main.style.marginLeft = sidebar.classList.contains("hide") ? "0" : "260px";
        });
    }

    /* Toggle user dropdown */
    const userToggle = document.getElementById("userMenuToggle");
    const dropdown = document.getElementById("userDropdown");

    if (userToggle && dropdown) {
        userToggle.addEventListener("click", (e) => {
            e.stopPropagation();
            dropdown.classList.toggle("show");
        });

        document.addEventListener("click", () => dropdown.classList.remove("show"));
    }
});
</script>
