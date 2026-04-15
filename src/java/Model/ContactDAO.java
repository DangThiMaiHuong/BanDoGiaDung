/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

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

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
