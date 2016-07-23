<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.registration" var="title"/>
<fmt:message key="message.successRegistration" var="success"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagebody">
        <div class="row" style="margin-top: 50px">
            <div class="col-md-3"></div>
            <div class="col-md-5">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
    </jsp:attribute>
</t:pagewrapper>