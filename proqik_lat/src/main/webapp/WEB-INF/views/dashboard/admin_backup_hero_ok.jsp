<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%
List<Map<String, Object>> pendingVendors = (List<Map<String, Object>>) request.getAttribute("pendingVendors");
List<Map<String, Object>> allVendors = (List<Map<String, Object>>) request.getAttribute("allVendors");
if (pendingVendors == null) pendingVendors = new ArrayList();
if (allVendors == null) allVendors = new ArrayList();
String flashMsg = (String) request.getAttribute("flashMsg");
String adminName = (String) session.getAttribute("userName");
if (adminName == null) adminName = "Admin";
int calcTotal = allVendors.size();
int calcApproved = 0, calcRejected = 0, calcPending = 0;
for (Map<String, Object> v : allVendors) {
    String s = v.get("status") != null ? (String)v.get("status") : "incomplete";
    if ("complete".equals(s) || "approved".equals(s)) calcApproved++;
    else if ("rejected".equals(s)) calcRejected++;
    else calcPending++;
}
String ctx = request.getContextPath();
int pendingCount = pendingVendors.size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PROQIK Admin</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Plus Jakarta Sans',sans-serif;background:#f0f2f5;color:#1a1a2e;min-height:100vh}

/* SIDEBAR */
.sidebar{position:fixed;left:0;top:0;width:220px;height:100vh;background:linear-gradient(180deg,#0f172a 0%,#1e293b 100%);padding:28px 16px;display:flex;flex-direction:column;z-index:100}
.logo{display:flex;align-items:center;gap:10px;margin-bottom:36px}
.logo-icon{width:36px;height:36px;background:linear-gradient(135deg,#6366f1,#8b5cf6);border-radius:10px;display:flex;align-items:center;justify-content:center}
.logo-icon svg{width:20px;height:20px}
.logo-text{font-size:20px;font-weight:800;color:#fff;letter-spacing:1px}
.menu{margin-bottom:auto}
.menu-label{font-size:10px;font-weight:700;letter-spacing:1.5px;color:rgba(255,255,255,.3);text-transform:uppercase;margin-bottom:10px;margin-left:16px}
.menu a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:12px;text-decoration:none;color:rgba(255,255,255,.55);font-size:13px;font-weight:500;margin-bottom:2px;transition:all .2s}
.menu a:hover{background:rgba(255,255,255,.08);color:#fff}
.menu a.active{background:rgba(99,102,241,.2);color:#a5b4fc;font-weight:600}
.menu a svg{width:18px;height:18px;opacity:.7}
.menu a.active svg{opacity:1}
.menu .badge{margin-left:auto;background:#ef4444;color:#fff;font-size:10px;font-weight:700;min-width:20px;height:20px;border-radius:10px;display:flex;align-items:center;justify-content:center}
.sidebar-profile{display:flex;align-items:center;gap:10px;padding:14px;background:rgba(255,255,255,.06);border-radius:12px}
.sidebar-profile img{width:38px;height:38px;border-radius:10px;object-fit:cover}
.sidebar-profile .sp-name{font-size:12px;font-weight:600;color:#fff}
.sidebar-profile .sp-role{font-size:10px;color:rgba(255,255,255,.4)}

/* MAIN */
.main{margin-left:220px;margin-right:300px;padding:24px 32px}

/* TOPBAR */
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:24px}
.topbar-left h1{font-size:24px;font-weight:800;color:#0f1e36;letter-spacing:-.02em}
.topbar-left h1 span{background:linear-gradient(135deg,#1b376c,#c9a84c);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.topbar-left p{font-size:13px;color:#94a3b8;margin-top:2px}
.topbar-actions{display:flex;align-items:center;gap:12px}
.search{position:relative;width:280px}
.search input{width:100%;height:44px;border:1px solid #e2e8f0;border-radius:12px;padding-left:40px;font-size:13px;background:#fff;outline:none;font-family:inherit}
.search input:focus{border-color:#6366f1;box-shadow:0 0 0 3px rgba(99,102,241,.1)}
.search svg{position:absolute;left:14px;top:14px;color:#94a3b8;width:16px;height:16px}
.icon-btn{width:44px;height:44px;border-radius:12px;background:#fff;border:1px solid #e2e8f0;display:flex;align-items:center;justify-content:center;cursor:pointer;position:relative;color:#64748b}
.icon-btn svg{width:18px;height:18px}
.icon-btn .dot{position:absolute;top:8px;right:8px;width:8px;height:8px;background:#ef4444;border-radius:50%;border:2px solid #fff}
.primary-btn{padding:10px 20px;background:linear-gradient(135deg,#6366f1,#8b5cf6);color:#fff;border:none;border-radius:12px;font-weight:600;font-size:13px;cursor:pointer;display:flex;align-items:center;gap:6px;transition:all .2s;font-family:inherit}
.primary-btn:hover{box-shadow:0 4px 12px rgba(99,102,241,.3);transform:translateY(-1px)}

/* FLASH */
.flash{background:linear-gradient(135deg,#ecfdf5,#d1fae5);border:1px solid #86efac;border-radius:12px;padding:14px 20px;font-size:13px;font-weight:500;color:#065f46;margin-bottom:20px;display:flex;align-items:center;gap:10px}
.flash svg{width:18px;height:18px;flex-shrink:0}

/* STATS */
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:28px}
.stat{background:linear-gradient(145deg,#fff,#f8f9fb);border-radius:20px;padding:24px;border:1px solid rgba(201,168,76,.12);position:relative;overflow:hidden;transition:all .35s cubic-bezier(.16,1,.3,1);box-shadow:0 6px 24px rgba(0,0,0,.04)}
.stat:hover{box-shadow:0 12px 40px rgba(0,0,0,.08);transform:translateY(-4px);border-color:rgba(201,168,76,.25)}
.stat-bg{position:absolute;top:-24px;right:-24px;width:100px;height:100px;border-radius:50%;opacity:.06}
.stat:nth-child(1) .stat-bg{background:#1b376c}
.stat:nth-child(2) .stat-bg{background:#16a34a}
.stat:nth-child(3) .stat-bg{background:#f59e0b}
.stat:nth-child(4) .stat-bg{background:#dc2626}
.stat-icon{width:46px;height:46px;border-radius:14px;display:flex;align-items:center;justify-content:center;margin-bottom:16px;position:relative;transition:transform .3s}
.stat:hover .stat-icon{transform:scale(1.06) rotate(3deg)}
.stat:nth-child(1) .stat-icon{background:linear-gradient(135deg,rgba(27,55,108,.1),rgba(27,55,108,.04))}
.stat:nth-child(2) .stat-icon{background:linear-gradient(135deg,rgba(22,163,74,.1),rgba(22,163,74,.04))}
.stat:nth-child(3) .stat-icon{background:linear-gradient(135deg,rgba(245,158,11,.1),rgba(245,158,11,.04))}
.stat:nth-child(4) .stat-icon{background:linear-gradient(135deg,rgba(220,38,38,.1),rgba(220,38,38,.04))}
.stat-icon svg{width:22px;height:22px}
.stat:nth-child(1) .stat-icon svg{color:#1b376c}
.stat:nth-child(2) .stat-icon svg{color:#16a34a}
.stat:nth-child(3) .stat-icon svg{color:#f59e0b}
.stat:nth-child(4) .stat-icon svg{color:#dc2626}
.stat-label{font-size:12px;color:#8b96b0;font-weight:600;letter-spacing:.03em}
.stat-value{font-size:34px;font-weight:800;color:#0f1e36;margin:6px 0 2px;letter-spacing:-.03em;font-family:'Playfair Display',serif}
.stat-sub{font-size:11px;color:#8b96b0}

/* TABLE */
.table-card{background:linear-gradient(145deg,#fff,#f8f9fb);border-radius:20px;border:1px solid rgba(201,168,76,.12);box-shadow:0 10px 40px rgba(0,0,0,.06);overflow:hidden;position:relative}
.table-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#1b376c,#c9a84c)}
.table-head{display:flex;align-items:center;justify-content:space-between;padding:22px 26px;border-bottom:1px solid rgba(201,168,76,.1);background:linear-gradient(135deg,#fafbfc,#f5f7fa)}
.table-head h3{font-size:16px;font-weight:800;color:#0f1e36;letter-spacing:-.02em}
.filters{display:flex;gap:6px}
.filter{padding:7px 16px;border-radius:10px;font-size:12px;font-weight:700;border:1.5px solid #e8ecf3;background:#fff;cursor:pointer;color:#6b7890;transition:all .2s;font-family:inherit;letter-spacing:.02em}
.filter:hover{background:#f0f3fa;color:#1b376c;border-color:#c9d4e8}
.filter.active{background:#1b376c;color:#fff;border-color:#1b376c;box-shadow:0 4px 12px rgba(27,55,108,.25)}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
thead th{padding:14px 22px;text-align:left;font-size:10px;font-weight:800;color:#8b96b0;text-transform:uppercase;letter-spacing:.08em;background:linear-gradient(135deg,#f8f9fb,#f0f2f5);border-bottom:1px solid #e8ecf3}
tbody td{padding:16px 22px;font-size:13px;color:#1a2140;border-bottom:1px solid #f0f2f5}
tbody tr{transition:all .2s;cursor:pointer;position:relative}
tbody tr::before{content:'';position:absolute;left:0;top:0;bottom:0;width:3px;background:#1b376c;transform:scaleY(0);transition:transform .2s cubic-bezier(.16,1,.3,1)}
tbody tr:hover::before{transform:scaleY(1)}
tbody tr:hover td{background:linear-gradient(90deg,rgba(201,168,76,.04),transparent)}
.v-name{font-weight:700;color:#0f1e36;font-size:14px}
.v-email{font-size:11px;color:#8b96b0;margin-top:2px}
.v-avatar{width:40px;height:40px;border-radius:12px;object-fit:cover;flex-shrink:0;border:2px solid #e8ecf3;transition:transform .2s}
tbody tr:hover .v-avatar{transform:scale(1.08)}
.v-info{display:flex;align-items:center;gap:12px}
.badge{display:inline-flex;align-items:center;gap:5px;padding:5px 12px;border-radius:8px;font-size:10px;font-weight:800;letter-spacing:.03em}
.badge-approved{background:linear-gradient(135deg,#dcfce7,#bbf7d0);color:#166534;box-shadow:0 2px 8px rgba(22,163,74,.15)}
.badge-pending{background:linear-gradient(135deg,#fef3c7,#fde68a);color:#92400e;box-shadow:0 2px 8px rgba(245,158,11,.15)}
.badge-rejected{background:linear-gradient(135deg,#fef2f2,#fecaca);color:#991b1b;box-shadow:0 2px 8px rgba(220,38,38,.12)}
.badge-incomplete{background:linear-gradient(135deg,#f8f9fb,#e8ecf3);color:#4a5578;box-shadow:0 2px 8px rgba(74,85,120,.1)}
.btns{display:flex;gap:6px;align-items:center}
.btn-approve{padding:7px 16px;border-radius:10px;font-size:11px;font-weight:700;background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;border:none;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:5px;font-family:inherit;transition:all .2s;box-shadow:0 3px 10px rgba(22,163,74,.25)}
.btn-approve:hover{transform:translateY(-1px);box-shadow:0 6px 16px rgba(22,163,74,.35)}
.btn-reject{padding:7px 16px;border-radius:10px;font-size:11px;font-weight:700;background:#fff;color:#dc2626;border:1.5px solid #fecaca;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:5px;font-family:inherit;transition:all .2s}
.btn-reject:hover{background:#fef2f2;border-color:#fca5a5}
.btn-view{padding:7px 16px;border-radius:10px;font-size:11px;font-weight:700;background:#fff;color:#1b376c;border:1.5px solid #dde4f0;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:5px;font-family:inherit;transition:all .2s}
.btn-view:hover{background:#f0f3fa;border-color:#1b376c;color:#1b376c}
.approved-text{color:#16a34a;font-weight:700;font-size:11px;display:flex;align-items:center;gap:5px;background:linear-gradient(135deg,#dcfce7,#bbf7d0);padding:5px 12px;border-radius:8px;box-shadow:0 2px 8px rgba(22,163,74,.12)}
.empty{text-align:center;padding:56px 20px;color:#8b96b0}
.empty svg{width:52px;height:52px;margin-bottom:14px;opacity:.25}
.empty h3{font-size:16px;font-weight:700;color:#1a2140;margin-bottom:6px}
.empty p{font-size:13px;color:#8b96b0}

/* RESPONSIVE */
@media(max-width:1200px){
  .stats{grid-template-columns:repeat(2,1fr)}
  .topbar-actions .search{width:200px}
}
@media(max-width:900px){
  .sidebar{width:200px}
  .main{margin-left:200px;margin-right:0;padding:20px 20px}
}
@media(max-width:768px){
  .sidebar{display:none}
  .main{margin-left:0;margin-right:0;padding:16px}
  .stats{grid-template-columns:repeat(2,1fr)}
  .topbar{flex-direction:column;align-items:stretch;gap:12px}
  .topbar-actions{flex-wrap:wrap;justify-content:space-between}
  .topbar-actions .search{width:100%;max-width:100%}
  .table-head{flex-direction:column;gap:12px;align-items:stretch}
  .filters{flex-wrap:wrap}
  .btns{flex-wrap:wrap}
  .stat-value{font-size:26px}
}
@media(max-width:480px){
  .main{padding:12px}
  .stats{grid-template-columns:1fr}
  .topbar-left h1{font-size:18px}
  .hero-actions{flex-direction:column;align-items:stretch}
  .hero-btn,.hero-ghost{width:100%;justify-content:center;margin-left:0}
  .hero-stats{flex-direction:column;gap:12px}
  .hero-left h1{font-size:28px}
  .stat-value{font-size:24px}
}
</style>
<link rel="stylesheet" href="<%= ctx %>/resources/css/admin-luxury.css">
</head>
<body>

<div class="sidebar">
    <div>
        <div class="logo">
            <div class="logo-icon"><svg viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2"><path d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z"/><circle cx="12" cy="13" r="4"/></svg></div>
            <div class="logo-text">PROQIK</div>
        </div>
        <nav class="menu">
            <div class="menu-label">Main</div>
            <a class="active" href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg> Dashboard</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14,2 14,8 20,8"/></svg> Projects</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/></svg> Creators</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg> Bookings</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 20V10"/><path d="M12 20V4"/><path d="M6 20v-6"/></svg> Analytics</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/></svg> Finance</a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg> Messages<span class="badge"><%= pendingCount %></span></a>
            <a href="#"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg> Settings</a>
        </div>
    </div>
    <div class="sidebar-profile">
        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face"/>
        <div>
            <div class="sp-name"><%= adminName %></div>
            <div class="sp-role">Administrator</div>
        </div>
    </div>
</div>

<div class="main">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Welcome back, <span><%= adminName %></span></h1>
            <p>Manage vendors, approve registrations, and oversee your platform.</p>
        </div>
        <div class="topbar-actions">
            <div class="search">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                <input type="text" placeholder="Search photographers, services...">
            </div>
            <div class="icon-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg><div class="dot"></div></div>
            <button class="primary-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="16" height="16"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> New Booking</button>
        </div>
    </div>

    <% if (flashMsg != null) { %>
    <div class="flash">
        <svg viewBox="0 0 24 24" fill="none" stroke="#065f46" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg>
        <%= flashMsg %>
    </div>
    <% } %>

    <div class="hero">
        <div class="hero-left">
            <div class="hero-pill">
                <span></span>
                Admin Panel &middot; Vendor Management
            </div>
            <h1>India's Finest<br><strong>Photography</strong><br>Marketplace</h1>
            <p>Authorize professional photographers &amp; videographers. Review profiles, manage bookings and grow your premium platform.</p>
            <div class="hero-actions">
                <button class="hero-btn">
                    <svg viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                    Review Pending
                </button>
                <button class="hero-ghost">View All Vendors</button>
            </div>
            <div class="hero-stats">
                <div class="hs"><strong>500+</strong><span>Verified Creators</span></div>
                <div class="hs"><strong>2K+</strong><span>Bookings Done</span></div>
                <div class="hs"><strong>4.9 &#9733;</strong><span>Avg Rating</span></div>
            </div>
        </div>
        <div class="hero-right">
            <div class="hero-person">
                <img src="<%= ctx %>/resources/img/hero-person-1.png" alt="Photographer">
            </div>
        </div>
    </div>

    <div class="stats">
        <div class="stat"><div class="stat-bg"></div><div class="stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/></svg></div><div class="stat-label">Total Vendors</div><div class="stat-value"><%= calcTotal %></div><div class="stat-sub">All registered on platform</div></div>
        <div class="stat"><div class="stat-bg"></div><div class="stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg></div><div class="stat-label">Approved</div><div class="stat-value"><%= calcApproved %></div><div class="stat-sub"><%= calcTotal > 0 ? (calcApproved * 100 / calcTotal) : 0 %>% approval rate</div></div>
        <div class="stat"><div class="stat-bg"></div><div class="stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12,6 12,12 16,14"/></svg></div><div class="stat-label">Pending Review</div><div class="stat-value"><%= calcPending %></div><div class="stat-sub">Awaiting decision</div></div>
        <div class="stat"><div class="stat-bg"></div><div class="stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div><div class="stat-label">Rejected</div><div class="stat-value"><%= calcRejected %></div><div class="stat-sub">Applications declined</div></div>
    </div>

    <div class="table-card">
        <div class="table-head">
            <h3>Vendor Management</h3>
            <div class="filters">
                <button class="filter active" onclick="filterVendors('all')">All (<%= calcTotal %>)</button>
                <button class="filter" onclick="filterVendors('pending')">Pending (<%= calcPending %>)</button>
                <button class="filter" onclick="filterVendors('approved')">Approved (<%= calcApproved %>)</button>
                <button class="filter" onclick="filterVendors('rejected')">Rejected (<%= calcRejected %>)</button>
            </div>
        </div>
        <div class="table-wrap">
        <table>
            <thead><tr><th>Vendor</th><th>Category</th><th>Location</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
            <% if (allVendors != null && !allVendors.isEmpty()) {
                String[] avatars = {"https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop&crop=face","https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop&crop=face","https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=80&h=80&fit=crop&crop=face","https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&h=80&fit=crop&crop=face","https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80&h=80&fit=crop&crop=face"};
                for (int i = 0; i < allVendors.size(); i++) {
                    Map<String, Object> v = allVendors.get(i);
                    String vName = v.get("name") != null ? (String)v.get("name") : "Unknown";
                    String vEmail = v.get("email") != null ? (String)v.get("email") : "";
                    String vCategory = v.get("category") != null ? (String)v.get("category") : "Photography";
                    String vLocation = v.get("location") != null ? (String)v.get("location") : "-";
                    String vStatus = v.get("status") != null ? (String)v.get("status") : "incomplete";
                    if (vStatus == null || vStatus.isEmpty()) vStatus = "incomplete";
                    String sc = "badge-incomplete", sl = "Incomplete";
                    if ("complete".equals(vStatus) || "approved".equals(vStatus)) { sc = "badge-approved"; sl = "Approved"; }
                    else if ("rejected".equals(vStatus)) { sc = "badge-rejected"; sl = "Rejected"; }
                    else if ("pending_verify".equals(vStatus) || "pending".equals(vStatus)) { sc = "badge-pending"; sl = "Pending"; }
                    String ds = "pending";
                    if ("complete".equals(vStatus) || "approved".equals(vStatus)) ds = "approved";
                    else if ("rejected".equals(vStatus)) ds = "rejected";
            %>
            <tr data-status="<%= ds %>">
                <td><div class="v-info"><img class="v-avatar" src="<%= avatars[i % avatars.length] %>" alt=""/><div><div class="v-name"><%= vName %></div><div class="v-email"><%= vEmail %></div></div></div></td>
                <td><%= vCategory %></td>
                <td><%= vLocation %></td>
                <td><span class="badge <%= sc %>"><%= sl %></span></td>
                <td>
                    <div class="btns">
                        <% if ("incomplete".equals(vStatus) || "pending_verify".equals(vStatus) || "rejected".equals(vStatus)) { %>
                        <a href="<%=ctx%>/admin?action=approve&email=<%=vEmail%>" class="btn-approve" onclick="return confirm('Approve vendor: <%=vName%>?')"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="12" height="12"><polyline points="20,6 9,17 4,12"/></svg> Approve</a>
                        <% } %>
                        <% if (!"complete".equals(vStatus) && !"approved".equals(vStatus)) { %>
                        <a href="<%=ctx%>/admin?action=reject&email=<%=vEmail%>" class="btn-reject" onclick="return confirm('Reject vendor: <%=vName%>?')"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="12" height="12"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg> Reject</a>
                        <% } %>
                        <% if ("complete".equals(vStatus) || "approved".equals(vStatus)) { %>
                        <span class="approved-text"><svg viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.5" width="14" height="14"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg> Approved</span>
                        <% } %>
                        <a href="<%=ctx%>/admin?action=view&email=<%=vEmail%>" class="btn-view"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="12" height="12"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg> View</a>
                    </div>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="5"><div class="empty"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg><h3 style="font-size:16px;font-weight:600;color:#0f172a;margin-bottom:4px">No Vendors Yet</h3><p>Registered vendors will appear here for approval.</p></div></td></tr>
            <% } %>
            </tbody>
        </table>
        </div>
    </div>
</div>

<script>
function filterVendors(t){document.querySelectorAll('.filter').forEach(f=>f.classList.remove('active'));event.target.classList.add('active');document.querySelectorAll('tbody tr[data-status]').forEach(r=>{r.style.display=(t==='all'||r.getAttribute('data-status')===t)?'':'none'})}
</script>
</body>
</html>