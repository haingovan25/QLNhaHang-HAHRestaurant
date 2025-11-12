<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng | HAH Restaurant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        body { 
            background-color: #f9f9f9; 
            font-family: Arial, sans-serif; /* Sửa lỗi chữ trắng */
        }
        .container {
            width: 90%; max-width: 900px; margin: 40px auto; background: #fff;
            padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h2 { color: #244b2c; margin-bottom: 25px; font-size: 26px; }
        
        /* 1. Khung cuộn cho bảng (Giữ nguyên) */
        .table-wrapper {
            max-height: 50vh; 
            overflow-y: auto;
            border: 1px solid #ddd;
            margin-bottom: 20px; /* Tăng margin */
        }

        /* 2. Bảng (Giữ nguyên) */
        table { 
            width: 100%; 
            border-collapse: collapse; 
        }
        
        /* 3. Header bảng cố định (Giữ nguyên) */
        table th { 
            background: #f2f2f2; color: #333; font-weight: 600;
            position: sticky; top: 0; z-index: 1;
        }

        table td { 
            border: 1px solid #ddd; padding: 10px 8px; 
            text-align: center; vertical-align: middle; 
            color: #333;
        }
        table td:nth-child(2) { text-align: left; padding-left: 10px; }
        table img { width: 70px; height: 70px; border-radius: 8px; object-fit: cover; margin-right: 8px; }
        
        .food-name { font-weight: 600; color: #333; }
        .qty-control { display: flex; align-items: center; justify-content: center; gap: 8px; }
        /* CSS cho nút +/- trong bảng */
        .qty-btn { 
            border: 1px solid #ccc; background: #f7f7f7; color: #333; 
            font-size: 16px; width: 28px; height: 28px; border-radius: 5px; 
            cursor: pointer; transition: 0.2s; 
        }
        .qty-btn:hover { background: #ffc107; color: #fff; border-color: #ffc107; }
        .qty-num { min-width: 28px; text-align: center; font-weight: bold; }
        
        /* CSS cho nút Xóa (thùng rác) */
        .btn-trash { 
            background: #dc3545; border: none; color: #fff; 
            border-radius: 5px; padding: 8px 12px; cursor: pointer; 
            text-decoration: none; font-size: 14px;
        }
        .btn-trash:hover { background: #c82333; }
        
        /* === CSS MỚI CHO BỐ CỤC BÊN DƯỚI === */
        
        /* 1. Container flex cho các nút và tổng tiền */
        .cart-summary {
            display: flex;
            justify-content: space-between;
            align-items: flex-start; /* Căn lề trên */
            margin-top: 20px;
        }
        
        /* 2. CSS cho nhóm nút bấm bên trái */
        .cart-actions {
            display: flex;
            gap: 10px; /* Khoảng cách giữa các nút */
        }
        
        /* 3. CSS cho nút bấm chung (Tiếp tục, Xóa, Thanh toán) */
        .action-btn {
            border: none;
            border-radius: 5px;
            padding: 10px 18px; /* Tăng padding */
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            text-align: center;
        }
        .btn-gray { background: #f0f0f0; color: #555; border: 1px solid #ccc; }
        .btn-gray:hover { background: #e0e0e0; }
        
        .btn-red { background: #dc3545; color: #fff; }
        .btn-red:hover { background: #c82333; }
        
        .btn-green { background: #28a745; color: #fff; }
        .btn-green:hover { background: #218838; }

        /* 4. CSS cho hộp tổng tiền bên phải */
        .total-box {
            width: 300px; /* Cố định chiều rộng */
            text-align: right;
            font-size: 16px;
            line-height: 2.0; /* Tăng dãn dòng */
            color: #555;
        }
        .total-box div {
            display: flex;
            justify-content: space-between;
        }
        .total-box .total-final {
            font-size: 18px;
            font-weight: bold;
            color: #d40000; /* Màu đỏ cho tổng tiền */
            border-top: 1px solid #eee;
            margin-top: 5px;
            padding-top: 5px;
        }
        .total-box span {
            font-weight: bold;
            color: #333;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Giỏ hàng của bạn</h2>
        
        <div class="table-wrapper">
            <table id="cartTable">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Món ăn</th>
                        <th>Giá bán</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th></th> </tr>
                </thead>
                <tbody id="cartBody">
                    <c:if test="${empty currentCart.details}">
                        <tr><td colspan="6">Giỏ hàng của bạn đang trống.</td></tr>
                    </c:if>

                    <c:set var="stt" value="1"/>
                    <c:forEach var="detail" items="${currentCart.details}">
                        <tr>
                            <td>${stt}</td>
                            <td>
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <img src="${detail.product.imageUrl}" alt="${detail.product.name}">
                                    <span class="food-name">${detail.product.name}</span>
                                </div>
                            </td>
                            <td><fmt:formatNumber value="${detail.price}" type="currency" currencyCode="VND" minFractionDigits="0"/></td>
                            <td>
                                <form action="orderitem" method="POST" class="qty-control">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productId" value="${detail.product.id}">
                                    <button type="submit" name="quantity" value="${detail.quantity - 1}" class="qty-btn">−</button>
                                    <span class="qty-num">${detail.quantity}</span>
                                    <button type="submit" name="quantity" value="${detail.quantity + 1}" class="qty-btn">+</button>
                                </form>
                            </td>
                            <td><fmt:formatNumber value="${detail.price * detail.quantity}" type="currency" currencyCode="VND" minFractionDigits="0"/></td>
                            <td>
                                <a href="orderitem?action=remove&productId=${detail.product.id}" class="btn-trash">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <c:set var="stt" value="${stt + 1}"/>
                    </c:forEach>
                </tbody>
            </table>
        </div> <div class="cart-summary">
            
            <div class="cart-actions">
                <a href="menu" class="action-btn btn-gray">
                    <i class="fa fa-chevron-left"></i> Tiếp tục chọn món
                </a>
                <a href="orderitem?action=clearall" class="action-btn btn-red" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?');">
                    <i class="fa fa-times"></i> Xóa hết
                </a>
                <a href="payment" class="action-btn btn-green">
                    Thanh toán <i class="fa fa-chevron-right"></i>
                </a>
            </div>
            
            <div class="total-box">
                <div>
                    Tạm tính: 
                    <span><fmt:formatNumber value="${currentCart.subtotal}" type="currency" currencyCode="VND" minFractionDigits="0"/></span>
                </div>
                <div>
                    Khuyến mãi: 
                    <span><fmt:formatNumber value="${currentCart.discountAmount}" type="currency" currencyCode="VND" minFractionDigits="0"/></span>
                </div>
                <div class="total-final">
                    Tổng cộng (VAT): 
                    <span><fmt:formatNumber value="${currentCart.totalAmount}" type="currency" currencyCode="VND" minFractionDigits="0"/></span>
                </div>
            </div>
            
        </div>
        </div>
</body>
</html>