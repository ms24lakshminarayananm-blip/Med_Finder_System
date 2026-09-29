package com.medicinefinder.model;

import java.io.Serializable;

public class Medicine implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String medicineName;
    private String category;
    private double price;
    private int quantity;
    private int pharmacyId;
    private String pharmacyName;
    private String pharmacyLocation;

    public Medicine() {}

    public Medicine(int id, String medicineName, String category, double price, int quantity, int pharmacyId) {
        this.id = id;
        this.medicineName = medicineName;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.pharmacyId = pharmacyId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getPharmacyId() { return pharmacyId; }
    public void setPharmacyId(int pharmacyId) { this.pharmacyId = pharmacyId; }

    public String getPharmacyName() { return pharmacyName; }
    public void setPharmacyName(String pharmacyName) { this.pharmacyName = pharmacyName; }

    public String getPharmacyLocation() { return pharmacyLocation; }
    public void setPharmacyLocation(String pharmacyLocation) { this.pharmacyLocation = pharmacyLocation; }

    public String getAvailabilityStatus() {
        return quantity > 0 ? "Available (" + quantity + " in stock)" : "Out of Stock";
    }
}
