package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
}