<%@tag description="Page template" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@attribute name="title" required="true" %>
<%@attribute name="jumbotron" fragment="true" %>
<%@attribute name="pagebody" fragment="true" %>
<%@attribute name="pagescripts" fragment="true" %>
<%@attribute name="pagestyles" fragment="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.signIn" var="signInLabel" scope="page"/>
<fmt:message key="label.logout" var="logoutLabel" scope="page"/>
<fmt:message key="label.photo" var="photoLabel" scope="page"/>
<fmt:message key="label.albums" var="albumLabel" scope="page"/>

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
                            <ul class="f32" style="margin-top: 5px">
                                <li class="flag gb" style="cursor: pointer" onclick="window.location.href = '?lang=en'"></li>
                                <li class="flag ru" style="cursor: pointer" onclick="window.location.href = '?lang=ru'"></li>
                            </ul>
                        </li>
                    <sec:authorize access="isAnonymous()">
                        <li>
                            <a href="<c:url value="/login" />">${signInLabel}</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <li>
                            <a href="<c:url value="/photo"/> ">${photoLabel}</a>
                        </li>
                        <li>
                            <a href="<c:url value="/albums"/>">${albumLabel}</a>
                        </li>
                        <%--<li>--%>
                            <%--<a href="contact.html">Contact</a>--%>
                        <%--</li>--%>
                        <li>
                            <a href="#" onclick="$('#logout').submit()">${logoutLabel}</a>
                        </li>
                    </sec:authorize>
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
            <br>
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
        <link
                rel="stylesheet"
                type="text/css"
                href="<c:url value="/resources/css/flags32.css"/>"
        />
        <jsp:invoke fragment="pagestyles"/>
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <!-- jQuery -->
        <script src="/resources/js/jquery.js"></script>
        <!-- Bootstrap Core JavaScript -->
        <script src="/resources/js/bootstrap.min.js"></script>
        <jsp:invoke fragment="pagescripts" />
    </jsp:attribute>
</t:basewrapper>

