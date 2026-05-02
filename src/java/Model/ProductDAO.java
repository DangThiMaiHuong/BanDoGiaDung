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
    PreparedStatement ps = null;

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
                        rs.getInt("type"),
                        rs.getString("category")
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
                        rs.getInt("type"),
                        rs.getString("category")
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
                        rs.getInt("type"),
                        rs.getString("category")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

//    public void CartToDB(String username, int productId, int quantity) {
//        // Nếu trùng (username, product_id) thì cập nhật số lượng mới (quantity)
//        String sql = "INSERT INTO cart (username, product_id, quantity) VALUES (?, ?, ?) "
//                + "ON DUPLICATE KEY UPDATE quantity = ?";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setString(1, username);
//            st.setInt(2, productId);
//            st.setInt(3, quantity);
//            st.setInt(4, quantity);
//            st.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println("Lỗi CartToDB: " + e.getMessage());
//        }
//    }
    public void CartToDB(Integer userId, String username, int productId, int quantity) {
        try {
            String checkSql = "SELECT quantity FROM cart WHERE product_id=? AND (user_id=? OR username=?)";
            PreparedStatement checkSt = conn.prepareStatement(checkSql);
            checkSt.setInt(1, productId);
            checkSt.setObject(2, userId);
            checkSt.setString(3, username);

            ResultSet rs = checkSt.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE cart SET quantity=? WHERE product_id=? AND (user_id=? OR username=?)";
                PreparedStatement updateSt = conn.prepareStatement(updateSql);
                updateSt.setInt(1, quantity);
                updateSt.setInt(2, productId);
                updateSt.setObject(3, userId);
                updateSt.setString(4, username);
                updateSt.executeUpdate();
            } else {
                String insertSql = "INSERT INTO cart(user_id, username, product_id, quantity) VALUES (?, ?, ?, ?)";
                PreparedStatement insertSt = conn.prepareStatement(insertSql);
                insertSt.setObject(1, userId);
                insertSt.setString(2, username);
                insertSt.setInt(3, productId);
                insertSt.setInt(4, quantity);
                insertSt.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("Lỗi CartToDB mới: " + e.getMessage());
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

//    public void removeFromDB(String username, int productId) {
//        String sql = "DELETE FROM cart WHERE username = ? AND product_id = ?";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setString(1, username);
//            st.setInt(2, productId);
//            st.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println("Lỗi xóa sản phẩm DB: " + e.getMessage());
//        }
//    }
    public void removeFromDB(Integer userId, String username, int productId) {
        String sql = "DELETE FROM cart WHERE product_id=? AND (user_id=? OR username=?)";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, productId);
            st.setObject(2, userId);
            st.setString(3, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi remove: " + e.getMessage());
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
                        rs.getInt("type"),
                        rs.getString("category")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> SearchTop5(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE name LIKE ? LIMIT 5"; //Top5:giới hạn số lượng kq trả về

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type"),
                        rs.getString("category")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> searchByName(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE name LIKE ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getLong("price"),
                        rs.getObject("discount_percent") != null ? rs.getInt("discount_percent") : null,
                        rs.getInt("type"),
                        rs.getString("category")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isProductExistByName(String name) {
        String sql = "SELECT * FROM products WHERE name = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            return rs.next(); // có dữ liệu → đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addProduct(Product p) throws SQLException {
        String sql = "INSERT INTO `products`(`name`, `price`, `image`, `description`, `category`, `type`, `discount_percent`) VALUES (?,?,?,?,?,?,?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, p.getName());
        ps.setLong(2, p.getPrice());
        ps.setString(3, p.getImage());
        ps.setString(4, p.getDescription());
        ps.setString(5, p.getCategory());
        ps.setInt(6, p.getType());
        ps.setInt(7, p.getDiscount_percent());
        return ps.executeUpdate() > 0;
    }

//    public boolean updateProduct(Product p) throws SQLException{
//        String sql = "UPDATE `thuephong` SET `MaKH`=?,`NgayDen`=?,`NgayDi`=? WHERE MaP=?";
//        ps = conn.prepareStatement(sql);
//        ps.setString(1, kh.getMaKH());
//        ps.setDate(2, kh.getNgayDen());
//        ps.setDate(3, kh.getNgayDi());
//        ps.setInt(4, kh.getMaP());
//        return ps.executeUpdate() > 0;
//    }
//    
//    public boolean deleteProduct(String MaKH) throws SQLException{
//        String sql = "delete from ThuePhong where MaKH=?";
//        ps = conn.prepareStatement(sql);
//        ps.setString(1, MaKH);
//        return ps.executeUpdate() > 0;
//    }
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }

    public boolean updateProduct(Product p) throws SQLException {
        String sql = "UPDATE products SET name=?, price=?, image=?, description=?, category=?, type=?, discount_percent=? WHERE id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, p.getName());
        ps.setLong(2, p.getPrice());
        ps.setString(3, p.getImage());
        ps.setString(4, p.getDescription());
        ps.setString(5, p.getCategory());
        ps.setInt(6, p.getType());
        ps.setInt(7, p.getDiscount_percent());
        ps.setInt(8, p.getId());
        return ps.executeUpdate() > 0;
    }
}
