<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="label.editTitle" var="title"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="pagestyles">
        <style>
            input[type=range] {
                -webkit-appearance: none;
                background-color: silver;
                width: 200px;
                height:20px;
            }

            input[type="range"]::-webkit-slider-thumb {
                -webkit-appearance: none;
                background-color: #666;
                opacity: 0.5;
                width: 10px;
                height: 26px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="pagebody">
          <c:set var="localeCode" value="${pageContext.response.locale}" />
       <c:if test="${localeCode == 'en' || localeCode == 'en_EN' || localeCode == 'en_US'}">
            <div class="alert alert-warning alert-dismissible" role="alert" style="margin-top: 20px">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong>Beta-version</strong> We apologise for the incorrect translation somewhere.
            </div>
        </c:if>
      <div class="row">
          <div class="col-md-9">
              <canvas id="main-canvas" width="800" height="600" style="border: 1px solid rgb(0, 0, 0); margin: 20px; "></canvas>
          </div>
          <div class="col-md-3">
              <form class="image-tools" method="get" action="<c:url value="/photo"/> " style="margin-top: 50px;">
                  <div class="checkbox">
                      <label>
                          Яркость
                          <input type="range" value="0" min="0" max="100" step="2" class="slider" id="slider-brightness">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Пиксельность
                          <input type="range" value="1" min="1" max="25" step="1" class="slider" id="slider-pixel">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Градиент
                          <input type="range" value="1" min="0" max="254"  step="5" class="slider" id="slider-gradient">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Шум
                          <input type="range" value="0" min="0" max="1000" step="50" class="slider" id="slider-noise">
                      </label>
                  </div>

                  <div class="checkbox">
                      <label>
                          Красный
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-red">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Зеленый
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-green">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Синий
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-blue">
                      </label>
                  </div>

                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sepia"> Сепия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-grayscale"> Черно-белое
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-inversion"> Инверсия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sepia2"> Сепия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-blur"> Блюр
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sharpen"> Резко
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-emboss"> Чеканка
                      </label>
                  </div>
                  <a href="<c:url value="/photo"/>" class="btn btn-default">Отмена</a>
                  <button type="submit" class="btn btn-primary">Сохранить</button>
              </form>
          </div>
      </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <script src="/resources/js/fabric.min.js" type="text/javascript"></script>
        <script src="/resources/js/jquery.mousewheel.min.js" type="text/javascript"></script>

        <script type="text/javascript">
            var canvas = new fabric.Canvas('main-canvas');
            canvas.selection = true;

            var mainImage;

            fabric.Image.fromURL('http://res.cloudinary.com/itraphotocloud/image/upload/${photo_id}.jpg', function(image) {
                mainImage = image;
                mainImage.centeredScaling = true;
                canvas.add(mainImage);
            }, {crossOrigin: 'anonymous'});

            $('.upper-canvas').on('mousewheel', function(e) {
                console.log(event.deltaX, event.deltaY, event.deltaFactor);
                var evt=window.event || e;
                var delta = evt.detail? evt.detail*(-120) : evt.wheelDelta;
                var curZoom = canvas.getZoom(),  newZoom = curZoom + delta / 4000,
                        x = e.offsetX, y = e.offsetY;
                //applying zoom values.
                canvas.zoomToPoint({ x: x, y: y }, newZoom);
                if(e != null)e.preventDefault();
                return false;
            });


            // sliders
            $('.slider').on("input", (function(e){
                var filterType;
                var filter;
                var id = e.target.id;
                if (id == 'slider-brightness') {
                    filterType = fabric.Image.filters.Brightness;
                    filter = new filterType({
                        brightness: $(this).val() * 2.55
                    });
                } else if (id == 'slider-pixel') {
                    filterType = fabric.Image.filters.Pixelate;
                    filter = new filterType({
                        blocksize: $(this).val() * 1
                    });
                }
                else if (id == 'slider-gradient') {
                    filterType = fabric.Image.filters.GradientTransparency;
                    filter = new filterType({
                        threshold: 255 - $(this).val()
                    });
                }
                else if (id == 'slider-noise') {
                    filterType = fabric.Image.filters.Noise;
                    filter = new filterType({
                        noise: $(this).val() * 1
                    });
                }
                else if (id == 'slider-red' || id == 'slider-green' || id == 'slider-blue') {
                    filterType = fabric.Image.filters.Multiply;
                    filter = new filterType({
                        color: 'rgb(' + $('#slider-red').val() + ', ' + $('#slider-green').val() + ', ' + $('#slider-blue').val() +')'
                    });
                }
                for (var i = mainImage.filters.length - 1; i >= 0; i--) {
                    if (mainImage.filters[i] instanceof filterType) {
                        mainImage.filters.splice(i, 1);
                        break;
                    }
                }
                mainImage.filters.push(filter);
                setTimeout(function() { mainImage.applyFilters(canvas.renderAll.bind(canvas)); }, 100);

            }));

            // checkboxes
            $('.filter-box').click(function (e) {
                var filterType;
                var filter;
                var id = e.target.id;
                if (id == 'filter-sepia') {
                    filterType = fabric.Image.filters.Sepia;
                } else if (id == 'filter-grayscale') {
                    filterType = fabric.Image.filters.Grayscale;
                }
                else if (id == 'filter-inversion') {
                    filterType = fabric.Image.filters.Invert;
                }
                else if (id == 'filter-sepia2') {
                    filterType = fabric.Image.filters.Sepia2;
                }
                else if (id == 'filter-sharpen') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 0, -1,  0,
                            -1,  5, -1,
                            0, -1,  0 ]
                    });
                }
                else if (id == 'filter-emboss') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 1,   1,  1,
                            1, 0.7, -1,
                            -1,  -1, -1 ]
                    });
                }
                else if (id == 'filter-blur') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 1/9, 1/9, 1/9,
                            1/9, 1/9, 1/9,
                            1/9, 1/9, 1/9 ]
                    });
                }
                filter = filter || new filterType();
                if ($(this).is(':checked')) {
                    mainImage.filters.push(filter);
                    mainImage.applyFilters(canvas.renderAll.bind(canvas));
                } else {
                    for (var i = mainImage.filters.length - 1; i >= 0; i--) {
                        if (mainImage.filters[i] instanceof filterType) {
                            mainImage.filters.splice(i, 1);
                            break;
                        }
                    }
                    mainImage.applyFilters(canvas.renderAll.bind(canvas));
                }
            });

            function download(url,name){
                // make the link. set the href and download. emulate dom click
                $('<a>').attr({href:url,download:name})[0].click();
            }
            $('.image-tools').submit(function() {
                canvas.deactivateAll().renderAll();
                //download(canvas.toDataURL(), 'dddd.png');
                $.post('https://api.cloudinary.com/v1_1/cloud9/image/upload', {
                    file: canvas.toDataURL(),
                    api_key: 891695265656755,
                    timestamp: Date.now() / 1000 | 0,
                    upload_preset: 'lrwcwlyh'
                }, function (data, status) {
                    $.post('/photo/upload', {photo_id: data.public_id,
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        console.log(data);
                        window.location.href = '/photo';
                    })
                });
                return false;
            });
            //canvas.renderAll();
        </script>
    </jsp:attribute>
</t:pagewrapper>