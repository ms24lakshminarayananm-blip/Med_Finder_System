package com.medicinefinder.dao;

import com.medicinefinder.model.Pharmacy;
import com.medicinefinder.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PharmacyDAO {

    public List<Pharmacy> getAllPharmacies() {
        List<Pharmacy> list = new ArrayList<>();
        String sql = "SELECT * FROM pharmacies";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pharmacy p = new Pharmacy();
                p.setId(rs.getInt("id"));
                p.setPharmacyName(rs.getString("pharmacy_name"));
                p.setLocation(rs.getString("location"));
                p.setPhone(rs.getString("phone"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Pharmacy getPharmacyById(int id) {
        String sql = "SELECT * FROM pharmacies WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Pharmacy p = new Pharmacy();
                    p.setId(rs.getInt("id"));
                    p.setPharmacyName(rs.getString("pharmacy_name"));
                    p.setLocation(rs.getString("location"));
                    p.setPhone(rs.getString("phone"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
