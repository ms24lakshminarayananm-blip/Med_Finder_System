package com.medicinefinder.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Feedback implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String email;
    private int rating;
    private String comments;
    private Timestamp feedbackDate;

    public Feedback() {}

    public Feedback(int id, String name, String email, int rating, String comments) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.comments = comments;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }

    public Timestamp getFeedbackDate() { return feedbackDate; }
    public void setFeedbackDate(Timestamp feedbackDate) { this.feedbackDate = feedbackDate; }
}
