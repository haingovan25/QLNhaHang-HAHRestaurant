<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo đơn đặt bàn</title>

    <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            background: #f5f7fb;
            font-family: Segoe UI, sans-serif;
        }

        .main-content {
            padding: 25px 40px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #1a1a1a;
        }

        .form-box {
            background: #fff;
            padding: 28px 35px;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        input[type="text"],
        input[type="tel"],
        input[type="date"],
        input[type="time"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }

        input:focus, select:focus {
            border-color: #1a4ff7;
            box-shadow: 0 0 0 3px rgba(26, 79, 247, 0.1);
            outline: none;
        }

        .row-2 {
            display: flex;
            gap: 20px;
        }

        .row-2 > .form-group {
            flex: 1;
        }

        .submit-btn {
            background: #1a4ff7;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 15px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .submit-btn:hover {
            background: #0f38c8;
            transform: translateY(-2px);
        }

        .error-message {
            color: #dc3545;
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <!-- PHẢI ĐẶT HEADER TRONG .main -->
    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="page-title">Tạo đơn đặt bàn</div>

            <div class="form-box">

                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <form action="admin-booking-create" method="POST">

                    <div class="row-2">
                        <div class="form-group">
                            <label for="customerName">Họ tên khách hàng</label>
                            <input type="text" id="customerName" name="customerName" placeholder="Nhập họ tên..." required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Số điện thoại</label>
                            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại..." required>
                        </div>
                    </div>

                    <div class="row-2">
                        <div class="form-group">
                            <label for="bookingDate">Ngày đặt</label>
                            <input type="date" id="bookingDate" name="bookingDate" required>
                        </div>

                        <div class="form-group">
                            <label for="bookingTime">Giờ đặt</label>
                            <input type="time" id="bookingTime" name="bookingTime" required>
                        </div>
                    </div>

                    <div class="row-2">
                        <div class="form-group">
                            <label for="numPeople">Số khách</label>
                            <input type="number" id="numPeople" name="numPeople" min="1" placeholder="Nhập số khách..." required>
                        </div>

                        <div class="form-group">
                            <label for="status">Trạng thái</label>
                            <select id="status" name="status">
                                <option value="Pending">Chưa nhận bàn (Pending)</option>
                                <option value="Confirmed">Đã nhận bàn (Confirmed)</option>
                                <option value="Completed">Đã hoàn thành (Completed)</option>
                                <option value="Canceled">Đã hủy (Canceled)</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="note">Ghi chú (nếu có)</label>
                        <input type="text" id="note" name="note" placeholder="Ví dụ: Cần ghế trẻ em...">
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fa fa-check"></i> Xác nhận đặt bàn
                    </button>

                </form>

            </div>

        </div>

    </main>

</div>

</body>
</html>
