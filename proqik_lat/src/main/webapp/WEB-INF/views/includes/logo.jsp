<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Reusable Logo Component --%>
<c:set var="logoPath" value="${pageContext.request.contextPath}/resources/img/logo.svg" />

<%-- For inline use (like in nav) --%>
<c:set var="logoInline" value='<img src="${pageContext.request.contextPath}/resources/img/logo.svg" alt="ProQik" style="height:38px"/>' />