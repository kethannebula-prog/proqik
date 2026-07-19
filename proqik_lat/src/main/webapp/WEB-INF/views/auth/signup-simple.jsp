<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up - ProQik</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f0f5ff; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .container { background: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 4px 24px rgba(18,47,102,0.1); width: 100%; max-width: 420px; }
        h1 { color: #122f66; font-size: 28px; margin-bottom: 8px; }
        p.subtitle { color: #666; margin-bottom: 24px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; color: #122f66; font-weight: 600; margin-bottom: 6px; font-size: 14px; }
        input, select { width: 100%; padding: 12px 16px; border: 2px solid #eef1f8; border-radius: 8px; font-size: 15px; transition: border-color 0.2s; }
        input:focus, select:focus { outline: none; border-color: #122f66; }
        .btn { width: 100%; padding: 14px; background: #122f66; color: #fff; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; margin-top: 8px; }
        .btn:hover { background: #1e55b0; }
        .login-link { text-align: center; margin-top: 20px; color: #666; }
        .login-link a { color: #122f66; font-weight: 600; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Create Account</h1>
        <p class="subtitle">Join ProQik as a vendor</p>
        
        <form action="<%= request.getContextPath() %>/register" method="POST">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required placeholder="Your full name">
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required placeholder="you@example.com">
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone" required placeholder="+91 9876543210">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="Min 6 characters" minlength="6">
            </div>
            <div class="form-group">
                <label>Service Type</label>
                <select name="service">
                    <option value="photography">Photography</option>
                    <option value="videography">Videography</option>
                    <option value="catering">Catering</option>
                    <option value="decoration">Decoration</option>
                </select>
            </div>
            <div class="form-group">
                <label>Specialty</label>
                <select name="categories">
                    <option value="Wedding">Wedding</option>
                    <option value="Corporate">Corporate</option>
                    <option value="Birthday">Birthday</option>
                    <option value="Events">Events</option>
                </select>
            </div>
            <button type="submit" class="btn">Create Account</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="<%= request.getContextPath() %>/login">Sign In</a>
        </div>
    </div>
</body>
</html>