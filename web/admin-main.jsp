<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Dashboard | Restaurant Admin</title>
  <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
  /* ==== USER DROPDOWN ==== */
  .user {
    position: relative;
    cursor: pointer;
  }

  .user-info {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .user-info span {
    color: #333;
    font-weight: 500;
  }

  .user-info i {
    font-size: 12px;
    color: #777;
  }

  .dropdown-menu {
    position: absolute;
    top: 50px;
    right: 0;
    background: #fff;
    border: 1px solid #e6ebf5;
    border-radius: 6px;
    list-style: none;
    padding: 8px 0;
    width: 160px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    display: none;
    z-index: 20;
  }

  .dropdown-menu.show {
    display: block;
  }

  .dropdown-menu li a {
    display: block;
    padding: 10px 16px;
    color: #333;
    text-decoration: none;
    font-size: 14px;
  }

  .dropdown-menu li a:hover {
    background: #f6f9ff;
    color: #1a4ff7;
  }
  </style>
</head>

<body>
<div class="layout">
  <!-- SIDEBAR -->
  <%@ include file="sidebar.jsp" %>


  <!-- MAIN -->
  <main class="main">
    <%@ include file="header-admin.jsp" %>

    <section class="dashboard">
      <h1>Dashboard</h1>
      <div class="filters">
        <button>Hôm nay</button>
        <button>Tháng này</button>
        <button>Năm nay</button>
        <button class="active">Tất cả</button>
      </div>

      <div class="cards">
        <div class="card">
          <i class="fa fa-cart-shopping purple"></i>
          <div><p>Hóa đơn</p><h2>24</h2></div>
        </div>
        <div class="card">
          <i class="fa fa-dollar-sign green"></i>
          <div><p>Doanh thu</p><h2>15.600.000 ₫</h2></div>
        </div>
        <div class="card">
          <i class="fa fa-users orange"></i>
          <div><p>Khách hàng</p><h2>11</h2></div>
        </div>
      </div>

      <div class="chart-box">
        <h3>Tất cả</h3>
        <canvas id="chart"></canvas>
      </div>
    </section>
  </main>
</div>

<script>
/* Chart.js */
const ctx = document.getElementById('chart').getContext('2d');
new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['24 Apr', '01 May', '08 May', '16 May', '23 May'],
    datasets: [
      {
        label: 'Doanh thu',
        data: [1000000, 2000000, 4800000, 3500000, 2200000],
        borderColor: '#4c7cf3',
        backgroundColor: 'rgba(76,124,243,0.1)',
        fill: true, tension: 0.4
      },
      {
        label: 'Lợi nhuận',
        data: [500000, 1000000, 2400000, 1800000, 1200000],
        borderColor: '#2ecc71',
        backgroundColor: 'rgba(46,204,113,0.1)',
        fill: true, tension: 0.4
      }
    ]
  },
  options: {
    plugins: { legend: { position: 'bottom' } },
    scales: { y: { beginAtZero: true } }
  }
});

/* Sidebar toggle submenu */
        document.querySelectorAll(".has-sub > a").forEach(link => {
          link.addEventListener("click", e => {
            // chỉ chặn nếu bấm vào menu cha, không chặn các link con
            const submenu = link.parentElement.querySelector(".submenu");
            if (submenu) {
              e.preventDefault();
              submenu.classList.toggle("open");
              const icon = link.querySelector(".fa-angle-right, .fa-angle-down");
              if (icon) {
                icon.classList.toggle("fa-angle-down");
                icon.classList.toggle("fa-angle-right");
              }
            }
          });
        });



/* Toggle sidebar */
const toggle = document.querySelector(".menu-toggle");
const sidebar = document.querySelector(".sidebar");
const main = document.querySelector(".main");

toggle.addEventListener("click", () => {
  sidebar.classList.toggle("hide");
  if (sidebar.classList.contains("hide")) {
    main.style.marginLeft = "0";
  } else {
    main.style.marginLeft = "260px";
  }
});

/* Toggle user dropdown */
const userMenuToggle = document.getElementById("userMenuToggle");
const userDropdown = document.getElementById("userDropdown");

userMenuToggle.addEventListener("click", (e) => {
  e.stopPropagation();
  userDropdown.classList.toggle("show");
});

// Ẩn dropdown khi click ra ngoài
document.addEventListener("click", () => {
  userDropdown.classList.remove("show");
});
</script>
</body>
</html>
