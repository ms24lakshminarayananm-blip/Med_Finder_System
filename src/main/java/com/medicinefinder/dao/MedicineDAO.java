package com.medicinefinder.dao;

import com.medicinefinder.model.Medicine;
import com.medicinefinder.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    public List<Medicine> searchMedicines(String query, String category, Double maxPrice) {
        List<Medicine> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT m.*, p.pharmacy_name, p.location FROM medicines m " +
            "JOIN pharmacies p ON m.pharmacy_id = p.id WHERE 1=1 "
        );

        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (LOWER(m.medicine_name) LIKE ? OR LOWER(m.category) LIKE ?) ");
        }
        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
            sql.append("AND LOWER(m.category) = ? ");
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append("AND m.price <= ? ");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (query != null && !query.trim().isEmpty()) {
                String q = "%" + query.trim().toLowerCase() + "%";
                ps.setString(paramIndex++, q);
                ps.setString(paramIndex++, q);
            }
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
                ps.setString(paramIndex++, category.trim().toLowerCase());
            }
            if (maxPrice != null && maxPrice > 0) {
                ps.setDouble(paramIndex++, maxPrice);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine m = extractMedicine(rs);
                    list.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Medicine> getAllMedicines() {
        return searchMedicines(null, null, null);
    }

    public Medicine getMedicineById(int id) {
        String sql = "SELECT m.*, p.pharmacy_name, p.location FROM medicines m " +
                     "JOIN pharmacies p ON m.pharmacy_id = p.id WHERE m.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractMedicine(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStock(int medicineId, int quantityDeducted) {
        String sql = "UPDATE medicines SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantityDeducted);
            ps.setInt(2, medicineId);
            ps.setInt(3, quantityDeducted);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Medicine extractMedicine(ResultSet rs) throws SQLException {
        Medicine m = new Medicine();
        m.setId(rs.getInt("id"));
        m.setMedicineName(rs.getString("medicine_name"));
        m.setCategory(rs.getString("category"));
        m.setPrice(rs.getDouble("price"));
        m.setQuantity(rs.getInt("quantity"));
        m.setPharmacyId(rs.getInt("pharmacy_id"));
        m.setPharmacyName(rs.getString("pharmacy_name"));
        m.setPharmacyLocation(rs.getString("location"));
        return m;
    }
}
