package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product; // Import model Product của bạn

public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Lấy tất cả sản phẩm từ CSDL
     */
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE is_active = 1"; // Chỉ lấy món đang bán
        try {
            conn = DBConnection.getConnection(); // Lấy kết nối
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getBoolean("is_active")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả kết nối
            try { if (rs != null) rs.close(); } catch (Exception e) {};
            try { if (ps != null) ps.close(); } catch (Exception e) {};
            try { if (conn != null) conn.close(); } catch (Exception e) {};
        }
        return list;
    }

    /**
     * Lấy 1 sản phẩm bằng ID (Rất quan trọng cho giỏ hàng)
     */
    public Product getProductById(int productId) {
        String query = "SELECT * FROM Products WHERE id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getBoolean("is_active")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {};
            try { if (ps != null) ps.close(); } catch (Exception e) {};
            try { if (conn != null) conn.close(); } catch (Exception e) {};
        }
        return null; // Trả về null nếu không tìm thấy
    }
    
    // Bạn có thể thêm các hàm khác như getProductsByCategoryId(int id) ở đây
}