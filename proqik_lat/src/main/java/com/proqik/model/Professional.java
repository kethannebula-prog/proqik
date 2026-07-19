package com.proqik.model;

import java.util.List;

public class Professional {
    private Long id;
    private String displayName;
    private String specialty;
    private String coverImage;
    private String avatarUrl;
    private float rating;
    private int reviewCount;
    private boolean isOnline;
    private boolean isVerified;
    private boolean isSaved;
    private int startingRate;
    private List<String> tags;
    private String badgeClass;

    public Professional() {}

    public Professional(Long id, String displayName, String specialty, String coverImage,
                       String avatarUrl, float rating, int reviewCount, boolean isOnline,
                       boolean isVerified, boolean isSaved, int startingRate, List<String> tags,
                       String badgeClass) {
        this.id = id;
        this.displayName = displayName;
        this.specialty = specialty;
        this.coverImage = coverImage;
        this.avatarUrl = avatarUrl;
        this.rating = rating;
        this.reviewCount = reviewCount;
        this.isOnline = isOnline;
        this.isVerified = isVerified;
        this.isSaved = isSaved;
        this.startingRate = startingRate;
        this.tags = tags;
        this.badgeClass = badgeClass;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) { this.displayName = displayName; }
    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    public float getRating() { return rating; }
    public void setRating(float rating) { this.rating = rating; }
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    public boolean isOnline() { return isOnline; }
    public void setOnline(boolean online) { isOnline = online; }
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean verified) { isVerified = verified; }
    public boolean isSaved() { return isSaved; }
    public void setSaved(boolean saved) { isSaved = saved; }
    public int getStartingRate() { return startingRate; }
    public void setStartingRate(int startingRate) { this.startingRate = startingRate; }
    public List<String> getTags() { return tags; }
    public void setTags(List<String> tags) { this.tags = tags; }
    public String getBadgeClass() { return badgeClass; }
    public void setBadgeClass(String badgeClass) { this.badgeClass = badgeClass; }
    
    public String getLocation() {
        if (specialty != null && specialty.contains("·")) {
            return specialty.split("·")[1].trim();
        }
        return "India";
    }
    
    public String getCategoryName() {
        if (specialty != null && specialty.contains("·")) {
            return specialty.split("·")[0].trim();
        }
        return specialty;
    }
    
    public String getBadge() {
        if (badgeClass == null || badgeClass.isEmpty()) return "Verified";
        switch (badgeClass) {
            case "gold": return "⭐ Top Rated";
            case "elite": return "Elite";
            default: return "New";
        }
    }
}
