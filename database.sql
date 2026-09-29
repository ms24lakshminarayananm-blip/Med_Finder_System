-- ==================================================
-- MEDICINE AVAILABILITY FINDER SYSTEM
-- Database Creation & Sample Data Script
-- MySQL 8.x Compatible
-- ==================================================

DROP DATABASE IF EXISTS medicine_finder_db;
CREATE DATABASE medicine_finder_db;
USE medicine_finder_db;

-- 1. Table: users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Table: pharmacies
CREATE TABLE pharmacies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pharmacy_name VARCHAR(150) NOT NULL,
    location VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- 3. Table: medicines
CREATE TABLE medicines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    pharmacy_id INT NOT NULL,
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(id) ON DELETE CASCADE
);

-- 4. Table: orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Confirmed',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE
);

-- 5. Table: feedback
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    rating INT NOT NULL,
    comments TEXT NOT NULL,
    feedback_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==================================================
-- INSERT SAMPLE DATA
-- ==================================================

-- Sample Users (Default demo login: user@example.com / password123)
INSERT INTO users (name, email, password) VALUES
('John Doe', 'user@example.com', 'password123'),
('Alice Smith', 'alice@gmail.com', 'alice123'),
('Bob Johnson', 'bob@yahoo.com', 'bobsecure');

-- Sample Pharmacies
INSERT INTO pharmacies (pharmacy_name, location, phone) VALUES
('Apollo Pharmacy', 'MG Road, Main City', '044-28394001'),
('MedPlus Healthcare', 'Anna Nagar, West Wing', '044-26218002'),
('Care & Cure Medicals', 'Gandhi Street, Central', '044-24359003'),
('Health First Pharmacy', 'Station Road, North', '044-25671004');

-- Sample Medicines
INSERT INTO medicines (medicine_name, category, price, quantity, pharmacy_id) VALUES
('Paracetamol 650mg', 'Fever & Pain', 25.00, 150, 1),
('Amoxicillin 500mg', 'Antibiotic', 120.00, 80, 1),
('Cetirizine 10mg', 'Allergy', 35.00, 200, 2),
('Ibuprofen 400mg', 'Pain Relief', 45.00, 100, 2),
('Azithromycin 500mg', 'Antibiotic', 180.00, 45, 3),
('Pantoprazole 40mg', 'Gastric', 95.00, 120, 3),
('Cough Syrup (Benadryl)', 'Cold & Cough', 85.00, 60, 4),
('Vitamin C 500mg', 'Supplements', 65.00, 300, 4),
('Metformin 500mg', 'Diabetes', 50.00, 180, 1),
('Amlodipine 5mg', 'Blood Pressure', 40.00, 90, 2);

-- Sample Feedback
INSERT INTO feedback (name, email, rating, comments) VALUES
('John Doe', 'user@example.com', 5, 'Great system! Found Paracetamol available near my location instantly.'),
('Alice Smith', 'alice@gmail.com', 4, 'Very helpful application for checking stock before visiting pharmacy.');

-- Sample Orders
INSERT INTO orders (user_id, medicine_id, quantity, total_price, status) VALUES
(1, 1, 2, 50.00, 'Confirmed'),
(1, 3, 1, 35.00, 'Confirmed');

SELECT 'Database and sample data created successfully!' AS status;
