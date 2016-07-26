<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="messages" />

<fmt:message key="label.addAlbum" var="title"/>
<fmt:message key="label.albumTitle" var="albumTitle"/>
<fmt:message key="label.save" var="save"/>
<fmt:message key="label.slideshow" var="slideshow"/>


<t:pagewrapper title="${title}">
    <jsp:attribute name="pagebody">
        <div class="row" style="margin-top: 30px">
            <div class="col-md-6">
                <form class="form-inline" method="get" action="<c:url value="/albums"/>">
                    <div class="form-group">
                        <label for="album-name">${albumTitle}</label>
                        <input type="text" class="form-control" name="album" id="album-name" placeholder="${albumTitle}" value="${albumName}">
                    </div>
                    <button type="submit" class="btn btn-primary">${save}</button>
                </form>
            </div>
            <div class="col-md-6">
                <a href="<c:url value="/albums/show/${albumId}"/>" class="btn btn-success pull-right" style="margin: 20px; margin-right: 40px;">${slideshow}</a>
            </div>
        </div>

        <div class="row" id="effects">
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="simpleFade" class="a">
                    Затенение
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainTopLeft" class="a">
                    Шторка слева сверху
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainTopRight" class="a">
                    Шторка справа сверху
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainBottomLeft" class="a">
                    Шторка слева снизу
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainBottomRight" class="a">
                    Шторка справа снизу
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainSliceLeft" class="a">
                    Шторка слева
                </label>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="curtainSliceRight" class="a">
                    Шторка справа
                </label>
            </div>
        </div>

        <div id="album-photos" class="flex-container">
            <c:forEach items="${albumPhotos}" var="photo">
                <div class="thumbnail" data-photoid="${photo.id}">
                    <img src="<c:url value="http://res.cloudinary.com/itraphotocloud/image/upload/c_thumb,h_150,w_150/${photo.id}.jpg"/>">
                </div>
            </c:forEach>
        </div>

        <div id="all-photos" class="flex-container">
            <c:forEach items="${photoList}" var="photo">
                <div class="thumbnail" data-photoid="${photo.id}">
                    <img src="<c:url value="http://res.cloudinary.com/itraphotocloud/image/upload/c_thumb,h_150,w_150/${photo.id}.jpg"/>">
                </div>
            </c:forEach>
        </div>

    </jsp:attribute>
    <jsp:attribute name="pagescripts">

        <script src="<c:url value="/resources/js/jquery-ui.min.js"/>" type="text/javascript"></script>
        <script type="text/javascript">

            $(document).ready(function () {

                $('#all-photos, #album-photos').sortable({
                    cursor: "move",
                    connectWith: ".flex-container"
                });

                $('.form-inline').submit(function () {
                    var photoIds = [];
                    $('#album-photos').children().each(function () {
                        photoIds.push($(this).data('photoid'));
                    });
                    console.log(photoIds);

                    $.post('add', {album_name: $('#album-name').val(), photo_list: photoIds, id: ${albumId}, ${_csrf.parameterName}: "${_csrf.token}"});

                });





            });

        </script>
    </jsp:attribute>

</t:pagewrapper>
