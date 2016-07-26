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
    <jsp:attribute name="pagestyles">
        <style>
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .switch input {display:none;}

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

            input:checked + .slider {
                background-color: #2196F3;
            }

            input:focus + .slider {
                box-shadow: 0 0 1px #2196F3;
            }

            input:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            /* Rounded sliders */
            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="pagebody">
        <div class="row" style="margin-top: 30px">
            <div class="col-md-6">
                <form class="form-inline" method="get" action="<c:url value="/albums"/>">
                    <div class="form-group">
                        <label for="album-name">${albumTitle}</label>
                        <input type="text" class="form-control" name="album" id="album-name" placeholder="${albumTitle}" value="${albumDto.name}">
                    </div>
                    <button type="submit" class="btn btn-primary">${save}</button>
                </form>
            </div>
            <div class="col-md-6">
                <a href="<c:url value="/albums/show/${albumDto.id}"/>" class="btn btn-success pull-right" style="margin: 20px; margin-right: 40px;">${slideshow}</a>
            </div>
        </div>

        <div class="row" id="settings">
            <div class="col-md-3">
            <div class="checkbox">
                <label>
                    Скорость
                    <input type="range" value="-7000" min="-10000" max="-200" step="100" id="speed">
                </label>
            </div>
            <div class="checkbox">
                <label>
                    Скорость эффектов
                    <input type="range" value="-1500" min="-3000" max="-100" step="100" id="effect-speed">
                </label>
            </div>
            <div class="checkbox">
                <label class="switch">
                    <input type="checkbox" id="randomOrder" class="a">
                    <div class="slider round"></div>
                </label>
                Случайный порядок
            </div>
            </div>
            <div class="col-md-3 effects">
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="simpleFade" class="a">
                        <div class="slider round"></div>
                    </label>
                    Затенение
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainTopLeft" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка слева сверху
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainTopRight" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка справа сверху
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainBottomLeft" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка слева снизу
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainBottomRight" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка справа снизу
                </div>
            </div>
            <div class="col-md-3 effects">
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainSliceLeft" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка слева
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="curtainSliceRight" class="a">
                        <div class="slider round"></div>
                    </label>
                    Шторка справа
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="mosaic" class="a">
                        <div class="slider round"></div>
                    </label>
                    Мозайка
                </div>
                <div class="checkbox">
                    <label class="switch">
                        <input type="checkbox" id="mosaicSpiral" class="a">
                        <div class="slider round"></div>
                    </label>
                    Спиральная мозайка
                </div>
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

                console.log("lol");
                <c:forEach items="${albumDto.effects}" var="effect">
                    $('#${effect}').prop('checked', true);
                </c:forEach>
                var speed = $('#speed').val(${albumDto.speed} * -1);
                var effectSpeed = $('#effect-speed').val(${albumDto.effectsSpeed} * -1);
                var randomOrder = $('#randomOrder').prop('checked', ${albumDto.random});




                $('#all-photos, #album-photos').sortable({
                    cursor: "move",
                    connectWith: ".flex-container"
                });

                $('.form-inline').submit(function () {
                    var photoIds = [];
                    $('#album-photos').children().each(function () {
                        photoIds.push($(this).data('photoid'));
                    });
                    if (photoIds.length === 0) {
                        photoIds.push("nope");
                    }
                    console.log(photoIds);

                    var effects = "";
                    $('.effects').find('input:checked').each(function () {
                        effects += $(this).attr('id') + '$';
                    });
                    if (effects.length === 0) {
                        effects = "random";
                    }
                    var speed = $('#speed').val() * -1;
                    var effectSpeed = $('#effect-speed').val() * -1;
                    var randomOrder = $('#randomOrder').prop('checked');
                    console.log(randomOrder);
                    console.log(effects, speed, effectSpeed);

                    $.post('add', {album_name: $('#album-name').val(),
                                photo_list: photoIds,
                                id: ${albumDto.id},
                                random: randomOrder,
                                speed: speed,
                                effect_speed: effectSpeed,
                                effects: effects,
                                ${_csrf.parameterName}: "${_csrf.token}"});


                });

            });

        </script>
    </jsp:attribute>

</t:pagewrapper>
