<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đặt bàn</title>

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
    }

    /* BOX */
    .info-box {
        background: #fff;
        padding: 28px 35px;
        border-radius: 14px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        margin-bottom: 25px;
    }

    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #1a4ff7;
        margin-bottom: 20px;
    }

    /* GRID */
    .info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px 30px;
    }

    .info-item label {
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
        display: block;
    }

    .info-item p {
        margin: 0;
        font-size: 16px;
        color: #555;
    }

    /* TABLE */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        background: #f2f5f9;
        padding: 14px;
        font-weight: 600;
        text-align: left;
        color: #495057;
    }

    td {
        padding: 16px 14px;
        border-bottom: 1px solid #eee;
    }

    tr:hover {
        background: #f9fbff;
    }

    .col-price,
    .col-total {
        text-align: right;
        font-weight: 600;
    }

    .col-qty {
        text-align: center;
    }

    .total-summary {
        text-align: right;
        margin-top: 20px;
        font-size: 18px;
        font-weight: 700;
    }

    .total-summary span {
        color: #d40000;
        font-size: 20px;
    }
</style>

</head>

<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="page-title">Chi tiết Đơn đặt bàn</div>

            <!-- ====== THÔNG TIN KHÁCH HÀNG ====== -->
            <div class="info-box">
                <h3 class="section-title">Thông tin người đặt</h3>

                <div class="info-grid">
                    <div class="info-item">
                        <label>Họ tên khách hàng</label>
                        <p>${booking.customerName}</p>
                    </div>

                    <div class="info-item">
                        <label>Số điện thoại</label>
                        <p>${booking.phone}</p>
                    </div>

                    <div class="info-item">
                        <label>Ngày đặt</label>
                        <p><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/></p>
                    </div>

                    <div class="info-item">
                        <label>Giờ đặt</label>
                        <p><fmt:formatDate value="${booking.bookingTime}" pattern="HH:mm"/></p>
                    </div>

                    <div class="info-item">
                        <label>Số khách</label>
                        <p>${booking.numPeople}</p>
                    </div>

                    <div class="info-item">
                        <label>Trạng thái</label>
                        <p>${booking.status}</p>
                    </div>

                    <c:if test="${not empty booking.note}">
                        <div class="info-item" style="grid-column: 1 / -1;">
                            <label>Ghi chú</label>
                            <p>${booking.note}</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- ====== THỰC ĐƠN ĐÃ ĐẶT ====== -->
            <div class="info-box">
                <h3 class="section-title">Thực đơn đã chọn (từ Website)</h3>

                <table>
                    <thead>
                        <tr>
                            <th>Món ăn</th>
                            <th class="col-qty">Số lượng</th>
                            <th class="col-price">Đơn giá</th>
                            <th class="col-total">Thành tiền</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="detail" items="${order.details}">
                            <tr>
                                <td><b>${detail.product.name}</b></td>

                                <td class="col-qty">${detail.quantity}</td>

                                <td class="col-price">
                                    <fmt:formatNumber value="${detail.price}"
                                                      type="currency"
                                                      currencyCode="VND"
                                                      minFractionDigits="0"/>
                                </td>

                                <td class="col-total">
                                    <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                      type="currency"
                                                      currencyCode="VND"
                                                      minFractionDigits="0"/>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty order.details}">
                            <tr><td colspan="4">(Khách hàng không chọn món trước)</td></tr>
                        </c:if>
                    </tbody>
                </table>

                <c:if test="${not empty order.details}">
                    <div class="total-summary">
                        Tổng cộng:
                        <span>
                            <fmt:formatNumber value="${order.totalAmount}"
                                              type="currency"
                                              currencyCode="VND"
                                              minFractionDigits="0"/>
                        </span>
                    </div>
                </c:if>

            </div>
        </div>

    </main>

</div>

</body>
</html>
