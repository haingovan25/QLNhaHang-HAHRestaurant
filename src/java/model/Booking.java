package model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Booking {
    private int id;
    private String customerName;
    private String phone;
    private Date bookingDate;
    private Time bookingTime;
    private int numPeople;
    private String note;
    private String status;
    private Timestamp createdAt;
    private String assignedTableName;

    public Booking() {}

    public Booking(int id, String customerName, String phone, Date bookingDate, Time bookingTime, int numPeople, String note, String status, Timestamp createdAt) {
        this.id = id;
        this.customerName = customerName;
        this.phone = phone;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.numPeople = numPeople;
        this.note = note;
        this.status = status;
        this.createdAt = createdAt;
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }
    public Time getBookingTime() { return bookingTime; }
    public void setBookingTime(Time bookingTime) { this.bookingTime = bookingTime; }
    public int getNumPeople() { return numPeople; }
    public void setNumPeople(int numPeople) { this.numPeople = numPeople; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getAssignedTableName() {
        return assignedTableName;
    }

    public void setAssignedTableName(String assignedTableName) {
        this.assignedTableName = assignedTableName;
    }
}