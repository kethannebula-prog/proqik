package com.proqik.model;

public class Service {
    private Long id;
    private String title;
    private String imageUrl;
    private String sellerName;
    private String sellerAvatar;
    private String level;
    private String badgeClass;
    private float rating;
    private int reviewCount;
    private int startingPrice;
    private boolean hasVideo;
    private boolean isSaved;

    public Service() {}

    public Service(Long id, String title, String imageUrl, String sellerName, String sellerAvatar,
                   String level, String badgeClass, float rating, int reviewCount, int startingPrice,
                   boolean hasVideo, boolean isSaved) {
        this.id = id;
        this.title = title;
        this.imageUrl = imageUrl;
        this.sellerName = sellerName;
        this.sellerAvatar = sellerAvatar;
        this.level = level;
        this.badgeClass = badgeClass;
        this.rating = rating;
        this.reviewCount = reviewCount;
        this.startingPrice = startingPrice;
        this.hasVideo = hasVideo;
        this.isSaved = isSaved;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getSellerName() { return sellerName; }
    public void setSellerName(String sellerName) { this.sellerName = sellerName; }
    public String getSellerAvatar() { return sellerAvatar; }
    public void setSellerAvatar(String sellerAvatar) { this.sellerAvatar = sellerAvatar; }
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    public String getBadgeClass() { return badgeClass; }
    public void setBadgeClass(String badgeClass) { this.badgeClass = badgeClass; }
    public float getRating() { return rating; }
    public void setRating(float rating) { this.rating = rating; }
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    public int getStartingPrice() { return startingPrice; }
    public void setStartingPrice(int startingPrice) { this.startingPrice = startingPrice; }
    public boolean isHasVideo() { return hasVideo; }
    public void setHasVideo(boolean hasVideo) { this.hasVideo = hasVideo; }
    public boolean isSaved() { return isSaved; }
    public void setSaved(boolean saved) { isSaved = saved; }
    
    public String getSlug() {
        return title.toLowerCase().replaceAll("[^a-z0-9]+", "-").replaceAll("^-|-$", "");
    }
    
    public String getBadge() {
        if (badgeClass == null) return null;
        switch (badgeClass) {
            case "gold": return "⭐ Top Rated";
            case "pro": return "Pro";
            default: return "New";
        }
    }
}
