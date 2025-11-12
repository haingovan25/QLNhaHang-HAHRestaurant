package model;

// Đây là model cho bảng quan hệ N-N (BookingTables)
public class BookingTable {
    private int bookingId;
    private int tableId;

    public BookingTable() {}

    public BookingTable(int bookingId, int tableId) {
        this.bookingId = bookingId;
        this.tableId = tableId;
    }

    // --- Getters and Setters ---

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getTableId() { return tableId; }
    public void setTableId(int tableId) { this.tableId = tableId; }
}