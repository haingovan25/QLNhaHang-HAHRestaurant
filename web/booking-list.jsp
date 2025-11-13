<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Lịch đặt bàn | Restaurant Admin</title>

  <!-- CSS CHUNG -->
  <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>

  <!-- ICON -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>

    body {
      margin: 0;
      padding: 0;
      background: #f5f7fb;
      font-family: Segoe UI, sans-serif;
    }

    /* ==== MAIN CONTENT ==== */
    .main-content {
      margin-left: 260px;      /* khớp sidebar */
      margin-top: 80px;        /* khớp header */
      padding: 25px 40px;
    }

    /* ==== HEADER SECTION ==== */
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

    .create-btn {
      background: #1a4ff7;
      color: #fff;
      border-radius: 8px;
      padding: 12px 20px;
      font-weight: 500;
      text-decoration: none;
      transition: all 0.3s;
    }

    .create-btn:hover {
      background: #0f38c8;
    }

    /* ==== BOOKING LIST GRID ==== */
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

    .actions {
      margin-top: 14px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .actions .btn {
      background: #fff;
      border: 1px solid #1a4ff7;
      color: #1a4ff7;
      border-radius: 8px;
      padding: 6px 14px;
      font-size: 13px;
      cursor: pointer;
    }

    .actions .btn:hover {
      background: #1a4ff7;
      color: white;
    }

  </style>
</head>

<body>

<!-- SIDEBAR -->
<%@ include file="sidebar.jsp" %>

<!-- HEADER ADMIN -->
<%@ include file="header-admin.jsp" %>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">

  <div class="dashboard-header">
    <h1>Lịch đặt bàn</h1>
    <a href="booking-create.jsp" class="create-btn">
      <i class="fa fa-plus"></i> Tạo đơn đặt bàn
    </a>
  </div>

  <!-- LIST -->
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
</div>

</body>
</html>
