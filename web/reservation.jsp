<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt bàn | HAH Restaurant</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="css/reservation.css" rel="stylesheet" type="text/css"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="reservation-container">
        
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
        
        <form action="reservation" method="POST">
            
            <h3 class="form-title">THỜI GIAN ĐẶT BÀN</h3>
            
            <div class="form-grid">
                <div class="form-group">
                    <label for="bookingDate"><i class="fa-regular fa-calendar-days"></i> Ngày đặt</label>
                    <input type="date" id="bookingDate" name="bookingDate" required>
                </div>
                <div class="form-group">
                    <label for="bookingTime"><i class="fa-regular fa-clock"></i> Giờ đặt</label>
                    <input type="time" id="bookingTime" name="bookingTime" step="1800" required> </div>

                <div class="form-group">
                    <label for="branch"><i class="fa-regular fa-map"></i> Địa điểm</label>
                    <select id="branch" name="branch">
                        <option>Cơ sở 1 - 113 Trần Phú, TP.Vinh</option>
                        <option>Cơ sở 2 - 88 Nguyễn Văn Cừ, TP.Vinh</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="numPeople"><i class="fa-solid fa-user-group"></i> Số người</label>
                    <input type="number" id="numPeople" name="numPeople" placeholder="Ví dụ: 2" min="1" required>
                </div>
            </div>

            <h3 class="form-title">THÔNG TIN NGƯỜI ĐẶT</h3>
            
            <div class="form-grid">
                <div class="form-group">
                    <label for="customerName"><i class="fa-regular fa-user"></i> Họ tên</label>
                    <input type="text" id="customerName" name="customerName" value="${sessionScope.account.fullName}" required>
                </div>
                <div class="form-group">
                    <label for="phone"><i class="fa-solid fa-phone"></i> Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" value="${sessionScope.account.phone}" required>
                </div>
                
                <div class="form-group full-width">
                    <label for="note"><i class="fa-regular fa-pen-to-square"></i> Lưu ý</label>
                    <textarea id="note" name="note" placeholder="Lời nhắn với nhà hàng (ví dụ: cho 1 ghế trẻ em,...)"></textarea>
                </div>
            </div>
            
            <button type="submit" class="submit-btn">Gửi đơn đặt bàn</button>
        </form>
    </div>
</body>
</html>