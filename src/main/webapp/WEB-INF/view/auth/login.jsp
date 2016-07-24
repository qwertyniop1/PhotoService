<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.authorization" var="authorizationTitle"/>
<fmt:message key="label.signIn" var="signInLabel"/>
<fmt:message key="label.password" var="passwordLabel"/>
<fmt:message key="message.haveAccount" var="haveAccount"/>
<fmt:message key="message.register" var="registerLabel"/>
<fmt:message key="message.authorizationNeeded" var="authorizationNeeded"/>
<fmt:message key="message.activationSuccess" var="activationSuccess"/>

<c:set var="localeCode" value="${pageContext.response.locale}" scope="page"/>

<t:pagewrapper title="${authorizationTitle}">
    <jsp:attribute name="pagebody">
        <div class="row" style="margin-top: 20px">
            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <strong><fmt:message key="message.error"/></strong> ${SPRING_SECURITY_LAST_EXCEPTION} <%--<fmt:message key="message.badCredentials"/>--%>
                </div>
            </c:if>
            <c:if test="${param.activate == true}">
                <div class="alert alert-success alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    ${activationSuccess}
                </div>
            </c:if>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="panel panel-info">
                    <div class="panel-heading">${authorizationNeeded}</div>
                    <div class="panel-body">
                        <form method="post" action="<c:url value="/login" />" id="login-form">
                            <div class="form-group">
                                <label for="username">Email</label>
                                <input type="email" class="form-control" id="username" name="username" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <label for="password">${passwordLabel}</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="${passwordLabel}">
                            </div>
                            <p>${haveAccount} <a href="<c:url value="/register" />">${registerLabel}</a></p>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="submit" value="${signInLabel}" class="btn btn-default center-block"/>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="<c:url value="/resources/js/jquery.validate.min.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/messages_${localeCode}.min.js" />" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                $('#login-form').validate({
                    rules: {
                        username: {
                            minlength: 2,
                            email: true,
                            required: true
                        },
                        password: {
                            minlength: 6,
                            required: true
                        }
                    },
                    highlight: function (element) {
                        $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                    },
                    success: function (element) {
                        element.addClass('valid')
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
                        element.remove();
                    }
                });

            });

        </script>
    </jsp:attribute>
</t:pagewrapper>