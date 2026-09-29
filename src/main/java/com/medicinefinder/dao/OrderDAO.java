package com.medicinefinder.dao;

import com.medicinefinder.model.Order;
import com.medicinefinder.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public boolean createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, medicine_id, quantity, total_price, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getMedicineId());
            ps.setInt(3, order.getQuantity());
            ps.setDouble(4, order.getTotalPrice());
            ps.setString(5, order.getStatus() != null ? order.getStatus() : "Confirmed");

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, m.medicine_name FROM orders o " +
                     "JOIN medicines m ON o.medicine_id = m.id " +
                     "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt("id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setMedicineId(rs.getInt("medicine_id"));
                    o.setMedicineName(rs.getString("medicine_name"));
                    o.setQuantity(rs.getInt("quantity"));
                    o.setTotalPrice(rs.getDouble("total_price"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    o.setStatus(rs.getString("status"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
