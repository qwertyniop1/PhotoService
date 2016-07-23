<%@tag description="Page template" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@attribute name="errorName" required="true" %>
<%@attribute name="errorText" required="true" %>
<%@attribute name="errorTextExtra" %>


<fmt:setBundle basename="messages" />

<fmt:message key="message.error" var="title"/>
<fmt:message key="label.main" var="mainLabel"/>

<t:pagewrapper title="${title} - ${errorName}">
    <jsp:attribute name="pagebody">
<!-- Page Heading/Breadcrumbs -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${errorName}
                <small>${errorText}</small>
            </h1>
            <ol class="breadcrumb">
                <li>
                    <a href="/">${mainLabel}</a>
                </li>
                <li class="active">${errorName}</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="jumbotron">
                <h1><span class="error-404">${errorName}</span>
                </h1>
                <p>${errorTextExtra}</p>
            </div>
        </div>

    </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">

    </jsp:attribute>
</t:pagewrapper>
