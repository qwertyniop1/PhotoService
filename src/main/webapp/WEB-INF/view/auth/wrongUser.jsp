<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.registration" var="errorTitle"/>
<fmt:message key="message.confirmError" var="errorText"/>

<t:errorwrapper errorName="${errorTitle}" errorText="${errorText}">
    <jsp:attribute name="errorTextExtra">
        ${param.get("message")}
    </jsp:attribute>
</t:errorwrapper>