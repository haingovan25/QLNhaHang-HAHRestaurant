package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Booking;
import model.Order;
import model.OrderDetail;
import model.Product;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * [LOGIC LOGIN] Tìm giỏ hàng (đơn Unpaid) của một tài khoản.
     */
    public Integer findUnpaidOrderId(int accountId) {
        String query = "SELECT id FROM Orders WHERE account_id = ? AND payment_status = 'Unpaid'";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id"); // Tìm thấy
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null; // Không tìm thấy
    }

    /**
     * [LOGIC ĐẶT BÀN] Tạo một Order (giỏ hàng rỗng) mới gắn với Booking.
     */
    public int createEmptyOrder(int accountId, int bookingId) {
        String query = "INSERT INTO Orders (account_id, booking_id, subtotal, discount_amount, total_amount, payment_status, order_status) "
                     + "VALUES (?, ?, 0, 0, 0, 'Unpaid', 'Pending')";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, accountId);
            ps.setInt(2, bookingId);
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về Order ID
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return -1;
    }

    /**
     * [LOGIC THÊM MÓN] Thêm 1 sản phẩm vào Order (giỏ hàng).
     */
    public void addProductToOrder(int orderId, Product product) {
        String checkQuery = "SELECT * FROM OrderDetails WHERE order_id = ? AND product_id = ?";
        String pkColumnName = "id"; 

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 

            int detailId = -1;
            int currentQuantity = 0;
            
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, orderId);
            ps.setInt(2, product.getId());
            rs = ps.executeQuery();
            
            if (rs.next()) {
                detailId = rs.getInt(pkColumnName);
                currentQuantity = rs.getInt("quantity");
            }
            rs.close();
            ps.close();

            if (detailId != -1) {
                // Đã có -> UPDATE
                ps = conn.prepareStatement("UPDATE OrderDetails SET quantity = ? WHERE " + pkColumnName + " = ?");
                ps.setInt(1, currentQuantity + 1); // Tăng số lượng
                ps.setInt(2, detailId);
                ps.executeUpdate();
            } else {
                // Chưa có -> INSERT mới
                String insertQuery = "INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES (?, ?, 1, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, orderId);
                ps.setInt(2, product.getId());
                ps.setDouble(3, product.getPrice());
                ps.executeUpdate();
            }
            ps.close();

            // --- Bước 2: Cập nhật lại tổng tiền ---
            updateOrderTotal(conn, orderId); // Gọi hàm helper

            conn.commit(); // Hoàn tất Transaction
            
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback(); 
            } catch (Exception e2) {
                e2.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    /**
     * [HÀM BỊ THIẾU] Lấy toàn bộ thông tin giỏ hàng (Order)
     */
    public Order getOrderById(int orderId) {
        Order order = null;
        String orderQuery = "SELECT * FROM Orders WHERE id = ?";
        String bookingQuery = "SELECT * FROM Bookings WHERE id = ?";
        String detailsQuery = "SELECT od.*, p.name as product_name, p.image_url "
                           + "FROM OrderDetails od "
                           + "JOIN Products p ON od.product_id = p.id "
                           + "WHERE od.order_id = ?";

        try {
            conn = DBConnection.getConnection();
            
            // 1. Lấy thông tin Order chính
            ps = conn.prepareStatement(orderQuery);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setAccountId(rs.getInt("account_id"));
                order.setBookingId(rs.getInt("booking_id"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setDiscountAmount(rs.getDouble("discount_amount"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
            }
            rs.close();
            ps.close();

            if (order == null) return null; // Không tìm thấy Order

            // 2. Lấy thông tin Booking (nếu có)
            if (order.getBookingId() > 0) {
                ps = conn.prepareStatement(bookingQuery);
                ps.setInt(1, order.getBookingId());
                rs = ps.executeQuery();
                if (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setCustomerName(rs.getString("customer_name"));
                    booking.setPhone(rs.getString("phone"));
                    booking.setBookingDate(rs.getDate("booking_date"));
                    booking.setBookingTime(rs.getTime("booking_time"));
                    order.setBooking(booking); // Gán booking vào order
                }
                rs.close();
                ps.close();
            }

            // 3. Lấy danh sách OrderDetails (các món ăn)
            List<OrderDetail> details = new ArrayList<>();
            ps = conn.prepareStatement(detailsQuery);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setId(rs.getInt("id")); 
                detail.setOrderId(rs.getInt("order_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImageUrl(rs.getString("image_url"));
                product.setPrice(rs.getDouble("price")); 
                
                detail.setProduct(product); // Gán product vào detail
                details.add(detail); // Thêm vào danh sách
            }
            order.setDetails(details); // Gán danh sách món ăn vào Order

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return order;
    }

    /**
     * [LOGIC CẬP NHẬT GIỎ HÀNG] Cập nhật số lượng
     */
    public void updateProductQuantity(int orderId, int productId, int quantity) {
        String updateQuery = "UPDATE OrderDetails SET quantity = ? WHERE order_id = ? AND product_id = ?";
        String deleteQuery = "DELETE FROM OrderDetails WHERE order_id = ? AND product_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            if (quantity <= 0) {
                // Xóa món
                ps = conn.prepareStatement(deleteQuery);
                ps.setInt(1, orderId);
                ps.setInt(2, productId);
            } else {
                // Cập nhật số lượng
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, quantity);
                ps.setInt(2, orderId);
                ps.setInt(3, productId);
            }
            ps.executeUpdate();
            ps.close();

            // Cập nhật lại tổng tiền
            updateOrderTotal(conn, orderId); 

            conn.commit(); 
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception e2) {}
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * [LOGIC XÓA MÓN]
     */
    public void removeProductFromOrder(int orderId, int productId) {
        updateProductQuantity(orderId, productId, 0); // Gọi update với số lượng 0
    }

    /**
     * [HÀM MỚI] Xóa sạch giỏ hàng (Tất cả OrderDetails)
     */
    public void clearCart(int orderId) {
        String deleteQuery = "DELETE FROM OrderDetails WHERE order_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction
            
            // Bước 1: Xóa tất cả chi tiết đơn hàng
            ps = conn.prepareStatement(deleteQuery);
            ps.setInt(1, orderId);
            ps.executeUpdate();
            ps.close();
            
            // Bước 2: Cập nhật tổng tiền về 0
            updateOrderTotal(conn, orderId);
            
            conn.commit(); // Hoàn tất
            
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception e2) {}
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * HÀM NỘI BỘ: Cập nhật lại tổng tiền (subtotal, total_amount)
     */
    private void updateOrderTotal(Connection conn, int orderId) throws Exception {
        // Dùng ISNULL để tránh lỗi nếu giỏ hàng rỗng (SUM trả về NULL)
        String query = "UPDATE Orders SET "
                     + "subtotal = ISNULL((SELECT SUM(price * quantity) FROM OrderDetails WHERE order_id = ?), 0), "
                     + "total_amount = ISNULL((SELECT SUM(price * quantity) FROM OrderDetails WHERE order_id = ?), 0) "
                     + "WHERE id = ?";
        
        PreparedStatement psUpdate = conn.prepareStatement(query);
        psUpdate.setInt(1, orderId);
        psUpdate.setInt(2, orderId);
        psUpdate.setInt(3, orderId);
        psUpdate.executeUpdate();
        psUpdate.close();
    }
    
    // Hàm tiện ích để đóng kết nối
    private void closeConnections() {
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) conn.close(); } catch (Exception e) {};
    }
    public void updatePaymentStatus(int orderId, String paymentStatus, String orderStatus, String paymentMethod) {
        String query = "UPDATE Orders SET payment_status = ?, order_status = ?, payment_method = ? "
                     + "WHERE id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, paymentStatus);
            ps.setString(2, orderStatus);
            ps.setString(3, paymentMethod);
            ps.setInt(4, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    public Order getOrderByBookingId(int bookingId) {
        String query = "SELECT id FROM Orders WHERE booking_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                int orderId = rs.getInt("id");
                // Tái sử dụng hàm getOrderById (đã bao gồm chi tiết món ăn)
                return getOrderById(orderId); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null; // Không có Order nào gắn với Booking này
    }
}