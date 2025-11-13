package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.RestaurantTable; // Import model của bạn

public class RestaurantTableDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Lấy TẤT CẢ các bàn trong nhà hàng
     * @return Danh sách các bàn
     */
    public List<RestaurantTable> getAllTables() {
        List<RestaurantTable> list = new ArrayList<>();
        String query = "SELECT * FROM RestaurantTables ORDER BY name";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RestaurantTable(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("capacity"),
                        rs.getString("location_area"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    
    /**
     * Cập nhật trạng thái của một bàn (Available, Occupied, Reserved...)
     */
    public boolean updateTableStatus(int tableId, String status) {
        String query = "UPDATE RestaurantTables SET status = ? WHERE id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, tableId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnections();
        }
    }
    
    public RestaurantTable getAssignedTableForBooking(int bookingId) {
        // JOIN 2 bảng RestaurantTables và BookingTables
        String query = "SELECT rt.* FROM RestaurantTables rt "
                     + "JOIN BookingTables bt ON rt.id = bt.table_id "
                     + "WHERE bt.booking_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            
            // (Chỉ lấy bàn đầu tiên nếu gán nhiều bàn)
            if (rs.next()) { 
                return new RestaurantTable(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("capacity"),
                        rs.getString("location_area"),
                        rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null; // Trả về null nếu chưa gán bàn
    }
    
    public List<RestaurantTable> getAvailableTables() {
        List<RestaurantTable> list = new ArrayList<>();
        String query = "SELECT * FROM RestaurantTables WHERE status = 'Available' ORDER BY name";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RestaurantTable(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("capacity"),
                        rs.getString("location_area"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    
    public List<String> getDistinctAreas() {
        List<String> areas = new ArrayList<>();
        // Lấy các khu vực duy nhất, loại bỏ giá trị NULL
        String query = "SELECT DISTINCT location_area FROM RestaurantTables WHERE location_area IS NOT NULL";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                areas.add(rs.getString("location_area"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return areas;
    }

    /**
     * HÀM MỚI 2: Lấy danh sách các bàn theo một khu vực cụ thể
     */
    public List<RestaurantTable> getTablesByArea(String area) {
        List<RestaurantTable> list = new ArrayList<>();
        String query = "SELECT * FROM RestaurantTables WHERE location_area = ? ORDER BY name";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, area);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RestaurantTable(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("capacity"),
                        rs.getString("location_area"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    
    
    
    // (Bạn cũng có thể thêm hàm getTablesByStatus("Available") nếu cần)

    private void closeConnections() {
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) conn.close(); } catch (Exception e) {};
    }
}