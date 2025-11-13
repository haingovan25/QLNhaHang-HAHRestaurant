<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo đơn đặt bàn</title>

    <!-- CSS CHUNG -->
    <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>

    <!-- ICON -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            background: #f5f7fb;
            font-family: Segoe UI, sans-serif;
        }

        /* ==== MAIN CONTENT ==== */
        .main-content {
            margin-left: 260px;    /* khớp sidebar */
            margin-top: 80px;      /* khớp header */
            padding: 25px 40px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .form-box {
            background: #fff;
            padding: 28px;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            max-width: 780px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        .row-2 {
            display: flex;
            gap: 20px;
        }

        .submit-btn {
            background: #1a4ff7;
            color: white;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 15px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background: #0f38c8;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<%@ include file="sidebar.jsp" %>

<!-- HEADER -->
<%@ include file="header-admin.jsp" %>

<!-- MAIN CONTENT -->
<div class="main-content">

    <div class="page-title">Tạo đơn đặt bàn</div>

    <div class="form-box">

        <form action="#" method="post">

            <!-- Tên khách + Số điện thoại -->
            <div class="row-2">
                <div class="form-group" style="flex:1;">
                    <label>Họ tên khách hàng</label>
                    <input type="text" placeholder="Nhập họ tên...">
                </div>

                <div class="form-group" style="flex:1;">
                    <label>Số điện thoại</label>
                    <input type="text" placeholder="Nhập số điện thoại...">
                </div>
            </div>

            <!-- Thời gian -->
            <div class="row-2">
                <div class="form-group" style="flex:1;">
                    <label>Ngày đặt</label>
                    <input type="date">
                </div>

                <div class="form-group" style="flex:1;">
                    <label>Giờ (ví dụ: 8 - 10 giờ)</label>
                    <input type="text" placeholder="Nhập giờ...">
                </div>
            </div>

            <!-- Số khách -->
            <div class="form-group">
                <label>Số khách</label>
                <input type="number" min="1" placeholder="Nhập số khách...">
            </div>

            <!-- Khu vực -->
            <div class="form-group">
                <label>Khu vực</label>
                <select>
                    <option>Sảnh chính</option>
                    <option>Sảnh phụ</option>
                    <option>VIP</option>
                </select>
            </div>

            <!-- Bàn -->
            <div class="form-group">
                <label>Chọn bàn</label>
                <select>
                    <option>Bàn 1</option>
                    <option>Bàn 2</option>
                    <option>Bàn 3</option>
                </select>
            </div>

            <!-- Tiền cọc -->
            <div class="form-group">
                <label>Đặt cọc (nếu có)</label>
                <input type="text" placeholder="0 đ">
            </div>

            <button class="submit-btn">
                <i class="fa fa-check"></i> Xác nhận đặt bàn
            </button>

        </form>
    </div>

</div>

</body>
</html>
