<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Qu?n lý bàn | HAH Admin</title>
    <link rel="stylesheet" href="admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="sidebar">
    <div class="logo">HAH<span> Admin</span></div>
    <ul>
        <li><a href="index.jsp"><i class="fa fa-home"></i> T?ng quan</a></li>
        <li><a href="tables.jsp" class="active"><i class="fa fa-chair"></i> Qu?n lý bàn</a></li>
        <li><a href="products.jsp"><i class="fa fa-utensils"></i> Món ?n</a></li>
        <li><a href="ingredients.jsp"><i class="fa fa-apple-whole"></i> Nguyên li?u</a></li>
        <li><a href="promotions.jsp"><i class="fa fa-gift"></i> Khuy?n mãi</a></li>
        <li><a href="orders.jsp"><i class="fa fa-file-invoice"></i> ??n hàng</a></li>
    </ul>
</div>

<div class="main">
    <h1>Danh sách bàn</h1>
    <table class="data-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên bàn</th>
            <th>Khu v?c</th>
            <th>S?c ch?a</th>
            <th>Tr?ng thái</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <tr><td>1</td><td>Bàn 101</td><td>T?ng 1</td><td>4</td><td><span class="status available">Available</span></td><td><button>S?a</button><button>Xóa</button></td></tr>
        <tr><td>2</td><td>Bàn 201</td><td>T?ng 2</td><td>8</td><td><span class="status occupied">Occupied</span></td><td><button>S?a</button><button>Xóa</button></td></tr>
        <tr><td>3</td><td>Phòng VIP 1</td><td>T?ng 2</td><td>10</td><td><span class="status reserved">Reserved</span></td><td><button>S?a</button><button>Xóa</button></td></tr>
        </tbody>
    </table>
</div>
</body>
</html>
