<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Upload photo">
    <jsp:attribute name="body">
        <h1>Uploading photo</h1>
        <input name="file" type="file"
               class="cloudinary-fileupload" data-cloudinary-field="image_upload"
               data-form-data='${cloudinaryData}' />
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="<c:url value="/resources/js/jquery.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.ui.widget.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.fileupload.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.cloudinary.js" />" type="text/javascript"></script>

        <script type="text/javascript">
            //$(document).ready(function () {
            $.cloudinary.config({ cloud_name: 'itraphotocloud', api_key: '891695265656755'})

//            $('.cloudinary-fileupload').fileupload(function(e, data) {
//                alert(";lslsksjbfjvbnvjxn");
//            });

            //});

        </script>

    </jsp:attribute>
</t:wrapper>





<%--<script src='jquery.min.js' type='text/javascript'></script>--%>
