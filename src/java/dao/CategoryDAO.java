package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category; // Import model Category của bạn

public class CategoryDAO {
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Lấy tất cả danh mục
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT * FROM Categories";
        try {
            conn = DBConnection.getConnection(); // Lấy kết nối
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {};
            try { if (ps != null) ps.close(); } catch (Exception e) {};
            try { if (conn != null) conn.close(); } catch (Exception e) {};
        }
        return list;
    }
}