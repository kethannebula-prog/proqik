package com.proqik.model;

public class Testimonial {
    private String text;
    private String avatar;
    private String name;
    private String role;

    public Testimonial() {}

    public Testimonial(String text, String avatar, String name, String role) {
        this.text = text;
        this.avatar = avatar;
        this.name = name;
        this.role = role;
    }

    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
