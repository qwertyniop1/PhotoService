<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.registration" var="registrationTitle"/>
<fmt:message key="label.name" var="nameLabel"/>
<fmt:message key="label.lastname" var="lastnameLabel"/>
<fmt:message key="label.password" var="passwordLabel"/>
<fmt:message key="message.repeatPassword" var="repeatePassword"/>
<fmt:message key="label.register" var="registerLabel"/>

<t:pagewrapper title="${registrationTitle}">
    <jsp:attribute name="pagebody">
        <div class="page-header">
            <h1>${registrationTitle}</h1>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <sf:form modelAttribute="user" method="post">
                    <div class="form-group">
                        <sf:label path="firstName" title="${nameLabel}" for="firstName">${nameLabel}</sf:label>
                        <sf:input path="firstName" cssClass="form-control" />
                        <sf:errors path="firstName" element="div" cssClass="alert alert-danger" cssStyle="margin-top: 5px"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="lastName" title="${lastnameLabel}" for="lastName">${lastnameLabel}</sf:label>
                        <sf:input path="lastName" cssClass="form-control" />
                        <sf:errors path="lastName" element="div" cssClass="alert alert-danger" cssStyle="margin-top: 5px"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="email" title="E-mail" for="email">E-mail</sf:label>
                        <sf:input path="email" cssClass="form-control" />
                        <sf:errors path="email" element="div" cssClass="alert alert-danger" cssStyle="margin-top: 5px"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="password" title="${passwordLabel}" for="password">${passwordLabel}</sf:label>
                        <sf:password path="password" cssClass="form-control"/>
                        <sf:errors path="password" element="div" cssClass="alert alert-danger" cssStyle="margin-top: 5px"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="matchingPassword" title="${passwordLabel}" for="matchingPassword">${repeatePassword}</sf:label>
                        <sf:password path="matchingPassword" cssClass="form-control"/>
                        <sf:errors element="div" cssClass="alert alert-danger" cssStyle="margin-top: 5px"/>
                    </div>
                    <%--<sf:errors element="div" />--%>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="submit" value="${registerLabel}" class="btn btn-default center-block"/>
                </sf:form>
            </div>
            <div class="col-md-3"></div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="<c:url value="/resources/js/jquery.validate.min.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/messages_ru.min.js" />" type="text/javascript"></script>
        <script type="text/javascript">
            window.setTimeout(function() {
                $(".alert").fadeTo(500, 0).slideUp(500, function(){
                    $(this).remove();
                });
            }, 3000);

            $(document).ready(function () {

                $('#user').validate({
                    rules: {
                        firstName: {
                            minlength: 2,
                            required: true
                        },
                        lastName: {
                            minlength: 2,
                            required: true
                        },
                        email: {
                            email: true,
                            required: true
                        },
                        password: {
                            minlength: 6,
                            required: true
                        },
                        matchingPassword: {
                            minlength : 6,
                            equalTo : "#password"
                        }
                    },
                    highlight: function (element) {
                        $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                    },
                    success: function (element) {
                        element.addClass('valid')
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
//                        element.closest('.error').css('display', 'none');
                    }
                });

            });
        </script>
    </jsp:attribute>
</t:pagewrapper>