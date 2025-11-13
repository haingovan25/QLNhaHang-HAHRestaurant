package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Booking; // Import model Booking của bạn

public class BookingDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Thêm một đơn đặt bàn mới vào CSDL.
     * @param booking Đối tượng Booking chứa thông tin từ form
     * @return ID của booking vừa được tạo (hoặc -1 nếu thất bại)
     */
    public int insertBooking(Booking booking) {
        String query = "INSERT INTO Bookings (customer_name, phone, booking_date, booking_time, num_people, note, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            
            // Thêm "RETURN_GENERATED_KEYS" để lấy lại ID
            ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS); 
            
            ps.setString(1, booking.getCustomerName());
            ps.setString(2, booking.getPhone());
            ps.setDate(3, booking.getBookingDate()); // java.sql.Date
            ps.setTime(4, booking.getBookingTime()); // java.sql.Time
            ps.setInt(5, booking.getNumPeople());
            ps.setString(6, booking.getNote());
            ps.setString(7, "Pending"); // Mặc định trạng thái
            
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Lấy ID vừa được sinh ra
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về ID
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {};
            try { if (ps != null) ps.close(); } catch (Exception e) {};
            try { if (conn != null) conn.close(); } catch (Exception e) {};
        }
        return -1; // Thất bại
    }
    
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        // Sắp xếp theo ngày mới nhất
        String query = "SELECT * FROM Bookings ORDER BY created_at DESC"; 
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("phone"),
                        rs.getDate("booking_date"),
                        rs.getTime("booking_time"),
                        rs.getInt("num_people"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // (Hàm đóng kết nối của bạn)
        }
        return list;
    }

    /**
     * Lấy các đơn đặt bàn theo TRẠNG THÁI
     */
    public List<Booking> getBookingsByStatus(String status) {
        List<Booking> list = new ArrayList<>();
        String query = "SELECT * FROM Bookings WHERE status = ? ORDER BY booking_date DESC";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("phone"),
                        rs.getDate("booking_date"),
                        rs.getTime("booking_time"),
                        rs.getInt("num_people"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
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
     * HÀM 1 SỬA ĐỔI: Đếm tổng số đơn (có tìm kiếm)
     * @param status Trạng thái ("all" hoặc "Pending", "Confirmed"...)
     * @param searchKey Từ khóa (tên hoặc SĐT)
     * @return Tổng số đơn
     */
    public int countBookings(String status, String searchKey) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Bookings");
        List<Object> params = new ArrayList<>();
        String likeKey = "%" + searchKey + "%";
        
        // Điều kiện tìm kiếm (WHERE)
        String searchCondition = " (customer_name LIKE ? OR phone LIKE ?) ";

        try {
            if (status.equals("all")) {
                if (!searchKey.isEmpty()) {
                    query.append(" WHERE").append(searchCondition);
                    params.add(likeKey);
                    params.add(likeKey);
                }
            } else {
                query.append(" WHERE status = ?");
                params.add(status);
                if (!searchKey.isEmpty()) {
                    query.append(" AND").append(searchCondition);
                    params.add(likeKey);
                    params.add(likeKey);
                }
            }
            
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query.toString());
            
            // Set tham số
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return 0;
    }

    /**
     * HÀM 2 SỬA ĐỔI: Lấy TẤT CẢ đơn đặt (phân trang + tìm kiếm + JOIN LẤY TÊN BÀN)
     */
    public List<Booking> getAllBookings(int pageIndex, int pageSize, String searchKey) {
        List<Booking> list = new ArrayList<>();
        int offset = (pageIndex - 1) * pageSize;
        
        // Cập nhật câu SQL với LEFT JOIN
        StringBuilder query = new StringBuilder(
            "SELECT b.*, rt.name as TableName " +
            "FROM Bookings b " +
            "LEFT JOIN BookingTables bt ON b.id = bt.booking_id " + // (Giả sử 1 đơn chỉ có 1 bàn)
            "LEFT JOIN RestaurantTables rt ON bt.table_id = rt.id "
        );
        
        List<Object> params = new ArrayList<>();
        String likeKey = "%" + searchKey + "%";
        
        if (!searchKey.isEmpty()) {
            query.append(" WHERE (b.customer_name LIKE ? OR b.phone LIKE ?)");
            params.add(likeKey);
            params.add(likeKey);
        }

        query.append(" ORDER BY b.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query.toString());
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng hàm helper
                list.add(extractBookingFromResultSet(rs)); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    /**
     * HÀM 3 SỬA ĐỔI: Lấy đơn theo TRẠNG THÁI (phân trang + tìm kiếm + JOIN LẤY TÊN BÀN)
     */
    public List<Booking> getBookingsByStatus(String status, int pageIndex, int pageSize, String searchKey) {
        List<Booking> list = new ArrayList<>();
        int offset = (pageIndex - 1) * pageSize;
        
        // Cập nhật câu SQL với LEFT JOIN
        StringBuilder query = new StringBuilder(
            "SELECT b.*, rt.name as TableName " +
            "FROM Bookings b " +
            "LEFT JOIN BookingTables bt ON b.id = bt.booking_id " +
            "LEFT JOIN RestaurantTables rt ON bt.table_id = rt.id " +
            "WHERE b.status = ?"
        );
        
        List<Object> params = new ArrayList<>();
        params.add(status);
        String likeKey = "%" + searchKey + "%";
        
        if (!searchKey.isEmpty()) {
            query.append(" AND (b.customer_name LIKE ? OR b.phone LIKE ?)");
            params.add(likeKey);
            params.add(likeKey);
        }

        query.append(" ORDER BY b.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng hàm helper
                list.add(extractBookingFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    
    public Booking getBookingById(int bookingId) {
        String query = "SELECT * FROM Bookings WHERE id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getInt("id"),
                        rs.getString("customer_name"),
                        rs.getString("phone"),
                        rs.getDate("booking_date"),
                        rs.getTime("booking_time"),
                        rs.getInt("num_people"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null; // Không tìm thấy
    }
    
    /**
     * Cập nhật trạng thái cho một đơn đặt bàn (Pending -> Confirmed, Canceled...)
     */
    public boolean updateBookingStatus(int bookingId, String status) {
        String query = "UPDATE Bookings SET status = ? WHERE id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0; // Trả về true nếu cập nhật thành công
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnections();
        }
    }
    
    private Booking extractBookingFromResultSet(ResultSet rs) throws Exception {
        Booking booking = new Booking(
                rs.getInt("id"),
                rs.getString("customer_name"),
                rs.getString("phone"),
                rs.getDate("booking_date"),
                rs.getTime("booking_time"),
                rs.getInt("num_people"),
                rs.getString("note"),
                rs.getString("status"),
                rs.getTimestamp("created_at")
        );
        // Thêm tên bàn (nếu có) từ JOIN
        booking.setAssignedTableName(rs.getString("TableName"));
        return booking;
    }
    
    // Hàm đóng kết nối (Bạn đã có hàm này)
    private void closeConnections() {
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) conn.close(); } catch (Exception e) {};
    }
}