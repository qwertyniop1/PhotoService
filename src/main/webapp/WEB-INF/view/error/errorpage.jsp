<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:pagewrapper title="Ошибка">
    <jsp:attribute name="pagebody">
<!-- Page Heading/Breadcrumbs -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">404
                <small>Page Not Found</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/">Home</a>
                </li>
                <li class="active">404</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="jumbotron">
                <h1><span class="error-404">404</span>
                </h1>
                <p>The page you're looking for could not be found. </p>
            </div>
        </div>

    </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">

    </jsp:attribute>
</t:pagewrapper>
