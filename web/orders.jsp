<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn | Administration</title>

    <!-- CSS layout admin -->
    <link rel="stylesheet" href="css/admin-main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
/* Fix header che sidebar */


.page-title {
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 18px;
    color: #1a1a1a;
}

/* Vùng bao ngoài */
.order-container {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    width: 100%;
}

.btn-create {
    background: #1a4ff7;
    color: #fff;
    padding: 8px 14px;
    border-radius: 8px;
    text-decoration: none;
    margin-bottom: 20px;
    display: inline-block;
    transition: .2s;
}
.btn-create:hover {
    background: #0d36c4;
}

/* CARD HOÁ ĐƠN */
.order-card {
    background: #fff;
    width: 400px;
    border-radius: 12px;
    padding: 18px;
    border: 1px solid #e7e7e7;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

.order-card-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-weight: 600;
}

.order-card-body {
    padding: 15px 0;
    text-align: center;
    font-size: 28px;
    font-weight: bold;
}

.order-card-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 10px;
    border-top: 1px solid #eee;
}

/* PAY BUTTON */
.order-pay {
    padding: 6px 14px;
    border-radius: 8px;
    background: #1a4ff7;
    color: #fff;
    border: none;
    cursor: pointer;
}
.order-pay:hover {
    background: #0e35b8;
}

/* Nút menu ... */
.order-menu {
    position: relative;
    display: inline-block;
}
.menu-btn {
    background: transparent;
    border: none;
    padding: 6px 10px;
    cursor: pointer;
    font-size: 18px;
    color: #333;
}
.menu-btn:hover {
    color: #1a4ff7;
}

/* Dropdown menu */
.order-dropdown {
    position: absolute;
    right: 0;
    top: 32px;
    background: #fff;
    border: 1px solid #e6e6e6;
    border-radius: 8px;
    width: 150px;
    list-style: none;
    padding: 8px 0;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    display: none;
    z-index: 20;
}

.order-dropdown li {
    padding: 10px 14px;
    font-size: 14px;
    cursor: pointer;
    color: #444;
    display: flex;
    align-items: center;
    gap: 8px;
}
.order-dropdown li:hover {
    background: #f3f6ff;
    color: #1a4ff7;
}

/* Icon màu */
.text-green { color: #2ecc71; }
.text-blue  { color: #3498db; }
.text-red   { color: #e74c3c; }

/* Modal overlay */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.45);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 999;
}

/* Modal box */
.modal-box {
    width: 480px;
    background: #fff;
    border-radius: 12px;
    padding: 25px 30px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    animation: fadeIn .25s ease;
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-15px); }
    to { opacity: 1; transform: translateY(0); }
}

.modal-title {
    text-align: center;
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 20px;
}

.reason-title {
    font-weight: 600;
    margin-bottom: 8px;
}

.reason-item {
    display: block;
    margin-bottom: 12px;
    font-size: 15px;
}

.other-input {
    width: 100%;
    height: 90px;
    padding: 10px;
    margin-top: 10px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
}

.modal-actions {
    margin-top: 25px;
    text-align: right;
}

.btn-close {
    padding: 8px 18px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background: #fff;
}
.btn-confirm {
    padding: 8px 18px;
    border-radius: 8px;
    border: none;
    margin-left: 10px;
    background: #e74c3c;
    color: #fff;
}
.btn-confirm:hover {
    background: #cf2b1c;
}

/* ==================== PAYMENT MODAL ==================== */
.pay-row {
    display: flex;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #eee;
    font-size: 16px;
}

.pay-row span:first-child {
    color: #555;
}

.pay-value {
    font-weight: 700;
    color: #000;
}

#payInput {
    width: 200px;
    padding: 6px 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    text-align: right;
    font-size: 16px;
}

    </style>
</head>

<body>
<div class="layout">

    <%@ include file="sidebar.jsp" %>

    <main class="main">

        <%@ include file="header-admin.jsp" %>

        <!-- CONTENT -->
        <section class="dashboard" style="margin-top: 25px;">
            
            <h2 class="page-title">Đơn hiện tại</h2>

            <div class="order-container">

                <a href="#" class="btn-create"><i class="fa fa-plus"></i> Tạo đơn mới</a>

                <!-- CARD ĐƠN -->
                <div class="order-card">
                    <div class="order-card-header">
                        <span>Sảnh chính</span>
                        <span><i class="fa fa-users"></i> 3</span>
                    </div>

                    <div class="order-card-body">1</div>

                    <div class="order-card-footer">

                        <span><i class="fa fa-clock"></i> 00:00:00</span>
                        <span><i class="fa fa-money-bill-wave"></i> 620.000 đ</span>

                        <!-- MENU ... -->
                        <div class="order-menu">
                            <button class="menu-btn"><i class="fa fa-ellipsis-h"></i></button>

                            <ul class="order-dropdown">
                                <li><i class="fa fa-info-circle text-green"></i> Chi tiết</li>
                                <li><i class="fa fa-sync text-blue"></i> Chuyển bàn</li>
                                <li class="text-red cancel-btn"><i class="fa fa-trash"></i> Hủy đơn</li>
                            </ul>
                        </div>

                        <button class="order-pay">Thanh toán</button>

                    </div>
                </div>

            </div>

        </section>

    </main>

</div>

