/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

/**
 *
 * @author PC
 */
public class ProductDAO {

    Connection conn;

    public ProductDAO() {
        conn = new Connect().getConnection();
    }

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getById(int id) {
        String sql = "SELECT * FROM products WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getByCategory(String category) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void CartToDB(String username, int productId, int quantity) {
        // Nếu trùng (username, product_id) thì cập nhật số lượng mới (quantity)
        String sql = "INSERT INTO cart (username, product_id, quantity) VALUES (?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE quantity = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setInt(2, productId);
            st.setInt(3, quantity);
            st.setInt(4, quantity);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi CartToDB: " + e.getMessage());
        }
    }

    public java.util.Map<Integer, Integer> getCartFromDB(String username) {
        java.util.Map<Integer, Integer> cart = new java.util.HashMap<>();
        String sql = "SELECT product_id, quantity FROM cart WHERE username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                cart.put(rs.getInt("product_id"), rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getCartFromDB: " + e.getMessage());
        }
        return cart;
    }

    public void removeFromDB(String username, int productId) {
        String sql = "DELETE FROM cart WHERE username = ? AND product_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setInt(2, productId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi xóa sản phẩm DB: " + e.getMessage());
        }
    }

    public List<Product> getProductByType(int type) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE type = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
