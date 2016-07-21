<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:wrapper title="Авторизация">
    <jsp:attribute name="body">
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
                        <c:if test="${param.error != null}">
                            lldldldldldld
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="scripts">

    </jsp:attribute>
</t:wrapper>