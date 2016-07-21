<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<t:pagewrapper title="Регистрация">
    <jsp:attribute name="pagebody">
        <h3>Регистрация</h3>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <sf:form modelAttribute="user" method="post">
                    <div class="form-group">
                        <sf:label path="firstName" title="Имя" for="firstName">Имя</sf:label>
                        <sf:input path="firstName" cssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <sf:label path="lastName" title="Фамилия" for="lastName">Фамилия</sf:label>
                        <sf:input path="lastName" cssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <sf:label path="email" title="E-mail" for="email">E-mail</sf:label>
                        <sf:input path="email" cssClass="form-control" />
                        <sf:errors path="email" element="div"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="password" title="Пароль" for="password">Пароль</sf:label>
                        <sf:password path="password" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <sf:label path="matchingPassword" title="Пароль" for="matchingPassword">Повторите пароль</sf:label>
                        <sf:password path="matchingPassword" cssClass="form-control"/>
                    </div>
                    <%--<sf:errors element="div" />--%>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="submit" value="Зарегистрировать" class="btn btn-default center-block"/>
                </sf:form>
            </div>
            <div class="col-md-2"></div>
        </div>
    </jsp:attribute>
</t:pagewrapper>