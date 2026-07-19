<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Become a Pro | ProQik</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=Manrope:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/main.css">
</head>
<body>

<div class="cursor-glow" id="cursorGlow"></div>
<div id="toastWrapper"></div>

<div class="auth-container" style="min-height: 100vh;">
    
    <div class="auth-visual">
        <div class="auth-visual-bg">
            <img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=1200&q=90" alt="" class="auth-visual-img">
            <div class="auth-visual-overlay"></div>
        </div>
        <div class="auth-visual-content">
            <a href="<%= request.getContextPath() %>/" class="auth-logo"><img src="<%= request.getContextPath() %>/resources/img/logo.svg" alt="ProQik" style="height:32px"/></a>
            <div class="auth-visual-features">
                <h2>Join India's creative elite</h2>
                <ul>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        Get discovered by hundreds of clients
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        Set your own rates and schedule
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        Secure payments directly to your account
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        Professional growth tools and analytics
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="auth-form-container">
        <div class="auth-form-wrapper" style="max-width: 600px;">
            
            <div class="auth-form-header">
                <h1 class="auth-title">Become a ProQik Professional</h1>
                <p class="auth-subtitle">Fill out the application below and our team will review your profile within 24 hours.</p>
            </div>

            <form action="<%= request.getContextPath() %>/auth/vendor/apply" method="POST" class="auth-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" id="firstName" name="firstName" class="form-input" placeholder="Kavya" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" id="lastName" name="lastName" class="form-input" placeholder="Sharma" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-input" placeholder="kavya@example.com" required>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" id="phone" name="phone" class="form-input" placeholder="+679 ..." required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="category" class="form-label">Category</label>
                        <select id="category" name="category" class="form-select" required>
                            <option value="">Select category...</option>
                            <option value="photography">Photography</option>
                            <option value="videography">Videography</option>
                            <option value="album-editing">Album Editing</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="location" class="form-label">Location</label>
                        <select id="location" name="location" class="form-select" required>
                            <option value="">Select location...</option>
                            <option value="suva">Suva</option>
                            <option value="nadi">Nadi</option>
                            <option value="lautoka">Lautoka</option>
                            <option value="labasa">Labasa</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="bio" class="form-label">Bio (tell us about your work)</label>
                    <textarea id="bio" name="bio" class="form-input form-textarea" rows="4" 
                              placeholder="I am a professional portrait photographer with 5+ years experience..."></textarea>
                </div>

                <button type="submit" class="form-submit">
                    Submit Application
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M5 12h14M12 5l7 7-7 7"/>
                    </svg>
                </button>
            </form>

            <a href="<%= request.getContextPath() %>/" class="auth-back">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M19 12H5M12 19l-7-7 7-7"/>
                </svg>
                Back to ProQik
            </a>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/resources/js/main.js"></script>
</body>
</html>
