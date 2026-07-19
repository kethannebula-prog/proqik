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
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= ctx %>/resources/css/admin-luxury.css">
</head>
<body>

<div class="topnav">
  <div class="topnav-left">
    <button class="menu-toggle" onclick="toggleSidebar()" aria-label="Toggle menu">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
    </button>
    <a href="#" class="topnav-logo"><div class="topnav-logo-mark">P</div> Proqik</a>
  </div>
  <div class="topnav-center">
    <a href="#" class="topnav-link active">Dashboard</a>
    <a href="#" class="topnav-link">Vendors</a>
    <a href="#" class="topnav-link">Bookings</a>
    <a href="#" class="topnav-link">Analytics</a>
  </div>
  <div class="topnav-right">
    <div class="topnav-search">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <input type="text" placeholder="Search...">
    </div>
    <div class="topnav-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg>
      <% if (pendingCount > 0) { %><div class="dot"></div><% } %>
    </div>
    <div class="topnav-user">
      <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=60&h=60&fit=crop&crop=face" alt=""/>
      <span><%= adminName %></span>
    </div>
  </div>
</div>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<div class="sidebar" id="sidebar">
  <div class="sidebar-header">
    <a href="#" class="sidebar-logo"><div class="sidebar-logo-mark">P</div> Proqik</a>
    <button class="sidebar-close" onclick="toggleSidebar()" aria-label="Close menu">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
    </button>
  </div>
  <div class="sidebar-inner">
    <div class="sidebar-section">
      <div class="sidebar-label">Main</div>
      <a class="sidebar-item active" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg> Dashboard
      </a>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/></svg> Vendors
      </a>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg> Bookings
      </a>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 20V10"/><path d="M12 20V4"/><path d="M6 20v-6"/></svg> Analytics
      </a>
    </div>
    <div class="sidebar-section">
      <div class="sidebar-label">Management</div>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/></svg> Finance
      </a>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg> Messages
        <% if (pendingCount > 0) { %><span class="badge"><%= pendingCount %></span><% } %>
      </a>
      <a class="sidebar-item" href="#">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg> Settings
      </a>
    </div>
  </div>
  <div class="sidebar-profile">
    <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=80&h=80&fit=crop&crop=face" alt=""/>
    <div>
      <div class="sp-name"><%= adminName %></div>
      <div class="sp-role">Administrator</div>
    </div>
    <a href="<%=ctx%>/logout" class="sidebar-logout" title="Sign out">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
    </a>
  </div>
</div>

