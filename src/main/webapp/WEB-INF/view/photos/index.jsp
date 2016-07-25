<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.photoTitle" var="title"/>
<fmt:message key="label.edit" var="editLabel"/>
<fmt:message key="label.delete" var="deleteLabel"/>
<fmt:message key="label.original" var="original"/>
<fmt:message key="label.restore" var="restoreLabel"/>
<fmt:message key="message.nophotos" var="noPhoto"/>
<fmt:message key="message.deleted" var="deletedPhoto"/>
<fmt:message key="message.cancelDelete" var="revivePhoto"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagebody">
        <%--<h1>Photo</h1>--%>
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
               <div id="upload-area" class="dropzone">

               </div>
            </div>
            <div class="col-md-1"></div>
        </div>

        <c:if test="${empty photoList}">
            <div class="panel panel-warning">
                <div class="panel-body" style="text-align: center;">
                    <strong>${noPhoto}</strong>
                </div>
            </div>
        </c:if>
        <div class="flex-container">
            <c:forEach items="${photoList}" var="photo">
                   <div class="thumbnail">
                       <div class="caption">
                           <div class="toolbar">
                                <a href="<c:url value="/photo/edit">
                                    <c:param name="photo_id" value="${photo.id}"/>
                                </c:url>" class="btn btn-info" rel="tooltip" title="${editLabel}">
                                   <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                               </a>
                               <a href="#" data-photoid="${photo.id}" class="btn btn-danger" rel="tooltip" title="${deleteLabel}">
                                   <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                               </a>
                           </div>
                       </div>
                       <div class="deleted">
                           <h4>${deletedPhoto}</h4>
                           <p>${revivePhoto}</p>
                           <div class="toolbar">
                               <a href="#" data-photoid="${photo.id}" class="btn btn-info" rel="tooltip" title="${restoreLabel}">
                                   <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                               </a>
                           </div>
                       </div>
                       <a class="fancybox" data-fancybox-title="<a target='_blank' href='http://res.cloudinary.com/itraphotocloud/image/upload/${photo.id}.jpg'><span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span></a>" rel="group" href="http://res.cloudinary.com/itraphotocloud/image/upload/c_scale,h_600/${photo.id}.jpg">
                            <cl:image src="${photo.id}" width="150" height="150" crop="thumb" format="jpg"/>
                       </a>
                   </div>
            </c:forEach>
        </div>

    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="<c:url value="/resources/js/jquery.ui.widget.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.fileupload.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.cloudinary.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/dropzone.js" />" type="text/javascript"></script>
        <!-- Add fancyBox -->
        <link rel="stylesheet" href="<c:url value="/resources/fancybox/jquery.fancybox.css?v=2.1.5"/>" type="text/css" media="screen" />
        <script type="text/javascript" src="<c:url value="/resources/fancybox/jquery.fancybox.pack.js?v=2.1.5"/>"></script>

        <!-- Optionally add helpers - button, thumbnail and/or media -->
        <link rel="stylesheet" href="<c:url value="/resources/fancybox/helpers/jquery.fancybox-buttons.css"/>" type="text/css" media="screen" />
        <script type="text/javascript" src="<c:url value="/resources/fancybox/helpers/jquery.fancybox-buttons.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/fancybox/helpers/jquery.fancybox-media.js"/>"></script>

        <link rel="stylesheet" href="<c:url value="/resources/fancybox/helpers/jquery.fancybox-thumbs.css"/>" type="text/css" media="screen" />
        <script type="text/javascript" src="<c:url value="/resources/fancybox/helpers/jquery.fancybox-thumbs.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function () {
//                $.cloudinary.config({ cloud_name: 'itraphotocloud', api_key: '891695265656755'})
                $(".fancybox").fancybox();

                Dropzone.options.uploadArea = {
                    url: 'https://api.cloudinary.com/v1_1/cloud9/image/upload',
                    acceptedFiles:'.jpg,.png,.jpeg,.gif',
                    uploadMultiple: false,
                    maxFiles: 5,
                    sending: function (file, xhr, formData) {
                        formData.append('api_key', 891695265656755);
                        formData.append('timestamp', Date.now() / 1000 | 0);
                        formData.append('upload_preset', 'lrwcwlyh ');
                    },
                    complete: function (file) {
                        this.removeAllFiles();
//                        setTimeout(function () {
////                            this.removeFile(file);
//                        }, 5000);
                    },
                    success: function (file, response) {
                        $.post('photo/upload', {photo_id: response.public_id,
                                                ${_csrf.parameterName}: "${_csrf.token}"},
                        function (data, status) {
                            console.log(data);
                            newPhoto =  "<div class='thumbnail'>" +
                                    "<div class='caption'>" +
                                    "<div class='toolbar'>" +
                                    "<a href='/photo/edit?photo_id=" + response.public_id + "' class='btn btn-info' rel='tooltip' title='${editLabel}'>" +
                                    "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>" +
                                    "</a>" +
                                    "<a href='#' data-photoid='" + response.public_id + "' class='btn btn-danger' rel='tooltip' title='${deleteLabel}'>" +
                                    "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>" +
                                    "</a>" +
                                    "</div>" +
                                    "</div>" +
                                    "<div class='deleted'>" +
                                    "<h4>${deletedPhoto}</h4>" +
                                    "<p>${revivePhoto}</p>" +
                                    "<div class='toolbar'>" +
                                    "<a href='#' data-photoid='" + response.public_id + "' class='btn btn-info' rel='tooltip' title='${restoreLabel}'>" +
                                    "<span class='glyphicon glyphicon-refresh' aria-hidden='true'></span>" +
                                    "</a>" +
                                    "</div>" +
                                    "</div>" +
                                    "<a class='fancybox' data-fancybox-title=\"<a target='_blank' href='http://res.cloudinary.com/itraphotocloud/image/upload/" + response.public_id + ".jpg'><span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span></a>\" rel='group' href='http://res.cloudinary.com/itraphotocloud/image/upload/c_scale,h_600/" + response.public_id + ".jpg'>" +
                                    "<img src='http://res.cloudinary.com/itraphotocloud/image/upload/c_thumb,h_150,w_150/" + response.public_id + ".jpg'>" +
                                    "</a>" +
                                    "</div>";
                            $('.flex-container').append(newPhoto);
                            $('.flex-container').children('.thumbnail:last').hover(
                                    function(){
                                        $(this).find('.caption').slideDown(250); //.fadeIn(250)
                                    },
                                    function(){
                                        $(this).find('.caption').slideUp(250); //.fadeOut(205)
                                    }
                            );
                            $('.panel-warning').remove();
                        });
                    }
                };

                $("[rel='tooltip']").tooltip();

                $('.thumbnail').hover(
                        function(){
                            $(this).find('.caption').slideDown(250); //.fadeIn(250)
                        },
                        function(){
                            $(this).find('.caption').slideUp(250); //.fadeOut(205)
                        }
                );

                // delete photo
                // TODO add to new elements
                $('.btn-danger').on('click', function () {
                    var button = $(this);
                    $.post('photo/delete', {photo_id: button.data('photoid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        var caption = thumb.find('.caption');
                        caption.hide();
                        caption.removeClass('caption');
                        caption.addClass('caption-del');
                        thumb.find('.deleted').fadeIn(250);
                    });
                });

                // restore photo
                $('.btn-info').on('click', function () {
                    var button = $(this);
                    $.post('photo/restore', {photo_id: button.data('photoid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        thumb.find('.deleted').fadeOut(250);
                        var caption = thumb.find('.caption-del');
                        caption.removeClass('caption-del');
                        caption.addClass('caption');
                    });
                });

            });

        </script>
    </jsp:attribute>
</t:pagewrapper>
