package model;

import model.RestaurantTable; // <-- THÊM IMPORT NÀY

/**
 * Đây là một lớp "ViewModel" (POJO) đặc biệt
 * Nó dùng để gộp thông tin từ 3 bảng
 */
public class BookingDetailView {
    
    private Booking booking; // Chứa thông tin: Tên, SĐT, Giờ, Số người...
    private Order order;     // Chứa thông tin: Tiền cọc...
    private RestaurantTable table; // <-- THÊM THUỘC TÍNH NÀY

    // SỬA LẠI CONSTRUCTOR ĐỂ NHẬN 3 THAM SỐ
    public BookingDetailView(Booking booking, Order order, RestaurantTable table) {
        this.booking = booking;
        this.order = order;
        this.table = table;
    }

    // Getters and Setters
    public Booking getBooking() {
        return booking;
    }
    public void setBooking(Booking booking) {
        this.booking = booking;
    }
    public Order getOrder() {
        return order;
    }
    public void setOrder(Order order) {
        this.order = order;
    }

    // === THÊM GETTER/SETTER CHO BÀN ===
    public RestaurantTable getTable() {
        return table;
    }
    public void setTable(RestaurantTable table) {
        this.table = table;
    }
}