package com.medicinefinder.model;

import java.io.Serializable;

public class Pharmacy implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String pharmacyName;
    private String location;
    private String phone;

    public Pharmacy() {}

    public Pharmacy(int id, String pharmacyName, String location, String phone) {
        this.id = id;
        this.pharmacyName = pharmacyName;
        this.location = location;
        this.phone = phone;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPharmacyName() { return pharmacyName; }
    public void setPharmacyName(String pharmacyName) { this.pharmacyName = pharmacyName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
