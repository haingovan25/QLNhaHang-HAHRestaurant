<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt bàn</title>

    <!-- CSS CHUNG CỦA ADMIN -->
    <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>

    <!-- ICON -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            background: #f5f7fb;
            font-family: "Segoe UI", sans-serif;
        }

        /* ==== MAIN CONTENT ==== */
        .main-content {
            margin-left: 260px;        /* khớp sidebar */
            padding: 25px 40px;
            margin-top: 80px;          /* khớp header */
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        /* ==== WHITE BOX ==== */
        .content-box {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.06);
        }

        /* ==== TOP BUTTON ==== */
        .create-btn {
            background: #1a4ff7;
            color: #fff;
            padding: 10px 16px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .create-btn:hover { background: #0f38c8; }

        /* ==== TABS ==== */
        .tabs {
            display: flex;
            gap: 25px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 8px;
            margin-bottom: 20px;
        }

        .tabs a {
            font-size: 15px;
            color: #68717a;
            text-decoration: none;
            font-weight: 500;
            padding-bottom: 8px;
        }

        .tabs a.active {
            color: #1a4ff7;
            border-bottom: 2px solid #1a4ff7;
            font-weight: 600;
        }

        /* ==== FILTER ==== */
        .filter-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .filter-row input, 
        .filter-row select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        /* ==== TABLE ==== */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f2f5f9;
            padding: 14px;
            text-align: left;
            font-weight: 600;
            color: #495057;
        }

        td {
            padding: 16px 14px;
            border-bottom: 1px solid #eee;
        }

        tr:hover { background: #f9fbff; }

        /* ==== STATUS ==== */
        .status {
            padding: 6px 14px;
            border-radius: 16px;
            font-weight: 600;
            font-size: 13px;
        }

        .st-success { background: #d4edda; color: #1e7e34; }
        .st-wait { background: #ffeeba; color: #8a6d3b; }

        /* ==== DETAIL BUTTON ==== */
        .btn-detail {
            background: #198754;
            color: white;
            padding: 7px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
        }
    </style>
</head>

<body>

<!-- ========== SIDEBAR ========= -->
<%@ include file="sidebar.jsp" %>

<!-- ========== HEADER ========= -->
<%@ include file="header-admin.jsp" %>


<!-- ========== PAGE CONTENT ========= -->
<div class="main-content">

    <div class="page-title">Lịch sử đặt bàn</div>

    <div class="content-box">

        <a href="booking-create.jsp" class="create-btn">
            <i class="fa fa-plus"></i> Tạo đơn đặt bàn
        </a>

        <!-- Tabs -->
        <div class="tabs">
            <a class="active">Tất cả</a>
            <a>Chưa nhận bàn</a>
            <a>Đã nhận bàn</a>
            <a>Đã hủy</a>
            <a>Đã hoàn thành</a>
        </div>

        <!-- Filter -->
        <div class="filter-row">
            <div>
                Hiển thị 
                <select>
                    <option>10</option>
                    <option>25</option>
                    <option>50</option>
                </select>
            </div>

            <input type="text" placeholder="Nhập từ khóa tìm kiếm...">
        </div>

        <!-- TABLE -->
        <table>
            <thead>
            <tr>
                <th>Dự kiến nhận bàn</th>
                <th>Khách hàng</th>
                <th>Đặt cọc</th>
                <th>Số khách</th>
                <th>Khu vực/Bàn</th>
                <th>Trạng thái</th>
                <th></th>
            </tr>
            </thead>

            <tbody>
            <tr>
                <td>02/06/2023 (8 - 10 giờ)</td>
                <td>Hồ Anh Hòa <br> 0865787333</td>
                <td>0 đ</td>
                <td>3</td>
                <td>Sảnh chính, bàn 2</td>
                <td><span class="status st-success">Đã hoàn thành</span></td>
                <td><a class="btn-detail">Chi tiết</a></td>
            </tr>

            <tr>
                <td>02/06/2023 (8 - 10 giờ)</td>
                <td>Hồ Anh Hòa <br> 0865787333</td>
                <td>0 đ</td>
                <td>3</td>
                <td>Sảnh phụ, bàn 1</td>
                <td><span class="status st-wait">Chưa nhận bàn</span></td>
                <td><a class="btn-detail">Chi tiết</a></td>
            </tr>

            <tr>
                <td>02/06/2023 (10 - 12 giờ)</td>
                <td>Nguyễn Văn Tài <br> 0912345678</td>
                <td>50.000 đ</td>
                <td>4</td>
                <td>VIP, bàn 3</td>
                <td><span class="status st-wait">Chưa nhận bàn</span></td>
                <td><a class="btn-detail">Chi tiết</a></td>
            </tr>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>
