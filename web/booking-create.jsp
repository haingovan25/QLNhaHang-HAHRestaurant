<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thêm mới lịch đặt bàn | Restaurant Admin</title>
  <link rel="stylesheet" href="css/admin-main.css">
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body { margin: 0; font-family: Arial, sans-serif; background: #f8f9fc; }
    .layout { display: flex; }

    /* Giữ nguyên sidebar */
    .sidebar {
      width: 250px; background: #fff; border-right: 1px solid #e5e5e5;
      height: 100vh; position: fixed; left: 0; top: 0; overflow-y: auto;
    }

    .main { margin-left: 250px; flex: 1; padding: 20px; }

    /* Header */
    .header {
      display: flex; justify-content: space-between; align-items: center;
      background: #fff; padding: 10px 20px; border-radius: 10px;
      box-shadow: 0 1px 4px rgba(0,0,0,0.1); margin-bottom: 25px;
    }
    .search input { border: 1px solid #ddd; padding: 6px 10px; border-radius: 8px; }

    /* Form layout */
    .booking-form {
      background: white;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      margin-bottom: 30px;
    }

    .form-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      font-weight: 600;
      margin-bottom: 6px;
      color: #333;
    }

    .form-group input, .form-group select, .form-group textarea {
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 10px;
      font-size: 14px;
      outline: none;
      transition: 0.2s;
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
      border-color: #1a4ff7;
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-top: 20px;
    }

    .btn {
      border: none;
      padding: 10px 20px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: 0.3s;
    }

    .btn-save { background: #1a4ff7; color: white; }
    .btn-save:hover { background: #0f38c8; }
    .btn-cancel { background: #f1f1f1; color: #333; }
    .btn-cancel:hover { background: #ddd; }

    /* Bảng mặt hàng */
    table {
      width: 100%; border-collapse: collapse; background: white;
      border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.05);
    }

    th, td {
      padding: 12px 15px; border-bottom: 1px solid #eee;
      font-size: 14px; text-align: left;
    }

    th { background: #f7f7f7; color: #333; }
    tr:hover { background: #f9f9f9; }

    .plus-btn {
      width: 38px; height: 38px;
      background: #1a4ff7; border-radius: 50%;
      color: white; font-size: 20px; text-align: center; line-height: 38px;
      cursor: pointer; margin: 20px auto; display: block;
    }
  </style>
</head>

<body>
<div class="layout">
  <!-- Sidebar -->
  <%@ include file="sidebar.jsp" %>

  <!-- Main -->
  <main class="main">
    <header class="header">
      <div class="menu-toggle"><i class="fa fa-bars"></i></div>
      <div class="search">
        <input type="text" placeholder="Tìm kiếm...">
        <i class="fa fa-search"></i>
      </div>
      <div class="user">
        <div class="user-info" id="userMenuToggle">
          <img src="https://i.imgur.com/4M34hi2.png" alt="avatar" style="width:28px;height:28px;border-radius:50%;">
          <span>Hồ Anh Hòa <i class="fa fa-chevron-down"></i></span>
        </div>
        <ul class="dropdown-menu" id="userDropdown">
          <li><a href="#">Hồ sơ cá nhân</a></li>
          <li><a href="admin-login.jsp">Đăng xuất</a></li>
        </ul>
      </div>
    </header>

    <section class="booking-form">
      <h2>Thêm mới lịch đặt bàn</h2>
      <form action="#" method="post">
        <div class="form-grid">
          <div class="form-group">
            <label>Họ tên khách hàng <span style="color:red;">*</span></label>
            <input type="text" name="customer_name" placeholder="Nhập họ và tên">
          </div>
          <div class="form-group">
            <label>Số điện thoại <span style="color:red;">*</span></label>
            <input type="text" name="phone" placeholder="Nhập số điện thoại">
          </div>
          <div class="form-group">
            <label>Địa chỉ</label>
            <input type="text" name="address" placeholder="Nhập địa chỉ">
          </div>
          <div class="form-group">
            <label>Số lượng khách <span style="color:red;">*</span></label>
            <input type="number" name="guests" placeholder="Nhập số khách">
          </div>
          <div class="form-group">
            <label>Ngày nhận bàn <span style="color:red;">*</span></label>
            <input type="date" name="date">
          </div>
          <div class="form-group">
            <label>Giờ nhận bàn</label>
            <select name="time">
              <option>---Khung giờ---</option>
              <option>8:00 - 10:00</option>
              <option>10:00 - 12:00</option>
              <option>12:00 - 14:00</option>
              <option>18:00 - 20:00</option>
            </select>
          </div>
          <div class="form-group">
            <label>Chọn trước bàn</label>
            <select name="table">
              <option>--Chọn bàn--</option>
              <option>Bàn 1</option>
              <option>Bàn 2</option>
              <option>Bàn 3</option>
            </select>
          </div>
          <div class="form-group">
            <label>Ghi chú</label>
            <textarea rows="3" name="note" placeholder="Nhập ghi chú..."></textarea>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="btn btn-cancel" onclick="window.history.back()">Hủy</button>
          <button type="submit" class="btn btn-save">Lưu đơn</button>
        </div>
      </form>
    </section>

    <section>
      <h3>Mặt hàng đặt trước</h3>
      <table>
        <thead>
          <tr>
            <th>Tên mặt hàng</th>
            <th>Giá bán</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
          </tr>
        </thead>
        <tbody id="orderItems">
          <tr><td colspan="4" style="text-align:center;">Chưa có mặt hàng nào</td></tr>
        </tbody>
      </table>
      <div class="plus-btn"><i class="fa fa-plus"></i></div>
    </section>

  </main>
</div>

<!-- JS giữ nguyên layout -->
<script>
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
</script>
</body>
</html>
