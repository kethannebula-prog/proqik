<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
String vendorName = (String) request.getAttribute("vendorName");
String vendorCategory = (String) request.getAttribute("vendorCategory");
String vendorLocation = (String) request.getAttribute("vendorLocation");
String vendorPhone = (String) request.getAttribute("vendorPhone");
String vendorBusiness = (String) request.getAttribute("vendorBusiness");
String vendorStatus = (String) request.getAttribute("vendorStatus");
String vendorEarnings = (String) request.getAttribute("vendorEarnings");
String vendorBookings = (String) request.getAttribute("vendorBookings");
String vendorRating = (String) request.getAttribute("vendorRating");
Date vendorJoined = (Date) request.getAttribute("vendorJoined");

if (vendorName == null) vendorName = (String) session.getAttribute("userName");
if (vendorName == null || vendorName.isEmpty()) vendorName = "Vendor";
if (vendorCategory == null || vendorCategory.isEmpty()) vendorCategory = "Photography";
if (vendorLocation == null || vendorLocation.isEmpty()) vendorLocation = "Not set";
if (vendorPhone == null || vendorPhone.isEmpty()) vendorPhone = "Not provided";
if (vendorBusiness == null || vendorBusiness.isEmpty()) vendorBusiness = "Not provided";
if (vendorStatus == null) vendorStatus = "incomplete";
if (vendorEarnings == null) vendorEarnings = "0";
if (vendorBookings == null) vendorBookings = "0";
if (vendorRating == null || vendorRating.equals("0")) vendorRating = "-";
if (vendorJoined == null) vendorJoined = new Date();

String userEmail = (String) session.getAttribute("user");
boolean isActive = "complete".equals(vendorStatus) || "active".equals(vendorStatus);

String heroBg, heroPattern, heroIcon;
String cat = vendorCategory != null ? vendorCategory.toLowerCase() : "";
if (cat.contains("video")) {
    heroBg = "linear-gradient(135deg, rgba(30,27,75,0.95) 0%, rgba(49,46,129,0.92) 50%, rgba(30,27,75,0.95) 100%), url('https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=1200&q=80')";
    heroPattern = "url('data:image/svg+xml,<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"60\" height=\"60\"><rect fill=\"none\" stroke=\"rgba(255,255,255,0.08)\" stroke-width=\"1\" x=\"10\" y=\"10\" width=\"40\" height=\"40\"/></svg>')";
    heroIcon = "🎬";
} else if (cat.contains("album")) {
    heroBg = "linear-gradient(135deg, rgba(76,29,149,0.95) 0%, rgba(91,33,182,0.92) 50%, rgba(76,29,149,0.95) 100%), url('https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=1200&q=80')";
    heroPattern = "url('data:image/svg+xml,<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"40\" height=\"40\"><circle fill=\"none\" stroke=\"rgba(255,255,255,0.06)\" cx=\"20\" cy=\"20\" r=\"15\"/></svg>')";
    heroIcon = "📒";
} else {
    heroBg = "linear-gradient(135deg, rgba(30,58,95,0.95) 0%, rgba(15,31,61,0.92) 50%, rgba(30,58,95,0.95) 100%), url('https://images.unsplash.com/photo-1516035069371-29a1b5ccd7c5?w=1200&q=80')";
    heroPattern = "url('data:image/svg+xml,<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"80\" height=\"80\"><polygon fill=\"none\" stroke=\"rgba(255,255,255,0.05)\" points=\"40,5 75,30 75,70 40,95 5,70 5,30\"/></svg>')";
    heroIcon = "📷";
}

SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
String joinedDate = vendorJoined != null ? sdf.format(vendorJoined) : "Just now";
String vendorInitials = vendorName.length() > 0 ? vendorName.substring(0,1).toUpperCase() : "V";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Vendor Dashboard | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'DM Sans',sans-serif;background:#f8f9fb;color:#1a1a2e;line-height:1.5}
.container{display:flex;min-height:100vh}
.sidebar{width:260px;background:linear-gradient(180deg,#1e3a5f 0%,#0f172a 100%);color:#fff;padding:24px;position:fixed;height:100vh}
.logo{font-family:'Playfair Display',serif;font-size:26px;font-weight:700;margin-bottom:40px;letter-spacing:-0.5px}
.logo span{color:rgba(255,255,255,0.5);font-style:italic}
.nav-label{font-size:10px;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,0.4);margin:28px 0 12px;font-weight:600}
.nav-item{padding:14px 18px;border-radius:10px;color:rgba(255,255,255,0.7);cursor:pointer;display:flex;align-items:center;gap:12px;font-size:14px;transition:0.25s;text-decoration:none;font-weight:500}
.nav-item:hover,.nav-item.active{background:rgba(255,255,255,0.12);color:#fff}
.nav-item.active{box-shadow:0 4px 12px rgba(0,0,0,0.15)}
.main{flex:1;margin-left:260px}
.topbar{background:#fff;padding:20px 40px;border-bottom:1px solid #e5e7eb;display:flex;align-items:center;justify-content:space-between;box-shadow:0 1px 3px rgba(0,0,0,0.04)}
.page-title{font-size:22px;font-weight:600;color:#1a1a2e}
.user{display:flex;align-items:center;gap:14px}
.user-info{text-align:right}
.user-name{font-weight:600;font-size:14px}
.user-email{font-size:12px;color:#6b7280}
.avatar{width:44px;height:44px;border-radius:12px;background:linear-gradient(135deg,#1e3a5f,#2d5a8e);color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:18px;box-shadow:0 4px 12px rgba(30,58,95,0.3)}
.content{padding:32px 40px}
.hero{background:<%= heroBg %>;background-size:cover;background-position:center;border-radius:20px;padding:48px;margin-bottom:32px;position:relative;overflow:hidden;box-shadow:0 20px 50px rgba(0,0,0,0.2)}
.hero::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;background-image:<%= heroPattern %>;background-size:50px 50px;opacity:1}
.hero::after{content:'<%= heroIcon %>';position:absolute;right:-20px;bottom:-40px;font-size:220px;opacity:0.06;transform:rotate(-15deg)}
.hero-content{position:relative;z-index:1}
.hero-badge{display:inline-flex;align-items:center;gap:8px;padding:8px 16px;background:rgba(255,255,255,0.15);border-radius:30px;color:#fff;font-size:13px;font-weight:500;backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1)}
.hero-badge.active{background:rgba(16,185,129,0.9)}
.hero-badge.pending{background:rgba(245,158,11,0.9)}
.hero h1{font-size:38px;font-weight:700;color:#fff;margin-bottom:12px;letter-spacing:-0.5px}
.hero p{font-size:16px;color:rgba(255,255,255,0.8);margin-top:4px;font-weight:500}
.hero-sub{display:flex;align-items:center;gap:20px;margin-top:20px}
.hero-sub span{color:rgba(255,255,255,0.7);font-size:14px}
.hero-divider{width:1px;height:20px;background:rgba(255,255,255,0.3)}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:24px;margin-bottom:32px}
.stat{background:#fff;border-radius:16px;padding:24px;box-shadow:0 2px 8px rgba(0,0,0,0.06);transition:0.3s;position:relative;overflow:hidden}
.stat::before{content:'';position:absolute;top:0;left:0;width:4px;height:100%;border-radius:4px 0 0 4px}
.stat:hover{transform:translateY(-4px);box-shadow:0 8px 25px rgba(0,0,0,0.1)}
.stat-icon{width:52px;height:52px;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:22px;margin-bottom:16px}
.stat-blue{background:linear-gradient(135deg,#e0e7ff,#c7d2fe);color:#4f46e5}
.stat-green{background:linear-gradient(135deg,#d1fae5,#a7f3d0);color:#059669}
.stat-amber{background:linear-gradient(135deg,#fef3c7,#fde68a);color:#d97706}
.stat-purple{background:linear-gradient(135deg,#ede9fe,#ddd6fe);color:#7c3aed}
.stat-label{font-size:12px;color:#6b7280;text-transform:uppercase;font-weight:600;letter-spacing:0.5px}
.stat-value{font-size:28px;font-weight:700;margin-top:8px;color:#1a1a2e;letter-spacing:-0.5px}
.stat-change{font-size:12px;color:#059669;margin-top:4px;font-weight:500}
.card{background:#fff;border-radius:16px;box-shadow:0 2px 8px rgba(0,0,0,0.06);overflow:hidden;margin-bottom:24px}
.card-header{padding:20px 24px;border-bottom:1px solid #f3f4f6;display:flex;align-items:center;justify-content:space-between}
.card-title{font-size:18px;font-weight:600;color:#1a1a2e}
.card-body{padding:24px}
.profile-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}
.profile-item{background:linear-gradient(135deg,#f8f9fb,#f1f5f9);padding:20px;border-radius:12px;border:1px solid #e5e7eb}
.profile-label{font-size:11px;color:#6b7280;text-transform:uppercase;font-weight:600;margin-bottom:8px;letter-spacing:0.5px}
.profile-value{font-size:15px;font-weight:600;color:#1a1a2e}
.actions{display:flex;gap:12px;margin-top:24px}
.btn{padding:12px 24px;border-radius:10px;font-size:14px;font-weight:600;border:none;cursor:pointer;display:inline-flex;align-items:center;gap:8px;transition:0.25s;text-decoration:none}
.btn-primary{background:linear-gradient(135deg,#1e3a5f,#2d5a8e);color:#fff;box-shadow:0 4px 15px rgba(30,58,95,0.3)}
.btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(30,58,95,0.4)}
.btn-secondary{background:#f3f4f6;color:#374151;border:1px solid #e5e7eb}
.btn-secondary:hover{background:#e5e7eb}
.section-title{font-size:16px;font-weight:600;margin-bottom:16px;color:#1a1a2e}
.quick-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px}
.qstat{background:linear-gradient(135deg,#f8f9fb,#fff);padding:16px;border-radius:12px;text-align:center;border:1px solid #e5e7eb}
.qstat-value{font-size:22px;font-weight:700;color:#1a1a2e}
.qstat-label{font-size:11px;color:#6b7280;text-transform:uppercase;font-weight:500;margin-top:4px}
@media(max-width:1200px){.stats{grid-template-columns:repeat(2,1fr)}}
@media(max-width:768px){.sidebar{display:none}.main{margin-left:0}.stats{grid-template-columns:1fr}.profile-grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<div class="container">
<aside class="sidebar">
<div class="logo">Pro<span>Qik</span></div>
<nav>
<div class="nav-label">Main</div>
<a href="<%= request.getContextPath() %>/dashboard" class="nav-item active">◉ Dashboard</a>
<a href="<%= request.getContextPath() %>/bookings" class="nav-item">◈ Bookings</a>
<a href="<%= request.getContextPath() %>/portfolio" class="nav-item">◎ Portfolio</a>
<a href="<%= request.getContextPath() %>/services" class="nav-item">⚡ Services</a>
<a href="<%= request.getContextPath() %>/messages" class="nav-item">◇ Messages</a>
<div class="nav-label">Account</div>
<a href="<%= request.getContextPath() %>/profile" class="nav-item">⚙ Profile</a>
<a href="<%= request.getContextPath() %>/earnings" class="nav-item">💰 Earnings</a>
<a href="<%= request.getContextPath() %>/logout" class="nav-item">⏻ Logout</a>
</nav>
</aside>
<main class="main">
<header class="topbar">
<div><h1 class="page-title">Welcome back, <%= vendorName %>!</h1></div>
<div class="user">
<div class="user-info">
<div class="user-name"><%= vendorName %></div>
<div class="user-email"><%= userEmail %></div>
</div>
<div class="avatar"><%= vendorInitials %></div>
</div>
</header>
<div class="content">
<div class="hero">
<div class="hero-content">
<h1>Welcome, <%= vendorName %>!</h1>
<p><%= vendorBusiness %> • <%= vendorCategory %> Service Provider</p>
<div class="hero-sub">
<span class="hero-badge <%= isActive ? "active" : "pending" %>"><%= isActive ? "✓ Active" : "⏳ Pending Approval" %></span>
<span><%= vendorLocation %></span>
<span class="hero-divider"></span>
<span>Joined <%= joinedDate %></span>
</div>
</div>
</div>
<div class="quick-stats">
<div class="qstat">
<div class="qstat-value"><%= vendorCategory %></div>
<div class="qstat-label">Service</div>
</div>
<div class="qstat">
<div class="qstat-value">₹<%= vendorEarnings %></div>
<div class="qstat-label">Total Earnings</div>
</div>
<div class="qstat">
<div class="qstat-value"><%= vendorBookings %></div>
<div class="qstat-label">Bookings</div>
</div>
<div class="qstat">
<div class="qstat-value"><%= vendorRating %></div>
<div class="qstat-label">Rating</div>
</div>
</div>
<div class="stats">
<div class="stat"><div class="stat-icon stat-blue"><%= heroIcon %></div><div class="stat-label">Service Category</div><div class="stat-value"><%= vendorCategory %></div></div>
<div class="stat"><div class="stat-icon stat-green">💰</div><div class="stat-label">Total Earnings</div><div class="stat-value">₹<%= vendorEarnings %></div></div>
<div class="stat"><div class="stat-icon stat-amber">📅</div><div class="stat-label">Total Bookings</div><div class="stat-value"><%= vendorBookings %></div></div>
<div class="stat"><div class="stat-icon stat-purple">⭐</div><div class="stat-label">Average Rating</div><div class="stat-value"><%= vendorRating %>/5</div></div>
</div>
<div class="card">
<div class="card-header">
<div class="card-title">My Profile</div>
<a href="<%= request.getContextPath() %>/profile" class="btn btn-secondary" style="padding:8px 16px;font-size:13px">✎ Edit</a>
</div>
<div class="card-body">
<div class="profile-grid">
<div class="profile-item"><div class="profile-label">Full Name</div><div class="profile-value"><%= vendorName %></div></div>
<div class="profile-item"><div class="profile-label">Email Address</div><div class="profile-value"><%= userEmail %></div></div>
<div class="profile-item"><div class="profile-label">Phone Number</div><div class="profile-value"><%= vendorPhone %></div></div>
<div class="profile-item"><div class="profile-label">Service Category</div><div class="profile-value"><%= vendorCategory %></div></div>
<div class="profile-item"><div class="profile-label">Business Name</div><div class="profile-value"><%= vendorBusiness %></div></div>
<div class="profile-item"><div class="profile-label">Location</div><div class="profile-value"><%= vendorLocation %></div></div>
<div class="profile-item"><div class="profile-label">Account Status</div><div class="profile-value"><%= isActive ? "Active" : "Pending" %></div></div>
<div class="profile-item"><div class="profile-label">Member Since</div><div class="profile-value"><%= joinedDate %></div></div>
<div class="profile-item"><div class="profile-label">Total Earnings</div><div class="profile-value">₹<%= vendorEarnings %></div></div>
</div>
</div>
</div>
<div class="actions">
<a href="<%= request.getContextPath() %>/bookings" class="btn btn-primary">📅 View My Bookings</a>
<a href="<%= request.getContextPath() %>/portfolio" class="btn btn-secondary">🖼 Manage Portfolio</a>
<a href="<%= request.getContextPath() %>/services" class="btn btn-secondary">⚡ My Services</a>
</div>
</div>
</main>
</div>
</body>
</html>