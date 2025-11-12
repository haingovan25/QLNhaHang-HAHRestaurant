<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán | HAH Restaurant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation-form.css">
    
    <style>
        /* (CSS tôi đã gửi bạn ở bước trước) */
        .payment-layout { display: grid; grid-template-columns: 3fr 2fr; gap: 30px; max-width: 1100px; margin: 40px auto; }
        .section-box { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 25px; }
        .section-header { font-size: 1.2rem; font-weight: 600; color: #104c23; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #eee; }
        .info-group { margin-bottom: 15px; }
        .info-group label { font-weight: 600; color: #333; display: block; margin-bottom: 5px;}
        .info-group p { margin: 0; color: #555; font-size: 15px; }
        .payment-summary p { display: flex; justify-content: space-between; font-size: 15px; color: #555; margin-bottom: 10px; }
        .payment-summary p span { font-weight: 600; color: #333; }
        .payment-summary .total { font-size: 1.25rem; font-weight: 700; color: #d40000; border-top: 1px solid #eee; padding-top: 10px; margin-top: 10px; }
        .payment-methods .form-check { margin-bottom: 10px; }
        .btn-pay { width: 100%; padding: 12px; background: #28a745; border: none; border-radius: 5px; font-weight: bold; font-size: 16px; cursor: pointer; margin-top: 20px; color: white; }
        .btn-pay:hover { background: #218838; }
        /* CSS cho table-wrapper (từ cart.jsp) */
        .table-wrapper { max-height: 40vh; overflow-y: auto; border: 1px solid #ddd; }
        table th { background: #f2f2f2; position: sticky; top: 0; z-index: 1; }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />
    <div style="color: black">
        <div class="payment-layout">
        
        <div class="left-col">
            <div class="section-box">
                <h3 class="section-header">Thông tin đặt bàn</h3>
                <div class="info-group">
                    <label>Họ tên:</label>
                    <p>${orderToPay.booking.customerName}</p>
                </div>
                <div class="info-group">
                    <label>Số điện thoại:</label>
                    <p>${orderToPay.booking.phone}</p>
                </div>
                <div class="info-group">
                    <label>Thời gian:</label>
                    <p>
                        <fmt:formatDate value="${orderToPay.booking.bookingTime}" pattern="HH:mm" />
                        - Ngày
                        <fmt:formatDate value="${orderToPay.booking.bookingDate}" pattern="dd/MM/yyyy" />
                    </p>
                </div>
            </div>

            <div class="section-box" style="margin-top: 20px;">
                <h3 class="section-header">Chi tiết món ăn</h3>
                <div class="table-wrapper">
                    <table style="width:100%; border-collapse: collapse;">
                        <thead>
                            <tr style="background: #f2f2f2;">
                                <th style="padding: 10px; border: 1px solid #ddd; text-align: left;">Món ăn</th>
                                <th style="padding: 10px; border: 1px solid #ddd;">SL</th>
                                <th style="padding: 10px; border: 1px solid #ddd; text-align: right;">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderToPay.details}">
                                <tr>
                                    <td style="padding: 10px; border: 1px solid #ddd;">${detail.product.name}</td>
                                    <td style="padding: 10px; border: 1px solid #ddd; text-align: center;">${detail.quantity}</td>
                                    <td style="padding: 10px; border: 1px solid #ddd; text-align: right;"><fmt:formatNumber value="${detail.price * detail.quantity}" type="currency" currencyCode="VND" minFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="right-col">
            <div class="section-box">
                <h3 class="section-header">Xác nhận thanh toán</h3>
                
                <form action="process-payment" method="POST">
                    <input type="hidden" name="orderId" value="${orderToPay.id}">
                    <input type="hidden" name="totalAmount" value="${orderToPay.totalAmount}">
                    
                    <div class="payment-summary">
                        <p>Tạm tính: <span><fmt:formatNumber value="${orderToPay.subtotal}" type="currency" currencyCode="VND" minFractionDigits="0"/></span></p>
                        <p>Khuyến mãi: <span><fmt:formatNumber value="${orderToPay.discountAmount}" type="currency" currencyCode="VND" minFractionDigits="0"/></span></p>
                        <p class="total">Tổng cộng: <span><fmt:formatNumber value="${orderToPay.totalAmount}" type="currency" currencyCode="VND" minFractionDigits="0"/></span></p>
                    </div>
                    
                    <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                    
                    <div class="payment-methods">
                        <p style="font-weight: 600; color: #333;">Phương thức thanh toán:</p>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="pay1" value="cod" checked>
                            <label class="form-check-label" for="pay1">Thanh toán tại nhà hàng</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="pay2" value="vnpay">
                            <label class="form-check-label" for="pay2">Thanh toán qua ví VNPAY</label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-pay mt-4">XÁC NHẬN THANH TOÁN</button>
                </form>
            </div>
        </div>
    </div>
    </div>
</body>
</html>