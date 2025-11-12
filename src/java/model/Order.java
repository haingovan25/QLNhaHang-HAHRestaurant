package model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int accountId;
    private int bookingId;
    private int promotionId;
    private double subtotal;
    private double discountAmount;
    private double totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private String orderStatus;
    private String transactionRef;
    private String note;
    private Timestamp createdAt;
    private Booking booking; // Để chứa thông tin đặt bàn
    private List<OrderDetail> details; // Để chứa danh sách món ăn

    public Order() {}

    public Order(int id, int accountId, int bookingId, int promotionId, double subtotal, double discountAmount, double totalAmount, String paymentMethod, String paymentStatus, String orderStatus, String transactionRef, String note, Timestamp createdAt) {
        this.id = id;
        this.accountId = accountId;
        this.bookingId = bookingId;
        this.promotionId = promotionId;
        this.subtotal = subtotal;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.orderStatus = orderStatus;
        this.transactionRef = transactionRef;
        this.note = note;
        this.createdAt = createdAt;
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getPromotionId() { return promotionId; }
    public void setPromotionId(int promotionId) { this.promotionId = promotionId; }
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
    public double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }
    public String getTransactionRef() { return transactionRef; }
    public void setTransactionRef(String transactionRef) { this.transactionRef = transactionRef; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }
}