<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pagewrapper title="Авторизация">
    <jsp:attribute name="pagebody">
        <div class="row" style="margin-top: 20px">
            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <strong>Ошибка!</strong> Неверное имя пользователя или пароль.
                </div>
            </c:if>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="panel panel-info">
                    <div class="panel-heading">Авторизируйтесь, чтобы воспользоваться функционалом сайта</div>
                    <div class="panel-body">
                        <sf:form method="post" commandName="user">
        <%--Add bootstrap styles!!!--%>
                            <div class="form-group">
                                <sf:label path="username" title="Логин" for="username">Логин</sf:label>
                                <sf:input path="username" cssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <sf:label path="password" title="Пароль" for="password">Пароль</sf:label>
                                <sf:password path="password" cssClass="form-control"/>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="submit" value="Войти" class="btn btn-default center-block"/>
                        </sf:form>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="<c:url value="/resources/js/jquery.validate.min.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/messages_ru.min.js" />" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                $('#user').validate({
                    rules: {
                        username: {
                            minlength: 2,
                            maxlength: 45,
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
                    }
                });

            });

        </script>
    </jsp:attribute>
</t:pagewrapper>