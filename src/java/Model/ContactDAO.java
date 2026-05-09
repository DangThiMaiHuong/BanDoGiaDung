/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author PC
 */
public class ContactDAO {

    public void insertOrUpdate(Contact c) {
        String checkSql = "SELECT * FROM contact WHERE user_id = ?";

        try {
            Connection conn = new Connect().getConnection();

            PreparedStatement check = conn.prepareStatement(checkSql);
            check.setObject(1, c.getUserId());
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                //đã tồn tại → UPDATE
                String updateSql = "UPDATE contact SET message = ? WHERE user_id = ?";
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setString(1, c.getMessage());
                ps.setObject(2, c.getUserId());
                ps.executeUpdate();
            } else {
                //chưa có → INSERT
                String insertSql = "INSERT INTO contact(user_id, name, email, message) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(insertSql);
                ps.setObject(1, c.getUserId());
                ps.setString(2, c.getName());
                ps.setString(3, c.getEmail());
                ps.setString(4, c.getMessage());
                ps.executeUpdate();
            }

        } catch (SQLException e) {
        }
    }
    
    // Hàm lấy danh sách hiển thị cho Admin
    public List<Contact> getAllContacts() {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT * FROM contact"; // Đảm bảo tên bảng trong DB là 'contact'
        try {
            Connection conn = new Connect().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Contact c = new Contact();
                c.setId(rs.getInt("id"));
                c.setUserId((Integer) rs.getObject("user_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setMessage(rs.getString("message"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getAllContacts: " + e.getMessage());
        }
        return list;
    }
    //hàm này sẽ đẩy dữ liệu vào bảng thông báo
    public void sendNotification(String username, String msg) {
    String sql = "INSERT INTO notifications(username, message, is_read) VALUES (?, ?, 0)";
    try (Connection conn = new Connect().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ps.setString(2, msg);
        ps.executeUpdate();
    } catch (Exception e) {
        System.out.println("Lỗi sendNotification: " + e.getMessage());
    }
}
    
    //lấy toàn bộ các thông báo dành riêng cho người dùng đang đăng nhập, xếp cái mới nhất lên đầu
    public List<Map<String, Object>> getNotificationsByUser(String username) {
    List<Map<String, Object>> list = new ArrayList<>();
    String sql = "SELECT id, message, is_read, created_at FROM notifications WHERE username = ? ORDER BY created_at DESC";
    try (Connection conn = new Connect().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", rs.getInt("id"));
            map.put("message", rs.getString("message"));
            map.put("is_read", rs.getInt("is_read"));
            map.put("date", rs.getTimestamp("created_at"));
            list.add(map);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    
    // Đếm số lượng thông báo chưa đọc (is_read = 0) của một người dùng
public int getUnreadNotificationCount(String username) {
    int count = 0;
    // Chúng ta đếm các dòng có is_read bằng 0 (chưa đọc)
    String sql = "SELECT COUNT(*) FROM notifications WHERE username = ? AND is_read = 0";
    
    try (Connection conn = new Connect().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            count = rs.getInt(1); // Lấy giá trị từ cột đầu tiên của kết quả COUNT
        }
    } catch (Exception e) {
        System.out.println("Lỗi getUnreadNotificationCount: " + e.getMessage());
    }
    return count;
}
}
