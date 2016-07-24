<%@tag description="Page template" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@attribute name="title" required="true" %>
<%@attribute name="jumbotron" fragment="true" %>
<%@attribute name="pagebody" fragment="true" %>
<%@attribute name="pagescripts" fragment="true" %>

<t:basewrapper title="${title} - Itransition Photo Cloud">
    <jsp:attribute name="navigation">
         <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="/">Itransition Photo Cloud</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <sec:authorize access="isAnonymous()">
                                <a href="<c:url value="/login" />">Войти</a>
                            </sec:authorize>
                            <sec:authorize access="isAuthenticated()">
                                <a href="#" onclick="$('#logout').submit()">Выйти</a>
                            </sec:authorize>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>
         <form action="/logout" id="logout" method="post">
             <input type="hidden" name="${_csrf.parameterName}"
                    value="${_csrf.token}" />
         </form>
    </jsp:attribute>
    <jsp:attribute name="body">
        <jsp:invoke fragment="jumbotron" />
        <div class="container">
            <jsp:invoke fragment="pagebody"/>
            <hr>
            <footer>
                <div class="row">
                    <div class="col-lg-12">
                        <p>Copyright &copy; Itransition 2016</p>
                    </div>
                </div>
            </footer>
        </div>
    </jsp:attribute>
    <jsp:attribute name="styles">
        <spring:url value="/resources/css/bootstrap.css" var="bootstrap"/>
        <spring:url value="/resources/css/modern-business.css" var="startertemplate"/>
        <spring:url value="/resources/css/dropzone.css" var="dropzonestyle"/>
        <spring:url value="/resources/css/basic.css" var="dropzonebasic"/>
        <%--extract to enother--%>
        <spring:url value="/resources/css/photo.css" var="photoStyle"/>


        <link href="${bootstrap}" rel="stylesheet" />
        <link href="${startertemplate}" rel="stylesheet" />
        <%--<link href="${dropzonebasic}" rel="stylesheet" />--%>
        <link href="${dropzonestyle}" rel="stylesheet" />
        <link href="${photoStyle}" rel="stylesheet" />

    </jsp:attribute>
    <jsp:attribute name="scripts">
        <!-- jQuery -->
        <script src="/resources/js/jquery.js"></script>
        <!-- Bootstrap Core JavaScript -->
        <script src="/resources/js/bootstrap.min.js"></script>
        <jsp:invoke fragment="pagescripts" />
    </jsp:attribute>
</t:basewrapper>

