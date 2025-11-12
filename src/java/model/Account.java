package model;

import java.sql.Timestamp;

public class Account {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private int role;
    private boolean isActive;
    private Timestamp createdAt;

    public Account() {}

    public Account(int id, String username, String password, String fullName, String email, String phone, int role, boolean isActive, Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    // --- Getters and Setters ---
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}