<div class="main">
  <div class="main-inner">

    <div class="topbar">
      <div class="topbar-left">
        <h1>Dashboard</h1>
        <p>Good <%= java.time.LocalTime.now().getHour() < 12 ? "morning" : java.time.LocalTime.now().getHour() < 18 ? "afternoon" : "evening" %>, <%= adminName %>.</p>
      </div>
      <div class="topbar-actions">
        <button class="btn-primary"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> Add Vendor</button>
      </div>
    </div>

    <% if (flashMsg != null) { %>
    <div class="flash">
      <svg viewBox="0 0 24 24" fill="none" stroke="#065f46" stroke-width="2" width="18" height="18"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg>
      <%= flashMsg %>
    </div>
    <% } %>

    <div class="hero">
      <div class="hero-left">
        <div class="hero-pill"><span></span> Admin Panel &middot; Vendor Management</div>
        <h1>India's Finest<br><strong>Photography</strong><br>Marketplace</h1>
        <p>Authorize professional photographers &amp; videographers. Review profiles, manage bookings and grow your premium platform.</p>
        <div class="hero-actions">
          <button class="hero-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="16" height="16"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg> Review Pending</button>
          <button class="hero-ghost">View All Vendors</button>
        </div>
        <div class="hero-stats">
          <div class="hs"><strong><%= calcTotal %></strong><span>Total Vendors</span></div>
          <div class="hs"><strong><%= calcApproved %></strong><span>Approved</span></div>
          <div class="hs"><strong><%= calcPending %></strong><span>Pending Review</span></div>
        </div>
      </div>
      <div class="hero-right">
        <div class="hero-person">
          <img src="<%= ctx %>/resources/img/hero-person-1.png" alt="Photographer">
        </div>
      </div>
    </div>

    <div class="stats">
      <div class="stat">
        <div class="stat-top">
          <div class="stat-icon blue"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/></svg></div>
          <span class="stat-change up">+<%= calcApproved %></span>
        </div>
        <div class="stat-label">Total Vendors</div>
        <div class="stat-value"><%= calcTotal %></div>
        <div class="stat-sub">All registered on platform</div>
      </div>
      <div class="stat">
        <div class="stat-top">
          <div class="stat-icon green"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg></div>
          <span class="stat-change up"><%= calcTotal > 0 ? (calcApproved * 100 / calcTotal) : 0 %>%</span>
        </div>
        <div class="stat-label">Approved</div>
        <div class="stat-value"><%= calcApproved %></div>
        <div class="stat-sub">Verified vendors</div>
      </div>
      <div class="stat">
        <div class="stat-top">
          <div class="stat-icon amber"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12,6 12,12 16,14"/></svg></div>
          <span class="stat-change up"><%= calcPending %></span>
        </div>
        <div class="stat-label">Pending Review</div>
        <div class="stat-value"><%= calcPending %></div>
        <div class="stat-sub">Awaiting decision</div>
      </div>
      <div class="stat">
        <div class="stat-top">
          <div class="stat-icon red"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
          <span class="stat-change down"><%= calcRejected %></span>
        </div>
        <div class="stat-label">Rejected</div>
        <div class="stat-value"><%= calcRejected %></div>
        <div class="stat-sub">Declined applications</div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-head">
        <div class="table-head-left">
          <h3>Vendors</h3>
          <span class="table-count"><%= calcTotal %></span>
        </div>
        <div class="filters">
          <button class="filter active" onclick="filterVendors('all')">All</button>
          <button class="filter" onclick="filterVendors('pending')">Pending</button>
          <button class="filter" onclick="filterVendors('approved')">Approved</button>
          <button class="filter" onclick="filterVendors('rejected')">Rejected</button>
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
              <a href="<%=ctx%>/admin?action=approve&email=<%=vEmail%>" class="btn-approve" onclick="return confirm('Approve <%=vName%>?')"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="12" height="12"><polyline points="20,6 9,17 4,12"/></svg> Approve</a>
              <% } %>
              <% if (!"complete".equals(vStatus) && !"approved".equals(vStatus)) { %>
              <a href="<%=ctx%>/admin?action=reject&email=<%=vEmail%>" class="btn-reject" onclick="return confirm('Reject <%=vName%>?')"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="12" height="12"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg> Reject</a>
              <% } %>
              <% if ("complete".equals(vStatus) || "approved".equals(vStatus)) { %>
              <span class="approved-text"><svg viewBox="0 0 24 24" fill="none" stroke="#059669" stroke-width="2.5" width="12" height="12"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22,4 12,14.01 9,11.01"/></svg> Approved</span>
              <% } %>
              <a href="<%=ctx%>/admin?action=view&email=<%=vEmail%>" class="btn-view"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="12" height="12"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg> View</a>
            </div>
          </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="5"><div class="empty"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg><h3>No vendors yet</h3><p>Registered vendors will appear here.</p></div></td></tr>
        <% } %>
        </tbody>
      </table>
      </div>
    </div>
  </div>
</div>

<script>
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('sidebarOverlay').classList.toggle('open')}
function filterVendors(t){document.querySelectorAll('.filter').forEach(f=>f.classList.remove('active'));event.target.classList.add('active');document.querySelectorAll('tbody tr[data-status]').forEach(r=>{r.style.display=(t==='all'||r.getAttribute('data-status')===t)?'':'none'})}
</script>
</body>
</html>
