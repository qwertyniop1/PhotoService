<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="messages" />

<fmt:message key="label.albums" var="title"/>
<fmt:message key="message.noAlbums" var="noAlbums"/>
<fmt:message key="label.addAlbum" var="addAlbum"/>
<fmt:message key="message.deletedAlbum" var="deleted"/>
<fmt:message key="label.edit" var="editLabel"/>
<fmt:message key="label.delete" var="deleteLabel"/>
<fmt:message key="label.restore" var="restoreLabel"/>
<fmt:message key="message.cancelDelete" var="reviveLabel"/>
<fmt:message key="message.startSlideshow" var="startSlideshow"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagestyles">
        <link href="<c:url value="/resources/css/photo.css" var="photoStyle"/>" rel="stylesheet" />
    </jsp:attribute>
    <jsp:attribute name="pagebody">
        <c:if test="${empty albumList}">
            <div class="panel panel-warning" style="margin-top: 20px">
                <div class="panel-body" style="text-align: center;">
                    <strong>${noAlbums}</strong>
                </div>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-2">
                <a href="<c:url value="/albums/create"/>" id="add-album" type="button" class="btn btn-success btn-lg">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                    ${addAlbum}</a>
            </div>
            <div class="col-md-5"></div>
        </div>

        <div class="flex-container">
        <c:forEach items="${albumList}" var="album">
            <div class="thumbnail">
                <div class="album-thumb">
                    <h4>${album.name}</h4>
                    <div class="toolbar">
                        <a href="<c:url value="/albums/${album.id}"/>" class="btn btn-info" rel="tooltip" title="${editLabel}">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                        </a>
                        <a href="#" data-albumid="${album.id}" class="btn btn-danger" rel="tooltip" title="${deleteLabel}">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
                <div class="deleted">
                    <h4>${deleted}</h4>
                    <p>${reviveLabel}</p>
                    <div class="toolbar">
                        <a href="#"data-albumid="${album.id}" class="btn btn-info" rel="tooltip" title="${restoreLabel}">
                            <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
                <a href="#" title="${startSlideshow}">
                    <img src="<c:url value="http://res.cloudinary.com/itraphotocloud/image/upload/c_thumb,h_150,w_150/npvp2apyuhm81higa7vj.jpg"/>">
                </a>
                <div class="album-title" style="text-align: center">
                    <h4>${album.name}</h4>
                </div>
            </div>
        </c:forEach>
        </div>

    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script type="text/javascript">

            $(document).ready(function () {

                $("[rel='tooltip']").tooltip();

                $('.thumbnail').hover(
                        function(){
                            $(this).find('.album-thumb').slideDown(250); //.fadeIn(250)
                            $(this).find('.album-title').children('h4').css('color', 'white');
                        },
                        function(){
                            $(this).find('.album-thumb').slideUp(250); //.fadeOut(205)
                            $(this).find('.album-title').children('h4').css('color', 'black');
                        }
                );

                // delete album
                $('.btn-danger').on('click', function () {
                    var button = $(this);
                    $.post('lol/delete', {album_id: button.data('albumid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        var caption = thumb.find('.album-thumb');
                        caption.hide();
                        caption.removeClass('album-thumb');
                        caption.addClass('album-thumb-del');
                        thumb.find('.deleted').fadeIn(250);
                    });
                });

                // restore album
                $('.btn-info').on('click', function () {
                    var button = $(this);
                    $.post('lol/restore', {album_id: button.data('albumid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        thumb.find('.deleted').fadeOut(250);
                        var caption = thumb.find('.album-thumb-del');
                        caption.removeClass('album-thumb-del');
                        caption.addClass('album-thumb');
                    });
                });



            });

        </script>
    </jsp:attribute>
</t:pagewrapper>