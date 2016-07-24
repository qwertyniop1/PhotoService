<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.photoTitle" var="title"/>
<fmt:message key="label.edit" var="editLabel"/>
<fmt:message key="label.delete" var="deleteLabel"/>

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

        <c:set var="count" value="0" scope="page"/>

        <c:forEach items="${photoList}" var="photo">
            <c:if test="${count % 4 == 0}">
                <div class="row">
            </c:if>
            <div class="col-md-3">
               <div class="thumbnail">
                   <div class="caption">
                       <%--<h4>Thumbnail Headline</h4>--%>
                       <%--<p>short thumbnail description</p>--%>
                       <div class="toolbar">
                            <a href="<c:url value="/photo/edit">
                                <c:param name="photo_id" value="${photo.id}"/>
                            </c:url>" class="btn btn-info" rel="tooltip" title="${editLabel}">
                               <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                           </a>
                           <a href="/delete" class="btn btn-danger" rel="tooltip" title="${deleteLabel}">
                               <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                           </a>
                       </div>
                   </div>
                   <a class="fancybox" rel="group" href="http://res.cloudinary.com/itraphotocloud/image/upload/c_scale,h_600/${photo.id}.jpg">
                        <cl:image src="${photo.id}" width="150" height="150" crop="thumb" format="jpg"/>
                   </a>
               </div>
            </div>
            <c:set var="count" value="${count + 1}" scope="page"/>
            <c:if test="${count % 4 == 0}">
                </div>
            </c:if>
        </c:forEach>

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
                            console.log(status);
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

            });

        </script>
    </jsp:attribute>
</t:pagewrapper>
