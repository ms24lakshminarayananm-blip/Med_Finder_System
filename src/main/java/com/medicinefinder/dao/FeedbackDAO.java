package com.medicinefinder.dao;

import com.medicinefinder.model.Feedback;
import com.medicinefinder.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    public boolean addFeedback(Feedback f) {
        String sql = "INSERT INTO feedback (name, email, rating, comments) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, f.getName());
            ps.setString(2, f.getEmail());
            ps.setInt(3, f.getRating());
            ps.setString(4, f.getComments());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY feedback_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback f = new Feedback();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setEmail(rs.getString("email"));
                f.setRating(rs.getInt("rating"));
                f.setComments(rs.getString("comments"));
                f.setFeedbackDate(rs.getTimestamp("feedback_date"));
                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
