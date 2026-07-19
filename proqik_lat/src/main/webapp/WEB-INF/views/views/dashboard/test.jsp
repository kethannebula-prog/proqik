<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String vendorName = (String) request.getAttribute("vendorName");
if (vendorName == null) vendorName = "Test Vendor";
String vendorCategory = (String) request.getAttribute("vendorCategory");
if (vendorCategory == null) vendorCategory = "Photographer";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vendor Dashboard | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { 
  font-family: 'Inter', system-ui, sans-serif; 
  background: linear-gradient(135deg, #0D2137 0%, #102840 100%);
  min-height: 100vh;
  color: #fff;
}
.test { padding: 40px; text-align: center; }
.test h1 { font-size: 32px; margin-bottom: 16px; }
.test p { font-size: 16px; opacity: 0.8; }
.test-card {
  background: rgba(255,255,255,0.1);
  border: 1px solid rgba(255,255,255,0.2);
  border-radius: 12px;
  padding: 24px;
  margin-top: 24px;
  max-width: 400px;
  margin-left: auto;
  margin-right: auto;
}
.kpi { 
  display: inline-block; 
  background: #fff; 
  color: #0D2137; 
  padding: 12px 24px; 
  border-radius: 8px; 
  margin: 8px;
  font-weight: 600;
}
</style>
</head>
<body>
<div class="test">
  <h1>Welcome, <%= vendorName %></h1>
  <p>Category: <%= vendorCategory %></p>
  <p>Role: VENDOR</p>
  
  <div class="test-card">
    <h2 style="margin-bottom:16px">Quick Stats</h2>
    <div class="kpi">Bookings: 84</div>
    <div class="kpi">Earnings: ₹12,400</div>
    <div class="kpi">Rating: 4.9</div>
    <div class="kpi">Views: 1,240</div>
  </div>
  
  <p style="margin-top:32px;font-size:14px">If you see this, the page is working!</p>
</div>
</body>
</html>