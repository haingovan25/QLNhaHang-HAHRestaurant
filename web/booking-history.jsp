<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt bàn</title>

    <link href="css/admin-main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            background: #f5f7fb;
            font-family: "Segoe UI", sans-serif;
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

        .content-box {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.06);
        }

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
            font-weight: 500;
        }

        .create-btn:hover { background: #0f38c8; }

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

        .filter-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .filter-left { display: flex; align-items: center; gap: 20px; }

        .search-form { display: flex; gap: 8px; }

        .search-form input {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            width: 250px;
        }

        .search-form button {
            background: #1a4ff7;
            color: white;
            border: none;
            padding: 0 14px;
            border-radius: 8px;
            cursor: pointer;
        }

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

        .status {
            padding: 6px 14px;
            border-radius: 16px;
            font-weight: 600;
            font-size: 13px;
        }
        .st-success  { background: #d4edda;   color: #1e7e34; }
        .st-wait     { background: #ffeeba;   color: #8a6d3b; }
        .st-canceled { background: #f8d7da;   color: #721c24; }
        .st-confirmed{ background: #d1ecf1;   color: #0c5460; }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 25px;
        }

        .pagination a {
            color: #1a4ff7;
            text-decoration: none;
            padding: 8px 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .pagination a.active {
            background: #1a4ff7;
            color: white;
            border-color: #1a4ff7;
        }

        .pagination a.disabled {
            color: #999;
            pointer-events: none;
            background: #f9f9f9;
        }

    </style>
</head>

<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="page-title">Lịch sử đặt bàn</div>

            <div class="content-box">

                <div class="filter-row">
                    <div class="filter-left">
                        <a href="admin-booking-create" class="create-btn">
                            <i class="fa fa-plus"></i> Tạo đơn đặt bàn
                        </a>
                    </div>

                    <form action="admin-booking-history" method="GET" class="search-form">
                        <input type="hidden" name="status" value="${activeTab}">
                        <input type="text" name="searchKey" value="${searchKey}" placeholder="Tìm theo tên, SĐT...">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>

                <div class="tabs">
                    <a href="admin-booking-history?status=all&searchKey=${searchKey}"
                       class="${activeTab == 'all' ? 'active' : ''}">Tất cả</a>

                    <a href="admin-booking-history?status=Pending&searchKey=${searchKey}"
                       class="${activeTab == 'Pending' ? 'active' : ''}">Chưa nhận bàn</a>

                    <a href="admin-booking-history?status=Confirmed&searchKey=${searchKey}"
                       class="${activeTab == 'Confirmed' ? 'active' : ''}">Đã nhận bàn</a>

                    <a href="admin-booking-history?status=Canceled&searchKey=${searchKey}"
                       class="${activeTab == 'Canceled' ? 'active' : ''}">Đã hủy</a>

                    <a href="admin-booking-history?status=Completed&searchKey=${searchKey}"
                       class="${activeTab == 'Completed' ? 'active' : ''}">Đã hoàn thành</a>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th>Dự kiến nhận bàn</th>
                        <th>Khách hàng</th>
                        <th>Số khách</th>
                        <th>Khu vực/Bàn</th>
                        <th>Trạng thái</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="b" items="${bookingList}">
                        <tr>
                            <td>
                                <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/> 
                                (<fmt:formatDate value="${b.bookingTime}" pattern="HH:mm"/>)
                            </td>

                            <td>${b.customerName}<br>${b.phone}</td>

                            <td>${b.numPeople}</td>

                            <td>
                                <c:if test="${empty b.assignedTableName}">(Chưa có)</c:if>
                                <c:if test="${not empty b.assignedTableName}">${b.assignedTableName}</c:if>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${b.status == 'Completed'}">
                                        <span class="status st-success">Đã hoàn thành</span>
                                    </c:when>
                                    <c:when test="${b.status == 'Pending'}">
                                        <span class="status st-wait">Chưa nhận bàn</span>
                                    </c:when>
                                    <c:when test="${b.status == 'Canceled'}">
                                        <span class="status st-canceled">Đã hủy</span>
                                    </c:when>
                                    <c:when test="${b.status == 'Confirmed'}">
                                        <span class="status st-confirmed">Đã nhận bàn</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status">${b.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>

                    <c:if test="${empty bookingList}">
                        <tr><td colspan="6">Không tìm thấy đơn đặt bàn nào.</td></tr>
                    </c:if>

                    </tbody>
                </table>

                <div class="pagination">

                    <a href="admin-booking-history?status=${activeTab}&page=1&searchKey=${searchKey}"
                       class="${currentPage == 1 ? 'disabled' : ''}">
                        <i class="fa fa-backward"></i>
                    </a>

                    <a href="admin-booking-history?status=${activeTab}&page=${currentPage - 1}&searchKey=${searchKey}"
                       class="${currentPage == 1 ? 'disabled' : ''}">
                        <i class="fa fa-chevron-left"></i>
                    </a>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="admin-booking-history?status=${activeTab}&page=${i}&searchKey=${searchKey}"
                           class="${currentPage == i ? 'active' : ''}">
                            ${i}
                        </a>
                    </c:forEach>

                    <a href="admin-booking-history?status=${activeTab}&page=${currentPage + 1}&searchKey=${searchKey}"
                       class="${currentPage == totalPages ? 'disabled' : ''}">
                        <i class="fa fa-chevron-right"></i>
                    </a>

                    <a href="admin-booking-history?status=${activeTab}&page=${totalPages}&searchKey=${searchKey}"
                       class="${currentPage == totalPages ? 'disabled' : ''}">
                        <i class="fa fa-forward"></i>
                    </a>

                </div>

            </div>

        </div>

    </main>

</div>

</body>
</html>
