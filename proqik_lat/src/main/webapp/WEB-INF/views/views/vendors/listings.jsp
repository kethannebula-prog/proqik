<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String referer = request.getHeader("Referer");
System.out.println("=== VENDORS DEBUG: Referer=" + referer);
System.out.println("=== VENDORS DEBUG: requestURI=" + request.getRequestURI());
%>
<!DOCTYPE html>
<html>
<head><title>VENDORS</title></head>
<body>
<h1>VENDORS PAGE</h1>
<p>Referer: <%= referer %></p>
<p>This is /vendors - you were redirected here!</p>
</body>
</html>