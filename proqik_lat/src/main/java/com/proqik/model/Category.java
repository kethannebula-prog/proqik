package com.proqik.model;

import java.util.List;

public class Category {
    private String name;
    private String icon;
    private String imageUrl;
    private String slug;
    private int proCount;
    private String badge;
    private String badgeClass;

    public Category() {}

    public Category(String name, String icon, String imageUrl, String slug, int proCount, String badge, String badgeClass) {
        this.name = name;
        this.icon = icon;
        this.imageUrl = imageUrl;
        this.slug = slug;
        this.proCount = proCount;
        this.badge = badge;
        this.badgeClass = badgeClass;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    public int getProCount() { return proCount; }
    public void setProCount(int proCount) { this.proCount = proCount; }
    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }
    public String getBadgeClass() { return badgeClass; }
    public void setBadgeClass(String badgeClass) { this.badgeClass = badgeClass; }
}
