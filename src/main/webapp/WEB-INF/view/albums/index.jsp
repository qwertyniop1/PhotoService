<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="messages" />

<fmt:message key="label.editTitle" var="title"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagebody">
        <c:forEach items="${albumList}" var="album">
            <%--<c:catch var="exception">${album.name}</c:catch>--%>
            ${album}<br>
        </c:forEach>
    </jsp:attribute>
</t:pagewrapper>