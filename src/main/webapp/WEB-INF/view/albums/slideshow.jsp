<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="messages" />

<fmt:message key="label.slideshow" var="title"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagestyles">
        <link href="<c:url value="/resources/css/camera.css"/>" rel="stylesheet" />
    </jsp:attribute>
    <jsp:attribute name="pagebody">
        <div class="camera_wrap">
            <c:forEach items="${photoList}" var="photo">
                <div data-src="http://res.cloudinary.com/itraphotocloud/image/upload/c_scale,h_600/${photo.id}.jpg"></div>
            </c:forEach>
        </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="<c:url value="/resources/js/jquery.easing.1.3.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/camera.min.js"/>" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                var effects = '<c:forEach items="${albumDto.effects}" var="effect">${effect},</c:forEach>';
                effects = effects.slice(0, -1);

                jQuery('.camera_wrap').camera({
                    fx: effects,
                    <c:if test="${albumDto.random}">
                    slideOn: 'random',
                    </c:if>
                    time: ${albumDto.speed},
                    transPeriod: ${albumDto.effectsSpeed}
                });

            });

        </script>
    </jsp:attribute>
</t:pagewrapper>