<!-- MODAL HỦY ĐƠN -->
<div id="cancelModal" class="modal-overlay">
    <div class="modal-box">
        <h2 class="modal-title">Hủy đơn</h2>

        <label class="reason-title">Lý do hủy</label>

        <label class="reason-item">
            <input type="radio" name="cancelReason" value="Khách yêu cầu hủy" checked>
            Khách yêu cầu hủy
        </label>

        <label class="reason-item">
            <input type="radio" name="cancelReason" value="Hết bàn">
            Hết bàn
        </label>

        <label class="reason-item">
            <input type="radio" name="cancelReason" value="Lý do khác">
            Lý do khác
        </label>

        <label class="reason-title" style="margin-top: 12px;">Nhập lý do hủy đơn</label>
        <textarea id="reasonInput" class="other-input" placeholder="Nhập lý do hủy đơn"></textarea>

        <div class="modal-actions">
            <button class="btn-close" id="closeCancel">Đóng</button>
            <button class="btn-confirm" id="confirmCancel">Xác nhận</button>
        </div>
    </div>
</div>

<!-- ===================== MODAL THANH TOÁN ===================== -->
<div class="modal-overlay" id="paymentModal">
    <div class="modal-box" style="width: 520px;">
        
        <div class="modal-title" id="paymentTitle">Thanh toán - Bàn 1 - Sảnh chính</div>

        <div class="pay-row">
            <span>Cần thanh toán</span>
            <span id="totalPay" class="pay-value">620.000 đ</span>
        </div>

        <div class="pay-row">
            <span>Khách trả</span>
            <input id="payInput" type="number" placeholder="Nhập số tiền khách trả..." />
        </div>

        <div class="pay-row">
            <span>Còn thiếu</span>
            <span id="remainPay" class="pay-value">0 đ</span>
        </div>

        <div class="modal-actions">
            <button class="btn-close" onclick="closePayment()">Đóng</button>
            <button class="btn-confirm" onclick="confirmPayment()">Xác nhận thanh toán</button>
        </div>
    </div>
</div>

<script>
/* Sidebar toggle submenu */
document.querySelectorAll(".has-sub > a").forEach(link => {
    link.addEventListener("click", e => {
        const submenu = link.parentElement.querySelector(".submenu");
        if (submenu) {
            e.preventDefault();
            submenu.classList.toggle("open");
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }
    });
});

/* Toggle sidebar */
document.querySelector(".menu-toggle").addEventListener("click", () => {
    const sidebar = document.querySelector(".sidebar");
    const main = document.querySelector(".main");
    sidebar.classList.toggle("hide");
    main.style.marginLeft = sidebar.classList.contains("hide") ? "0" : "260px";
});

/* Dropdown menu ... */
document.querySelectorAll(".menu-btn").forEach(btn => {
    btn.addEventListener("click", function(e) {
        e.stopPropagation();

        const dropdown = this.nextElementSibling;
        dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
    });
});

// Click ra ngoài → đóng dropdown
document.addEventListener("click", () => {
    document.querySelectorAll(".order-dropdown").forEach(menu => menu.style.display = "none");
});

/* ================= MODAL HỦY ĐƠN ================= */

const modal = document.getElementById("cancelModal");
const closeBtn = document.getElementById("closeCancel");
const confirmBtn = document.getElementById("confirmCancel");
const reasonOther = document.getElementById("reasonOther");
const reasonInput = document.getElementById("reasonInput");

// Mở modal khi bấm Hủy đơn
document.querySelectorAll(".cancel-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        modal.style.display = "flex";
    });
});

// Nếu chọn lý do khác -> hiện ô nhập
document.querySelectorAll("input[name='cancelReason']").forEach(r => {
    r.addEventListener("change", () => {
        reasonInput.style.display = reasonOther?.checked ? "block" : "none";
    });
});

// Đóng modal
closeBtn.addEventListener("click", () => {
    modal.style.display = "none";
});

// Xác nhận
confirmBtn.addEventListener("click", () => {
    let reason = document.querySelector("input[name='cancelReason']:checked").value;

    if (reason === "Lý do khác") {
        if (reasonInput.value.trim() === "") {
            alert("Vui lòng nhập lý do hủy!");
            return;
        }
        reason = reasonInput.value;
    }

    alert("Đã hủy đơn với lý do: " + reason);

    modal.style.display = "none";
});

// Click ra ngoài -> đóng modal
modal.addEventListener("click", e => {
    if (e.target === modal) modal.style.display = "none";
});

/* ==================== MỞ MODAL THANH TOÁN ==================== */
document.querySelectorAll(".order-pay").forEach(btn => {
    btn.addEventListener("click", function () {

        const card = this.closest(".order-card");
        const tableName = card.querySelector(".order-card-header span").innerText;
        const tableId = card.querySelector(".order-card-body").innerText;
        const money = card.querySelector(".fa-money-bill-wave").parentElement.innerText.trim();

        document.getElementById("paymentTitle").innerText =
            `Thanh toán - Bàn ${tableId} - ${tableName}`;

        document.getElementById("totalPay").innerText = money;
        document.getElementById("remainPay").innerText = money;

        document.getElementById("payInput").value = "";

        document.getElementById("paymentModal").style.display = "flex";
    });
});

/* ==================== INPUT TÍNH TIỀN ==================== */
document.getElementById("payInput").addEventListener("input", function () {
    const total = cleanMoney(document.getElementById("totalPay").innerText);
    const paid = Number(this.value);
    const remain = total - paid;

    document.getElementById("remainPay").innerText = formatMoney(remain) + " đ";
});

function cleanMoney(m) {
    return Number(m.replaceAll(".", "").replace("đ", "").trim());
}

function formatMoney(n) {
    return n.toLocaleString("vi-VN");
}

/* ==================== ĐÓNG MODAL ==================== */
function closePayment() {
    document.getElementById("paymentModal").style.display = "none";
}

/* ==================== XÁC NHẬN THANH TOÁN ==================== */
function confirmPayment() {
    alert("Thanh toán thành công!");
    closePayment();
}

</script>

</body>
</html>
