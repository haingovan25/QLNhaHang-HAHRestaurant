<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Lịch đặt bàn | Restaurant Admin</title>
  <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    /* ===== BOOKING SECTION ===== */
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

    .dashboard-header button {
      background: #1a4ff7;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 10px 18px;
      font-size: 14px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .dashboard-header button:hover {
      background: #0f38c8;
    }

    /* ===== BOOKING LIST ===== */
    .booking-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
      gap: 20px;
    }

    .booking-card {
      background: white;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: all 0.25s ease;
    }

    .booking-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    }

    .booking-card h3 {
      font-size: 16px;
      font-weight: 600;
      color: #1a1a1a;
      margin-bottom: 8px;
    }

    .booking-card p {
      margin: 4px 0;
      color: #555;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .booking-card .actions {
      margin-top: 14px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .booking-card .actions .btn {
      background: #fff;
      border: 1px solid #1a4ff7;
      color: #1a4ff7;
      border-radius: 8px;
      padding: 6px 14px;
      font-size: 13px;
      cursor: pointer;
      transition: 0.2s;
    }

    .booking-card .actions .btn:hover {
      background: #1a4ff7;
      color: white;
    }
    .dashboard {
  display: flex;
  gap: 30px;
  align-items: flex-start;
}

/* Cột danh sách đặt bàn (bên phải) */
.booking-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
  flex: 1;
}

/* Phần nút “Tạo đơn đặt bàn” ở bên trái */
.dashboard-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  gap: 20px;
  width: 250px;
  padding-top: 20px;
}

.create-btn {
  background: #1a4ff7;
  color: #fff;
  border-radius: 8px;
  padding: 12px 20px;
  font-weight: 500;
  text-decoration: none;
  text-align: center;
  display: inline-block;
  transition: all 0.3s;
}
.create-btn:hover {
  background: #0f38c8;
}

/* Thẻ đặt bàn */
.booking-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  transition: 0.2s;
}
.booking-card:hover {
  transform: translateY(-2px);
}
.booking-card h3 {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 8px;
}
.booking-card p {
  color: #444;
  margin: 4px 0;
  display: flex;
  align-items: center;
  gap: 8px;
}
.booking-card .actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}
.booking-card .actions .btn {
  background: #fff;
  border: 1px solid #1a4ff7;
  color: #1a4ff7;
  border-radius: 8px;
  padding: 6px 14px;
  cursor: pointer;
}
.booking-card .actions .btn:hover {
  background: #1a4ff7;
  color: #fff;
}

  </style>
  
</head>

<body>
<div class="layout">
  <!-- ===== SIDEBAR ===== -->
  <aside class="sidebar">
    <div class="brand">
      <i class="fa-solid fa-utensils"></i>
      <span>Administration</span>
    </div>

    <ul class="menu">
      <li><a href="admin-main.jsp"><i class="fa fa-chart-line"></i> Thống kê</a></li>
      <li><a href="#"><i class="fa fa-file-invoice"></i> Hóa đơn</a></li>

      <li class="has-sub active">
        <a href="#"><i class="fa fa-chair"></i> Đặt bàn <i class="fa fa-angle-down"></i></a>
        <ul class="submenu open">
          <li><a href="#">Sơ đồ bàn</a></li>
          <li class="active"><a href="booking-list.jsp">Lịch đặt bàn</a></li>
          <li><a href="#">Lịch sử đặt bàn</a></li>
        </ul>
      </li>

      <li class="has-sub">
        <a href="#"><i class="fa fa-box"></i> Mặt hàng <i class="fa fa-angle-right"></i></a>
        <ul class="submenu">
          <li><a href="#">Danh sách mặt hàng</a></li>
          <li><a href="#">Danh mục</a></li>
        </ul>
      </li>

      <li><a href="#"><i class="fa fa-utensils"></i> Thực đơn</a></li>
      <li><a href="#"><i class="fa fa-layer-group"></i> Combo</a></li>

      <li class="has-sub">
        <a href="#"><i class="fa fa-user-tie"></i> Nhân viên <i class="fa fa-angle-right"></i></a>
        <ul class="submenu">
          <li><a href="#">Danh sách nhân viên</a></li>
          <li><a href="#">Phân quyền</a></li>
        </ul>
      </li>

      <li class="has-sub">
        <a href="#"><i class="fa fa-users"></i> Khách hàng <i class="fa fa-angle-right"></i></a>
        <ul class="submenu">
          <li><a href="#">Danh sách khách hàng</a></li>
          <li><a href="#">Phản hồi</a></li>
        </ul>
      </li>

      <li class="has-sub">
        <a href="#"><i class="fa fa-gear"></i> Hệ thống <i class="fa fa-angle-right"></i></a>
        <ul class="submenu">
          <li><a href="#">Cấu hình hệ thống</a></li>
          <li><a href="#">Phân quyền truy cập</a></li>
        </ul>
      </li>

      <li><a href="#"><i class="fa fa-store"></i> Thiết lập nhà hàng</a></li>
    </ul>
  </aside>

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

    <!-- ===== LỊCH ĐẶT BÀN ===== -->
    <section class="dashboard">
      <div class="dashboard-header">
        <h1>Lịch đặt bàn</h1>
        <a href="booking-create.jsp" class="create-btn">
            <i class="fa fa-plus"></i> Tạo đơn đặt bàn
          </a>

          <style>
          .create-btn {
            display: inline-block;
            background: #1a4ff7;
            color: #fff;
            border-radius: 8px;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: 0.3s;
          }
          .create-btn:hover { background: #0f38c8; }
          </style>


      <div class="booking-list">
        <!-- CARD 1 -->
        <div class="booking-card">
          <h3>Hồ Anh Hòa - 0865787333</h3>
          <p><i class="fa fa-clock"></i> 8 - 10 giờ &nbsp; | &nbsp; <i class="fa fa-users"></i> 4 người</p>
          <p><i class="fa fa-money-bill-wave"></i> 425.000 ₫</p>
          <div class="actions">
            <span><i class="fa fa-gift"></i> 0 đ</span>
            <button class="btn">Khách nhận bàn</button>
          </div>
        </div>

        <!-- CARD 2 -->
        <div class="booking-card">
          <h3>Nguyễn Minh - 0988999777</h3>
          <p><i class="fa fa-clock"></i> 12 - 14 giờ &nbsp; | &nbsp; <i class="fa fa-users"></i> 2 người</p>
          <p><i class="fa fa-money-bill-wave"></i> 680.000 ₫</p>
          <div class="actions">
            <span><i class="fa fa-gift"></i> 30.000 đ</span>
            <button class="btn">Khách nhận bàn</button>
          </div>
        </div>
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
</script>
</body>
</html>
