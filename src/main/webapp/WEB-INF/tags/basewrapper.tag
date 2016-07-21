<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@attribute name="title" required="true" %>
<%@attribute name="navigation" fragment="true" %>
<%@attribute name="body" fragment="true" %>
<%@attribute name="styles" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <jsp:invoke fragment="styles" />
</head>
<body>
    <jsp:invoke fragment="navigation" />
    <jsp:invoke fragment="body" />
    <jsp:invoke fragment="scripts" />
</body>
</html>
