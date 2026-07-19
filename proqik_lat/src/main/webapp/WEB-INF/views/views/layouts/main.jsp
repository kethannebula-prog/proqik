<%-- Main layout include --%>
<%
String pageTitle = (String) request.getAttribute("title");
if (pageTitle == null) pageTitle = "ProQik";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/main.css">
</head>
<body>
<jsp:doBody/>
</body>
</html>