<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sơ đồ bàn | Restaurant Admin</title>

    <link rel="stylesheet" href="css/admin-main.css">
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
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 25px;
        color: #1a1a1a;
    }

    /* ======= LAYOUT ======= */
    .layout-content {
        display: flex;
        gap: 20px;
        align-items: flex-start;
    }

    /* ======= AREA LIST ======= */
    .area-list {
        background: #fff;
        border-radius: 12px;
        padding: 16px;
        flex: 0 0 240px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .area-item {
        padding: 12px 15px;
        border-radius: 8px;
        border: 1px solid #e0e0e0;
        background: #fff;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 500;
        cursor: pointer;
        transition: 0.2s;
        text-decoration: none;
        color: #333;
    }

    .area-item i {
        color: #1a4ff7;
    }

    .area-item.active,
    .area-item:hover {
        background: #e9f0ff;
        border-color: #1a4ff7;
        color: #1a4ff7;
    }

    /* ======= TABLE LIST ======= */
    .table-list {
        flex: 1;
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
        gap: 20px;
    }

    /* ======= TABLE CARD ======= */
    .table-card {
        border: 1px solid #eee;
        border-radius: 10px;
        padding: 15px;
        text-align: center;
        cursor: pointer;
        transition: .25s;
        text-decoration: none;
        border-bottom: 4px solid #ccc;
        background: #fff;
    }

    .table-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 3px 6px rgba(0,0,0,0.08);
    }

    .table-card .table-icon {
        font-size: 30px;
        margin-bottom: 8px;
    }

    .table-name {
        font-size: 16px;
        margin-bottom: 6px;
        font-weight: 700;
    }

    .table-status {
        font-size: 13px;
        color: #555;
        font-weight: 500;
    }

    .table-capacity {
        font-size: 12px;
        color: #666;
        margin-top: 4px;
    }

    /* ======= STATUS COLORS ======= */
    .table-card[data-status="Available"] { border-bottom-color: #28a745; }
    .table-card[data-status="Available"] .table-icon { color: #28a745; }

    .table-card[data-status="Occupied"] {
        border-bottom-color: #dc3545;
        background: #fff6f6;
    }
    .table-card[data-status="Occupied"] .table-icon { color: #dc3545; }

    .table-card[data-status="Reserved"] {
        border-bottom-color: #ffc107;
        background: #fffcf0;
    }
    .table-card[data-status="Reserved"] .table-icon { color: #e6b100; }

    /* Disabled */
    .disabled {
        opacity: .6;
        background: #f2f2f2 !important;
        cursor: not-allowed;
    }

    .disabled:hover {
        transform: none;
        box-shadow: none;
    }
</style>

</head>
<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="page-title">${pageTitle}</div>

            <div class="layout-content">

                <!-- ==== LIST AREA ==== -->
                <div class="area-list">

                    <c:forEach var="area" items="${areaList}">
                        <a href="admin-table-layout?area=${area}&bookingId=${bookingId}"
                           class="area-item ${area == activeArea ? 'active' : ''}">

                            <c:choose>
                                <c:when test="${area.contains('Tầng')}"><i class="fa fa-building"></i></c:when>
                                <c:when test="${area.contains('Sân')}"><i class="fa fa-tree"></i></c:when>
                                <c:otherwise><i class="fa fa-location-dot"></i></c:otherwise>
                            </c:choose>

                            ${area}
                        </a>
                    </c:forEach>

                </div>

                <!-- ==== LIST TABLES ==== -->
                <div class="table-list">

                    <c:forEach var="t" items="${tableList}">

                        <!-- Default -->
                        <c:set var="link" value="#" />
                        <c:set var="disabled" value="" />
                        <c:set var="onclick" value="" />

                        <!-- Nếu đang CHỌN BÀN CHO BOOKING -->
                        <c:if test="${not empty bookingId}">

                            <!-- Bàn trống -->
                            <c:if test="${t.status == 'Available'}">
                                <c:set var="link" value="admin-assign-table?bookingId=${bookingId}&tableId=${t.id}" />
                                <c:set var="onclick" value="return confirm('Chọn ${t.name}?');" />
                            </c:if>

                            <!-- Không trống -->
                            <c:if test="${t.status != 'Available'}">
                                <c:set var="disabled" value="disabled" />
                                <c:set var="onclick" value="alert('Bàn đang ${t.status}, không thể chọn'); return false;" />
                            </c:if>

                        </c:if>

                        <a href="${link}"
                           onclick="${onclick}"
                           class="table-card ${disabled}"
                           data-status="${t.status}">

                            <div class="table-icon">
                                <c:choose>
                                    <c:when test="${t.status == 'Available'}"><i class="fa fa-circle-check"></i></c:when>
                                    <c:when test="${t.status == 'Occupied'}"><i class="fa fa-circle-xmark"></i></c:when>
                                    <c:when test="${t.status == 'Reserved'}"><i class="fa fa-circle-pause"></i></c:when>
                                    <c:otherwise><i class="fa fa-circle-question"></i></c:otherwise>
                                </c:choose>
                            </div>

                            <div class="table-name">${t.name}</div>
                            <div class="table-status">${t.status}</div>
                            <div class="table-capacity">${t.capacity} khách</div>

                        </a>

                    </c:forEach>

                    <c:if test="${empty tableList}">
                        <p>Không có bàn nào trong khu vực này.</p>
                    </c:if>

                </div>
            </div>
        </div>

    </main>
</div>

</body>
</html>
