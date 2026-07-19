<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String name = (String) request.getAttribute("vendorName");
if (name == null) name = "Vendor";
%>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<style>
body { font-family: Arial; background: #fff; margin: 0; padding: 20px; }
.box { background: #0D2137; color: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
.grid { display: flex; gap: 16px; }
.card { background: white; border: 1px solid #ddd; padding: 20px; border-radius: 8px; flex: 1; }
h1 { color: #0D2137; }
</style>
</head>
<body>
<div class="box">
  <h1 style="color:white">Welcome, <%= name %></h1>
  <p>This is the ProQik Vendor Dashboard</p>
</div>
<div class="grid">
  <div class="card"><h3>84</h3><p>Bookings</p></div>
  <div class="card"><h3>₹12,400</h3><p>Earnings</p></div>
  <div class="card"><h3>4.9</h3><p>Rating</p></div>
  <div class="card"><h3>1,240</h3><p>Views</p></div>
</div>
</body>
</html>