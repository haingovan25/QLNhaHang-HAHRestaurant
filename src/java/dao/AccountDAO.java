package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account; // Đảm bảo import đúng model Account của bạn

public class AccountDAO {
    
    // Hàm này phải trả về đầy đủ đối tượng Account
    public Account login(String username, String password) {
        String sql = "SELECT * FROM Accounts WHERE username = ? AND password = ?";
        // LƯU Ý: Đây là cách login KHÔNG an toàn (SQL Injection, Mật khẩu plaintext)
        // Trong dự án thực tế, bạn PHẢI mã hóa mật khẩu.
        try (Connection conn = DBConnection.getConnection(); // Lớp DBConnection của bạn
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password); 
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Lấy thông tin từ ResultSet và tạo đối tượng Account
                Account acc = new Account();
                acc.setId(rs.getInt("id"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password")); // Không nên lưu pass
                acc.setFullName(rs.getString("full_name"));
                acc.setEmail(rs.getString("email"));
                acc.setPhone(rs.getString("phone"));
                acc.setRole(rs.getInt("role"));
                acc.setActive(rs.getBoolean("is_active"));
                acc.setCreatedAt(rs.getTimestamp("created_at"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Đăng nhập thất bại
    }

    // Hàm này kiểm tra username
    public boolean checkAccountExist(String username) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu rs.getInt(1) > 0
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm này tạo tài khoản mới
    public void register(String username, String password, String fullName, String email, String phone) {
        String sql = "INSERT INTO Accounts (username, [password], full_name, email, phone, [role], is_active) "
                   + "VALUES (?, ?, ?, ?, ?, 0, 1)"; // Mặc định role=0, active=1
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password); // Cần mã hóa mật khẩu này
            ps.setString(3, fullName);
            ps.setString(4, email);
            ps.setString(5, phone);
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}