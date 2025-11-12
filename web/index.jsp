<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng điều khiển | HAH Restaurant</title>
    <link rel="stylesheet" href="admin.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="sidebar">
    <div class="logo">HAH<span> Admin</span></div>
    <ul>
        <li><a href="index.jsp" class="active"><i class="fa fa-home"></i> Tổng quan</a></li>
        <li><a href="tables.jsp"><i class="fa fa-chair"></i> Quản lý bàn</a></li>
        <li><a href="products.jsp"><i class="fa fa-utensils"></i> Món ăn</a></li>
        <li><a href="ingredients.jsp"><i class="fa fa-apple-whole"></i> Nguyên liệu</a></li>
        <li><a href="promotions.jsp"><i class="fa fa-gift"></i> Khuyến mãi</a></li>
        <li><a href="orders.jsp"><i class="fa fa-file-invoice"></i> Đơn hàng</a></li>
    </ul>
</div>

<div class="main">
    <h1>Bảng điều khiển quản trị</h1>
    <div class="cards">
        <div class="card">
            <h3>🪑 Bàn</h3><p>12 bàn</p>
        </div>
        <div class="card">
            <h3>🍽️ Món ăn</h3><p>45 món</p>
        </div>
        <div class="card">
            <h3>🎁 Khuyến mãi</h3><p>5 mã đang hoạt động</p>
        </div>
        <div class="card">
            <h3>📦 Nguyên liệu</h3><p>23 loại nguyên liệu</p>
        </div>
    </div>
</div>
</body>
</html>
