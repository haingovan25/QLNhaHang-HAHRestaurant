package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingTablesDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * HÀM (BỊ THIẾU): Gán 1 bàn cho 1 đơn đặt bàn
     * (Đây là hàm mà AdminBookingCreateServlet đang gọi)
     */
    public void linkTableToBooking(int bookingId, int tableId) {
        String query = "INSERT INTO BookingTables (booking_id, table_id) VALUES (?, ?)";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookingId);
            ps.setInt(2, tableId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    /**
     * HÀM (CẦN THIẾT): Lấy danh sách ID các bàn đã được gán cho 1 đơn đặt
     */
    public List<Integer> getTableIdsForBooking(int bookingId) {
        List<Integer> tableIds = new ArrayList<>();
        String query = "SELECT table_id FROM BookingTables WHERE booking_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                tableIds.add(rs.getInt("table_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return tableIds;
    }
    
    /**
     * HÀM (CẦN THIẾT): Cập nhật/Đổi bàn cho đơn đặt
     */
    public void updateAssignedTable(int bookingId, int newTableId, List<Integer> oldTableIds) {
        String deleteQuery = "DELETE FROM BookingTables WHERE booking_id = ?";
        String insertQuery = "INSERT INTO BookingTables (booking_id, table_id) VALUES (?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Xóa tất cả liên kết bàn CŨ
            ps = conn.prepareStatement(deleteQuery);
            ps.setInt(1, bookingId);
            ps.executeUpdate();
            ps.close();

            // 2. Thêm liên kết bàn MỚI
            ps = conn.prepareStatement(insertQuery);
            ps.setInt(1, bookingId);
            ps.setInt(2, newTableId);
            ps.executeUpdate();
            ps.close();
            
            // 3. Cập nhật trạng thái các bàn CŨ về "Available"
            if (oldTableIds != null && !oldTableIds.isEmpty()) {
                String updateOldTableQuery = "UPDATE RestaurantTables SET status = 'Available' WHERE id = ?";
                ps = conn.prepareStatement(updateOldTableQuery);
                for (int oldTableId : oldTableIds) {
                    if (oldTableId != newTableId) {
                        ps.setInt(1, oldTableId);
                        ps.addBatch();
                    }
                }
                ps.executeBatch();
            }
            
            conn.commit(); // Hoàn tất Transaction
            
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback(); // Hoàn tác nếu có lỗi
            } catch (Exception e2) {
                e2.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    private void closeConnections() {
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) conn.close(); } catch (Exception e) {};
    }
}