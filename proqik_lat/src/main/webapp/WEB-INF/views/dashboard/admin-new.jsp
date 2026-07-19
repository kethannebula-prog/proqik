<%-- Admin Dashboard New --%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Admin Dashboard | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&family=JetBrains+Mono&display=swap" rel="stylesheet">
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
html, body { height: 100%; font-family: 'Inter', sans-serif; background: #f5f7fb; color: #15233f; }
a { text-decoration: none; color: inherit; }
button { cursor: pointer; font-family: inherit; }

.dashboard { display: flex; height: 100%; }
.sidebar { width: 260px; background: #0c1d40; color: #fff; flex-shrink: 0; display: flex; flex-direction: column; }
.sidebar-logo { padding: 24px 20px; font-family: 'DM Serif Display', serif; font-size: 28px; }
.sidebar-logo span { color: #c9a84c; font-style: italic; }
.sidebar-section { padding: 20px; }
.sidebar-label { font-size: 10px; font-weight: 500; color: rgba(255,255,255,35); letter-spacing: 0.18em; text-transform: uppercase; margin-bottom: 8px; }
.sidebar-link { display: flex; align-items: center; gap: 12px; padding: 10px 12px; border-radius: 10px; font-size: 13px; font-weight: 500; color: rgba(255,255,255,65); cursor: pointer; }
.sidebar-link:hover { background: rgba(255,255,255,05); color: #fff; }
.sidebar-link.active { background: rgba(201,164,76,12); color: #fff; }
.sidebar-count { margin-left: auto; background: rgba(255,255,255,08); padding: 2px 8px; border-radius: 20px; font-size: 10px; font-weight: 600; }
.main { flex: 1; display: flex; flex-direction: column; min-width: 0; }
.topbar { height: 68px; background: #fff; border-bottom: 1px solid #e5e9f2; display: flex; align-items: center; padding: 0 32px; position: sticky; top: 0; z-index: 50; }
.content { flex: 1; padding: 32px; }
</style>
</head>
<body>

<div class="dashboard">
<aside class="sidebar">
<div class="sidebar-logo">Pro<span>Q</span>ik</div>

<div class="sidebar-section">
<div class="sidebar-label">Overview</div>
<div class="sidebar-link active">Dashboard</div>
<div class="sidebar-link">Bookings <span class="sidebar-count">42</span></div>
<div class="sidebar-link">Professionals <span class="sidebar-count">2.4k</span></div>
<div class="sidebar-link">Applications <span class="sidebar-count">7</span></div>
<div class="sidebar-link">Messages</div>
</div>

<div class="sidebar-section">
<div class="sidebar-label">Insights</div>
<div class="sidebar-link">Analytics</div>
<div class="sidebar-link">Revenue</div>
<div class="sidebar-link">Reviews</div>
</div>

<div class="sidebar-section">
<div class="sidebar-label">Account</div>
<div class="sidebar-link">Sign Out</div>
</div>
</aside>

<main class="main">
<div class="topbar">
<div style="color: #8b96b0;">Console / Overview</div>
</div>

<div class="content">
<h1>Dashboard</h1>
<p style="color: #8b96b0; margin-top: 8px;">Welcome to ProQik Admin Dashboard</p>
</div>
</main>
</div>

</body>
</html>