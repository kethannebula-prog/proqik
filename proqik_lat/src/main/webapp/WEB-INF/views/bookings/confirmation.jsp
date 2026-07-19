<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.proqik.model.Professional" %>
<%@ page import="com.proqik.controller.BookingServlet.Booking" %>

<%
Professional vendor = (Professional) request.getAttribute("vendor");
Booking booking = (Booking) request.getAttribute("booking");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking Confirmed | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
:root{--navy:#122f66;--gold:#c9a84c;--success:#16a34a;--font:'Plus Jakarta Sans',system-ui,sans-serif;--disp:'Syne',system-ui,sans-serif}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font);background:#fff;color:#1a2140;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px}

.cnf-container{max-width:500px;width:100%;text-align:center;padding:40px}
.cnf-icon{width:80px;height:80px;background:rgba(22,163,74,.1);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 24px;font-size:36px;color:var(--success)}
.cnf-title{font-family:var(--disp);font-size:28px;font-weight:800;margin-bottom:8px;color:var(--navy)}
.cnf-subtitle{font-size:14px;color:#8b96b0;margin-bottom:32px}

.cnf-card{background:#f6f8fc;border-radius:12px;padding:24px;margin-bottom:24px;text-align:left}
.cnf-id{font-size:12px;color:#8b96b0;letter-spacing:.04em;margin-bottom:4px}
.cnf-id strong{color:var(--navy);font-size:16px;font-weight:700}
.cnf-row{display:flex;justify-content:space-between;padding:12px 0;border-bottom:1px solid #eef1f8}
.cnf-row:last-child{border:none}
.cnf-row span:first-child{color:#8b96b0;font-size:13px}
.cnf-row span:last-child{font-weight:600;font-size:13px}

.cnf-vendor{display:flex;align-items:center;gap:12px;padding:16px;background:#f6f8fc;border-radius:10px;margin-bottom:24px}
.cnf-vendor img{width:48px;height:48px;border-radius:8px;object-fit:cover}
.cnf-vendor-name{font-weight:700;font-size:14px}
.cnf-vendor-cat{font-size:12px;color:#8b96b0}

.cnf-actions{display:flex;flex-direction:column;gap:12px}
.cnf-btn{padding:14px;border-radius:10px;font-size:14px;font-weight:600;cursor:pointer;transition:all .2s;text-decoration:none;display:block}
.cnf-btn-primary{background:var(--navy);color:#fff;border:none}
.cnf-btn-primary:hover{background:#1e55b0}
.cnf-btn-secondary{background:#fff;border:1.5px solid #dce2f0;color:#4a5578}
.cnf-btn-secondary:hover{border-color:var(--navy);color:var(--navy)}

.cnf-note{font-size:12px;color:#8b96b0;margin-top:24px}
</style>
</head>
<body>

<div class="cnf-container">
  <div class="cnf-icon">✓</div>
  <h1 class="cnf-title">Booking Request Sent!</h1>
  <p class="cnf-subtitle">Your request has been submitted. You'll be notified once the vendor confirms.</p>
  
  <div class="cnf-card">
    <div class="cnf-id">Booking ID</div>
    <strong><%= booking.getId() %></strong>
    
    <div class="cnf-row">
      <span>Event Type</span>
      <span><%= booking.getEventType() %></span>
    </div>
    <div class="cnf-row">
      <span>Date</span>
      <span><%= booking.getEventDate() %></span>
    </div>
    <div class="cnf-row">
      <span>Location</span>
      <span><%= booking.getLocation() %></span>
    </div>
    <div class="cnf-row">
      <span>Amount</span>
      <span>₹ <%= (int)booking.getAmount() %></span>
    </div>
    <div class="cnf-row">
      <span>Status</span>
      <span style="color:#c9a84c;font-weight:600">Pending</span>
    </div>
  </div>
  
  <div class="cnf-vendor">
    <img src="<%= vendor.getCoverImage() %>" alt="<%= vendor.getDisplayName() %>"/>
    <div>
      <div class="cnf-vendor-name"><%= vendor.getDisplayName() %></div>
      <div class="cnf-vendor-cat"><%= vendor.getSpecialty() %></div>
    </div>
  </div>
  
  <div class="cnf-actions">
    <a href="<%= request.getContextPath() %>/dashboard" class="cnf-btn cnf-btn-primary">Go to Dashboard</a>
    <a href="<%= request.getContextPath() %>/vendors" class="cnf-btn cnf-btn-secondary">Browse More Vendors</a>
  </div>
  
  <p class="cnf-note">A confirmation email has been sent to your email address.</p>
</div>

</body>
</html>