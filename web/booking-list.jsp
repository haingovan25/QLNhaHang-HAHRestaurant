<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt bàn | Restaurant Admin</title>

    <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    body {
        margin: 0;
        padding: 0;
        background: #f5f7fb;
        font-family: Segoe UI, sans-serif;
        color: #333;
    }

    .main-content {
        padding: 25px 40px;
    }

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
        transition: 0.3s;
    }
    .create-btn:hover { background: #0f38c8; }

    /* LIST */
    .booking-list {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* CARD */
    .booking-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        display: flex;
        align-items: center;
        padding: 20px;
        gap: 15px;
        transition: all 0.25s ease;
    }
    .booking-card:hover {
        box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    }

    /* ICON */
    .card-icon {
        font-size: 20px;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .card-icon.pending {
        color: #1a4ff7;
        background: #eef2ff;
    }

    .card-icon.assigned {
        color: #28a745;
        background: #e9f7ec;
    }

    /* MENU */
    .ellipsis-menu { position: relative; flex-shrink: 0; }
    .ellipsis-btn {
        background: none;
        border: none;
        font-size: 20px;
        color: #555;
        cursor: pointer;
        padding: 5px;
        border-radius: 50%;
    }
    .ellipsis-btn:hover { background: #f1f1f1; }

    .ellipsis-dropdown {
        display: none;
        position: absolute;
        top: 35px;
        left: 0;
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        z-index: 10;
        width: 160px;
    }
    .ellipsis-dropdown a {
        display: block;
        padding: 10px 15px;
        color: #333;
        text-decoration: none;
        font-size: 14px;
    }
    .ellipsis-dropdown a:hover { background: #f5f5f5; }
    .ellipsis-dropdown a.danger { color: #dc3545; }

    /* INFO */
    .card-details-main { flex: 1; min-width: 0; }
    .card-details-main h3 {
        font-size: 16px;
        font-weight: 600;
        color: #1a1a1a;
        margin: 0 0 8px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .card-details-main p {
        margin: 4px 0;
        color: #555;
        font-size: 14px;
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .card-actions-right a {
        background: #1a4ff7;
        color: white;
        border-radius: 8px;
        padding: 8px 14px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
    }
    .card-actions-right a:hover { background: #0f38c8; }
</style>

</head>

<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="dashboard-header">
                <h1>Lịch đặt bàn (Chưa nhận)</h1>
                <a href="admin-booking-create" class="create-btn">
                    <i class="fa fa-plus"></i> Tạo đơn đặt bàn
                </a>
            </div>

            <div class="booking-list">

                <c:forEach var="detail" items="${bookingDetailList}">
                    <c:set var="b" value="${detail.booking}"/>
                    <c:set var="o" value="${detail.order}"/>
                    <c:set var="t" value="${detail.table}"/>

                    <div class="booking-card">

                        <div class="card-icon ${t != null ? 'assigned' : 'pending'}">
                            <i class="fa ${t != null ? 'fa-check' : 'fa-question-circle'}"></i>
                        </div>

                        <!-- MENU -->
                        <div class="ellipsis-menu">
                            <button class="ellipsis-btn" onclick="toggleMenu(this)">
                                <i class="fa fa-ellipsis-v"></i>
                            </button>

                            <div class="ellipsis-dropdown">
                                <a href="admin-update-booking?id=${b.id}&status=Canceled"
                                   class="danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn HỦY đơn này?');">
                                    Hủy đặt bàn
                                </a>

                                <a href="admin-table-layout?bookingId=${b.id}">Chọn/Đổi bàn</a>

                                <a href="admin-booking-detail?id=${b.id}">Thực đơn</a>
                            </div>
                        </div>

                        <!-- DETAILS -->
                        <div class="card-details-main">
                            <h3>
                                <a href="admin-booking-detail?id=${b.id}"
                                   style="color: #1a1a1a; text-decoration: none;">
                                    ${b.customerName} - ${b.phone}
                                </a>
                            </h3>

                            <p>
                                <i class="fa fa-clock"></i>
                                <fmt:formatDate value="${b.bookingTime}" pattern="HH:mm"/>

                                <i class="fa fa-calendar-day" style="margin-left:15px"></i>
                                <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/>
                            </p>

                            <p>
                                <i class="fa fa-users"></i> ${b.numPeople} người

                                <i class="fa fa-map-marker-alt" style="margin-left:15px"></i>
                                <c:if test="${t != null}">
                                    ${t.name} (${t.locationArea})
                                </c:if>
                                <c:if test="${t == null}">
                                    (Chưa có bàn)
                                </c:if>
                            </p>

                            <p>
                                <i class="fa fa-dollar-sign"></i>
                                <c:choose>
                                    <c:when test="${o != null && o.paymentStatus == 'Paid'}">
                                        <fmt:formatNumber value="${o.totalAmount}" type="currency" currencyCode="VND" minFractionDigits="0"/> (Đã cọc)
                                    </c:when>
                                    <c:otherwise>
                                        0 đ (Chưa cọc)
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>

                        <!-- ACTION -->
                        <div class="card-actions-right">
                            <a href="admin-update-booking?id=${b.id}&status=Confirmed">
                                Khách nhận bàn
                            </a>
                        </div>

                    </div>

                </c:forEach>

                <c:if test="${empty bookingDetailList}">
                    <p>Không có đơn đặt bàn nào.</p>
                </c:if>

            </div>
        </div>
    </main>
</div>

<script>
    function toggleMenu(btn) {
        const menu = btn.nextElementSibling;
        const isOpen = menu.classList.contains("show");

        document.querySelectorAll(".ellipsis-dropdown").forEach(m => m.classList.remove("show"));
        if (!isOpen) menu.classList.add("show");
    }

    document.addEventListener("click", function(e) {
        if (!e.target.closest(".ellipsis-menu")) {
            document.querySelectorAll(".ellipsis-dropdown").forEach(m => m.classList.remove("show"));
        }
    });
</script>

</body>
</html>
