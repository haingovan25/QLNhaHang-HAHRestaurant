<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String current = request.getRequestURI();
    String ctx = request.getContextPath();
%>

<!-- ===== SIDEBAR START ===== -->
<aside class="sidebar">
  <div class="brand">
    <i class="fa-solid fa-utensils"></i>
    <span>Administration</span>
  </div>

  <ul class="menu">
    <!-- Thống kê -->
    <li class="<%= current.contains("admin-main.jsp") ? "active" : "" %>">
      <a href="<%=ctx%>/admin-main.jsp">
        <i class="fa-solid fa-chart-line"></i>
        <span>Thống kê</span>
      </a>
    </li>

    <!-- Hóa đơn -->
    <li class="<%= current.contains("invoice") ? "active" : "" %>">
      <a href="#">
        <i class="fa-solid fa-file-invoice"></i>
        <span>Hóa đơn</span>
      </a>
    </li>

    <!-- Đặt bàn -->
    <li class="has-sub <%= (current.contains("booking") || current.contains("table-layout.jsp")) ? "open" : "" %>">
      <a href="#">
        <i class="fa-solid fa-chair"></i>
        <span>Đặt bàn</span>
        <i class="fa fa-angle-down"></i>
      </a>
      <ul class="submenu" style="<%= (current.contains("booking") || current.contains("table-layout.jsp")) ? "display:block;" : "" %>">
        <li class="<%= current.contains("table-layout.jsp") ? "active" : "" %>">
          <a href="<%=ctx%>/table-layout.jsp">Sơ đồ bàn</a>
        </li>
        <li class="<%= current.contains("booking-list.jsp") ? "active" : "" %>">
          <a href="<%=ctx%>/booking-list.jsp">Lịch đặt bàn</a>
        </li>
        <li class="<%= current.contains("booking-create.jsp") ? "active" : "" %>">
          <a href="<%=ctx%>/booking-create.jsp">Tạo đơn đặt bàn</a>
        </li>
        <li class="<%= current.contains("booking-history.jsp") ? "active" : "" %>">
          <a href="<%=ctx%>/booking-history.jsp">Lịch sử đặt bàn</a>
        </li>
      </ul>
    </li>

    <!-- Mặt hàng -->
    <li class="has-sub">
      <a href="#">
        <i class="fa-solid fa-box"></i>
        <span>Mặt hàng</span>
        <i class="fa fa-angle-right"></i>
      </a>
      <ul class="submenu">
        <li><a href="#">Danh sách mặt hàng</a></li>
        <li><a href="#">Danh mục</a></li>
      </ul>
    </li>

    <!-- Thực đơn -->
    <li>
      <a href="#">
        <i class="fa-solid fa-utensils"></i>
        <span>Thực đơn</span>
      </a>
    </li>

    <!-- Combo -->
    <li>
      <a href="#">
        <i class="fa-solid fa-layer-group"></i>
        <span>Combo</span>
      </a>
    </li>

    <!-- Nhân viên -->
    <li class="has-sub">
      <a href="#">
        <i class="fa-solid fa-user-tie"></i>
        <span>Nhân viên</span>
        <i class="fa fa-angle-right"></i>
      </a>
      <ul class="submenu">
        <li><a href="#">Danh sách nhân viên</a></li>
        <li><a href="#">Phân quyền</a></li>
      </ul>
    </li>

    <!-- Khách hàng -->
    <li class="has-sub">
      <a href="#">
        <i class="fa-solid fa-users"></i>
        <span>Khách hàng</span>
        <i class="fa fa-angle-right"></i>
      </a>
      <ul class="submenu">
        <li><a href="#">Danh sách khách hàng</a></li>
        <li><a href="#">Phản hồi</a></li>
      </ul>
    </li>

    <!-- Hệ thống -->
    <li class="has-sub">
      <a href="#">
        <i class="fa-solid fa-gear"></i>
        <span>Hệ thống</span>
        <i class="fa fa-angle-right"></i>
      </a>
      <ul class="submenu">
        <li><a href="#">Cấu hình hệ thống</a></li>
        <li><a href="#">Phân quyền truy cập</a></li>
      </ul>
    </li>

    <!-- Thiết lập nhà hàng -->
    <li>
      <a href="#">
        <i class="fa-solid fa-store"></i>
        <span>Thiết lập nhà hàng</span>
      </a>
    </li>
  </ul>
</aside>
<!-- ===== SIDEBAR END ===== -->

<!-- ===== CSS (giữ nguyên phong cách của booking-list.jsp) ===== -->
<style>
  .sidebar {
    background: #fff;
    width: 240px;
    height: 100vh;
    border-right: 1px solid #eaeaea;
    position: fixed;
    top: 0;
    left: 0;
    overflow-y: auto;
    padding: 20px 0;
  }

  .sidebar .brand {
    display: flex;
    align-items: center;
    font-size: 22px;
    font-weight: bold;
    color: #1a4ff7;
    padding: 0 25px;
    margin-bottom: 20px;
  }

  .sidebar .brand i {
    margin-right: 10px;
  }

  .sidebar .menu {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .sidebar .menu li a {
    display: flex;
    align-items: center;
    padding: 10px 25px;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    gap: 10px;
    transition: 0.3s;
  }

  .sidebar .menu li a:hover,
  .sidebar .menu li.active > a {
    color: #1a4ff7;
    background: #f1f5ff;
  }

  .sidebar .menu li.active > a i {
    color: #1a4ff7;
  }

  .sidebar .has-sub > a {
    justify-content: space-between;
  }

  .submenu {
    display: none;
    list-style: none;
    padding-left: 45px;
    margin: 0;
  }

  .submenu li a {
    font-size: 14px;
    padding: 6px 0;
    color: #555;
  }

  .submenu li.active a {
    color: #1a4ff7;
    font-weight: 600;
  }

  .has-sub.open > .submenu {
    display: block;
  }
  /* Khi mục đang được chọn (submenu hoặc menu chính) */
.sidebar .menu li.active > a,
.sidebar .submenu li.active > a {
  background: #f1f5ff;
  color: #1a4ff7;
  font-weight: 600;
  position: relative;
}

/* Thanh kẻ xanh bên trái (mũi highlight) */
.sidebar .submenu li.active > a::before,
.sidebar .menu li.active > a::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 3px;
  height: 100%;
  background: #1a4ff7;
  border-radius: 0 2px 2px 0;
}

</style>

<!-- ===== SCRIPT DROPDOWN ===== -->
<script>
document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll(".has-sub > a").forEach(link => {
    link.addEventListener("click", e => {
      e.preventDefault();
      const parent = link.parentElement;
      parent.classList.toggle("open");
      const submenu = parent.querySelector(".submenu");
      if (submenu) submenu.style.display = submenu.style.display === "block" ? "none" : "block";
    });
  });
});
</script>
