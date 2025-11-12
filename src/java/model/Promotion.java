package model;

import java.sql.Timestamp;

public class Promotion {
    private int id;
    private String code;
    private String description;
    private String discountType;
    private double discountValue;
    private double minOrderValue;
    private double maxDiscountAmount;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean isActive;

    public Promotion() {}

    public Promotion(int id, String code, String description, String discountType, double discountValue, double minOrderValue, double maxDiscountAmount, Timestamp startDate, Timestamp endDate, boolean isActive) {
        this.id = id;
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderValue = minOrderValue;
        this.maxDiscountAmount = maxDiscountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }
    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }
    public double getMinOrderValue() { return minOrderValue; }
    public void setMinOrderValue(double minOrderValue) { this.minOrderValue = minOrderValue; }
    public double getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(double maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }
    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }
    public Timestamp getEndDate() { return endDate; }
    public void setEndDate(Timestamp endDate) { this.endDate = endDate; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}