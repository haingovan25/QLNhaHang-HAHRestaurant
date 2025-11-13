<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Khai báo DUY NHẤT một lần
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
    <li class="<%= current.contains("orders.jsp") ? "active" : "" %>">
      <a href="<%=ctx%>/orders.jsp">
        <i class="fa-solid fa-file-invoice"></i>
        <span>Hóa đơn</span>
      </a>
    </li>

    <!-- Đặt bàn -->
    <li class="has-sub <%= (current.contains("table-layout.jsp") 
                           || current.contains("booking-list.jsp")
                           || current.contains("booking-create.jsp")
                           || current.contains("booking-history.jsp")) ? "open" : "" %>">
      <a href="#">
        <i class="fa-solid fa-chair"></i>
        <span>Đặt bàn</span>
        <i class="fa fa-angle-right"></i>
      </a>

      <ul class="submenu" style="<%= (current.contains("table-layout.jsp") 
                                   || current.contains("booking-list.jsp")
                                   || current.contains("booking-create.jsp")
                                   || current.contains("booking-history.jsp")) 
                                   ? "display:block;" : "" %>">

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

<!-- CSS + JS giữ nguyên -->
