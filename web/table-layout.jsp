<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Sơ đồ bàn | Restaurant Admin</title>
  <link rel="stylesheet" href="css/admin-main.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    /* ====== PHẦN SƠ ĐỒ BÀN ====== */
    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 25px;
    }

    .dashboard-header h1 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
    }

    .layout-content {
      display: flex;
      gap: 20px;
      margin-top: 10px;
    }

    /* KHU VỰC DANH SÁCH KHU VỰC */
    .area-list {
      background: #fff;
      border-radius: 12px;
      padding: 16px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
      flex: 0 0 240px;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .area-item {
      padding: 12px 15px;
      border-radius: 8px;
      border: 1px solid #e0e0e0;
      background: #fff;
      color: #333;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: 0.2s;
    }

    .area-item i {
      color: #1a4ff7;
    }

    .area-item.active {
      background: #e9f0ff;
      border-color: #1a4ff7;
      color: #1a4ff7;
    }

    .area-item:hover {
      background: #f6f8ff;
    }

    /* KHU VỰC DANH SÁCH BÀN */
    .table-list {
      flex: 1;
      background: #fff;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 20px;
      align-content: flex-start;
    }

    .table-card {
      border: 1px solid #eee;
      border-radius: 10px;
      padding: 15px;
      text-align: center;
      background: #fff8e6;
      color: #333;
      transition: 0.25s;
      cursor: pointer;
    }

    .table-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 3px 6px rgba(0,0,0,0.08);
    }

    .table-card .table-number {
      background: #ffc107;
      border-radius: 6px;
      color: #000;
      font-weight: 700;
      font-size: 18px;
      width: 40px;
      height: 40px;
      line-height: 40px;
      margin: 0 auto 6px;
    }

    .table-card .table-status {
      font-size: 14px;
      color: #666;
    }

    /* FOOTER */
    .footer {
      text-align: center;
      color: #888;
      font-size: 13px;
      margin-top: 25px;
    }
    .footer a {
      color: #1a4ff7;
      text-decoration: none;
    }
  </style>
</head>

<body>
<div class="layout">
  <!-- ===== SIDEBAR ===== -->
  <%@ include file="sidebar.jsp" %>


  <!-- ===== MAIN CONTENT ===== -->
  <main class="main">
    <header class="header">
      <div class="menu-toggle"><i class="fa fa-bars"></i></div>
      <div class="search">
        <input type="text" placeholder="Tìm kiếm...">
        <i class="fa fa-search"></i>
      </div>

      <div class="user">
        <div class="user-info" id="userMenuToggle">
          <img src="https://i.imgur.com/4M34hi2.png" alt="avatar">
          <span>Hồ Anh Hòa <i class="fa fa-chevron-down"></i></span>
        </div>

        <ul class="dropdown-menu" id="userDropdown">
          <li><a href="#">Hồ sơ cá nhân</a></li>
          <li><a href="admin-login.jsp">Đăng xuất</a></li>
        </ul>
      </div>
    </header>

    <!-- ====== SƠ ĐỒ BÀN ====== -->
    <section class="dashboard">
      <div class="dashboard-header">
        <h1>Sơ đồ bàn</h1>
      </div>

      <div class="layout-content">
        <!-- DANH SÁCH KHU VỰC -->
        <div class="area-list">
          <div class="area-item active">
            <i class="fa fa-location-dot"></i> Sảnh chính
          </div>
          <div class="area-item">
            <i class="fa fa-tree"></i> Sân ngoài
          </div>
        </div>

        <!-- DANH SÁCH BÀN -->
        <div class="table-list">
          <div class="table-card">
            <div class="table-number">1</div>
            <div class="table-status">Bàn trống</div>
          </div>
          <div class="table-card">
            <div class="table-number">2</div>
            <div class="table-status">Bàn trống</div>
          </div>
          <div class="table-card">
            <div class="table-number">3</div>
            <div class="table-status">Bàn trống</div>
          </div>
          <div class="table-card">
            <div class="table-number">4</div>
            <div class="table-status">Bàn trống</div>
          </div>
          <div class="table-card">
            <div class="table-number">5</div>
            <div class="table-status">Bàn trống</div>
          </div>
        </div>
      </div>

      <div class="footer">
        © Copyright <b>HAH - Admin</b>. All Rights Reserved <br>
        Designed by <a href="#">HAH</a>
      </div>
    </section>
  </main>
</div>

<!-- ===== JS FUNCTIONALITY ===== -->
<script>
// Sidebar toggle
document.querySelector(".menu-toggle").addEventListener("click", () => {
  document.querySelector(".sidebar").classList.toggle("hide");
});

// Submenu toggle
document.querySelectorAll(".has-sub > a").forEach(link => {
  link.addEventListener("click", e => {
    e.preventDefault();
    const parent = link.parentElement;
    const submenu = parent.querySelector(".submenu");
    const icon = link.querySelector(".fa-angle-right, .fa-angle-down");
    parent.classList.toggle("active");
    submenu.classList.toggle("open");
    if (icon) {
      icon.classList.toggle("fa-angle-down");
      icon.classList.toggle("fa-angle-right");
    }
  });
});

// Dropdown user
const userToggle = document.getElementById("userMenuToggle");
const userDropdown = document.getElementById("userDropdown");
userToggle.addEventListener("click", (e) => {
  e.stopPropagation();
  userDropdown.classList.toggle("show");
});
document.addEventListener("click", () => userDropdown.classList.remove("show"));

// Kích hoạt khu vực
document.querySelectorAll(".area-item").forEach(item => {
  item.addEventListener("click", () => {
    document.querySelectorAll(".area-item").forEach(i => i.classList.remove("active"));
    item.classList.add("active");
  });
});
</script>
</body>
</html>
