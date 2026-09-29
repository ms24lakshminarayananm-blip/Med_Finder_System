package com.medicinefinder.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection provides JDBC connections to MySQL database 'medicine_finder_db'.
 * Modify URL, USER, and PASSWORD constants below as per your local MySQL setup.
 */
public class DBConnection {

    // EDIT YOUR DATABASE CONFIGURATION HERE:
    private static final String URL = "jdbc:mysql://localhost:3306/medicine_finder_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; // <-- Enter your MySQL password here

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
