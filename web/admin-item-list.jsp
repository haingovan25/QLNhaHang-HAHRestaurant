<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách mặt hàng</title>

    <link rel="stylesheet" href="css/admin-main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            background: #f5f7fb;
            font-family: "Segoe UI", sans-serif;
        }

        .page-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 18px;
            color: #1a1a1a;
        }

        /* Hộp trắng chứa bảng */
        .white-box {
            background: #fff;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        /** HÀNG NÚT  **/
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .btn-add {
            background: #1a4ff7;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .btn-add:hover { background: #0e38c4; }

        .right-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-import, .btn-export {
            padding: 8px 15px;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-import { background: #198754; }
        .btn-export { background: #0d6efd; }

        .search-box {
            padding: 8px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        /** FILTER **/
        .filter-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
        }

        /* ==== TABLE HEADER CHUẨN GIAO DIỆN MẪU ==== */
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background: #f2f5f9;
                padding: 16px 14px;
                font-size: 15px;
                font-weight: 700;
                color: #495057;
                text-align: left;
                border-bottom: 1px solid #e1e5ea;
            }

            td {
                padding: 14px 12px;
                border-bottom: 1px solid #eee;
                font-size: 14px;
}

        tr:hover {
            background: #f9fbff;
        }

        .item-img {
            width: 45px;
            height: 45px;
            border-radius: 6px;
            object-fit: cover;
        }

        .tag-unit {
            background: #eef2f6;
            padding: 6px 12px;
            border-radius: 14px;
            font-size: 13px;
            font-weight: 600;
        }

        .note {
            color: #6c757d;
            font-size: 13px;
        }
        /* Tạo icon sort dạng ↑↓ */
.sortable {
        display: flex;
        align-items: center;
        gap: 4px;
        cursor: pointer;
        user-select: none;
    }

    .sort-icons {
        display: flex;
        flex-direction: column;
        line-height: 6px;
        margin-top: -4px;
    }

    .sort-icons i {
        font-size: 10px;
        color: #b6bfc9;
        transition: 0.2s;
    }

    .sortable:hover i {
        color: #1a4ff7;
    }

    </style>
</head>

<body>

<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <div class="main-content">

            <div class="page-title">Danh sách mặt hàng</div>

            <div class="white-box">

                <!-- Action bar -->
                <div class="action-row">
                    <a class="btn-add"><i class="fa fa-plus"></i> Thêm mặt hàng</a>

                    <div class="right-actions">
                        <a class="btn-import"><i class="fa fa-file-import"></i> Import</a>
                        <a class="btn-export"><i class="fa fa-file-export"></i> Export</a>
                        <input type="text" placeholder="Nhập từ khóa tìm kiếm..." class="search-box">
                    </div>
                </div>

                <!-- Filter -->
                <div class="filter-row">
                    Hiển thị
                    <select>
                        <option>10</option>
                        <option>20</option>
                        <option>50</option>
                    </select>
                </div>

                <!-- Table -->
                <table>
                        <thead>
<tr>
    <th><input type="checkbox"></th>
    <th></th>

    <th>
        <div class="sortable">
            Mặt hàng
            <span class="sort-icons">
                <i class="fa-solid fa-chevron-up"></i>
                <i class="fa-solid fa-chevron-down"></i>
            </span>
        </div>
    </th>

    <th>
        <div class="sortable">
            Danh mục
            <span class="sort-icons">
                <i class="fa-solid fa-chevron-up"></i>
                <i class="fa-solid fa-chevron-down"></i>
            </span>
        </div>
    </th>

    <th>
        <div class="sortable">
            Giá thành
            <span class="sort-icons">
                <i class="fa-solid fa-chevron-up"></i>
                <i class="fa-solid fa-chevron-down"></i>
            </span>
        </div>
    </th>

    <th>
        <div class="sortable">
            Đơn vị tính
            <span class="sort-icons">
                <i class="fa-solid fa-chevron-up"></i>
                <i class="fa-solid fa-chevron-down"></i>
            </span>
        </div>
    </th>

    <th>
        <div class="sortable">
            Ghi chú
            <span class="sort-icons">
                <i class="fa-solid fa-chevron-up"></i>
                <i class="fa-solid fa-chevron-down"></i>
            </span>
        </div>
    </th>
</tr>
</thead>



                    <tbody>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/cocacola.jpg" class="item-img"></td>
                            <td>Coca Cola</td>
                            <td>Đồ uống</td>
                            <td>15,000 đ</td>
                            <td><span class="tag-unit">Ly</span></td>
                            <td class="note"></td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/coffee.jpg" class="item-img"></td>
                            <td>Coffee</td>
                            <td>Đồ uống</td>
                            <td>25,000 đ</td>
                            <td><span class="tag-unit">Ly</span></td>
                            <td class="note"></td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/chachien.jpg" class="item-img"></td>
                            <td>Chạch chiên sả ớt</td>
                            <td>Đồ ăn</td>
                            <td>150,000 đ</td>
                            <td><span class="tag-unit">Đĩa</span></td>
                            <td class="note"></td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/salad.jpg" class="item-img"></td>
                            <td>Salad rau củ quả</td>
                            <td>Đồ ăn</td>
                            <td>120,000 đ</td>
                            <td><span class="tag-unit">Đĩa</span></td>
                            <td class="note"></td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/laucuadong.jpg" class="item-img"></td>
                            <td>Lẩu cua đồng</td>
                            <td>Đồ ăn</td>
                            <td>380,000 đ</td>
                            <td><span class="tag-unit">Nồi</span></td>
                            <td class="note"></td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td><img src="img/items/tomnuong.jpg" class="item-img"></td>
                            <td>Tôm nướng muối ớt</td>
                            <td>Đồ ăn</td>
                            <td>85,000 đ</td>
                            <td><span class="tag-unit">Đĩa</span></td>
                            <td class="note"></td>
                        </tr>

                    </tbody>
                </table>

            </div>
        </div>
    </main>
</div>
<script>
// =========================
// 1. CHỨC NĂNG CHỌN TẤT CẢ
// =========================
const checkAll = document.querySelector("thead th input[type='checkbox']");
const rowChecks = document.querySelectorAll("tbody input[type='checkbox']");

if (checkAll) {
    checkAll.addEventListener("change", function () {
        rowChecks.forEach(cb => cb.checked = checkAll.checked);
    });
}

// =========================
// 2. SẮP XẾP BẢNG
// =========================
function sortTable(columnIndex, type) {
    const table = document.querySelector("table");
    const tbody = table.querySelector("tbody");
    const rows = Array.from(tbody.querySelectorAll("tr"));

    // Lấy trạng thái sort hiện tại
    const th = table.querySelectorAll("th")[columnIndex];
    const currentSort = th.getAttribute("data-sort") || "asc";

    // Đảo trạng thái
    const newSort = currentSort === "asc" ? "desc" : "asc";
    th.setAttribute("data-sort", newSort);

    rows.sort((rowA, rowB) => {
        let a = rowA.children[columnIndex].innerText.trim();
        let b = rowB.children[columnIndex].innerText.trim();

        // Nếu là số → chuyển về dạng số
        if (type === "number") {
            a = parseInt(a.replace(/\D/g, "")) || 0;
            b = parseInt(b.replace(/\D/g, "")) || 0;
        }

        if (newSort === "asc") {
            return a > b ? 1 : -1;
        } else {
            return a < b ? 1 : -1;
        }
    });

    tbody.innerHTML = "";
    rows.forEach(r => tbody.appendChild(r));
}

// =========================
// 3. GÁN SỰ KIỆN CHO CÁC CỘT SORT
// =========================
document.querySelectorAll(".sortable").forEach((el, index) => {
    el.addEventListener("click", function() {

        // Cột INDEX thực tế trong TABLE (có 2 cột đầu là checkbox + ảnh)
        const realColumn = index + 2;

        let type = "text";
        if (realColumn === 4) type = "number"; // Giá thành là số

        sortTable(realColumn, type);
    });
});
</script>

</body>
</html>
