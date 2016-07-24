<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>--%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:setBundle basename="messages" />

<fmt:message key="label.main" var="title"/>
<fmt:message key="message.welcome" var="welcome"/>
<fmt:message key="message.jumbotron.upload" var="upload" scope="page"/>
<fmt:message key="message.jumbotron.edit" var="edit" scope="page"/>
<fmt:message key="message.jumbotron.show" var="show" scope="page"/>
<fmt:message key="message.register" var="register" scope="page"/>
<fmt:message key="message.registrationTagline" var="registerTagline" scope="page"/>
<fmt:message key="message.main.albums" var="albumsText" scope="page"/>
<fmt:message key="message.main.edit" var="editText" scope="page"/>
<fmt:message key="message.main.cloud" var="cloudText" scope="page"/>
<fmt:message key="message.main.albumsTitle" var="albumsTitle" scope="page"/>
<fmt:message key="message.main.editTitle" var="editTitle" scope="page"/>
<fmt:message key="message.main.cloudTitle" var="cloudTitle" scope="page"/>
<fmt:message key="message.learn" var="moreButton" scope="page"/>
<fmt:message key="label.photoTitle" var="myPhoto" scope="page"/>

<t:pagewrapper title="${title}">
    <jsp:attribute name="jumbotron">
        <!-- Header Carousel -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <div class="fill" style="background-image:url('http://wpuploads.appadvice.com/wp-content/uploads/2016/01/photographer-1080016_1920.jpg');"></div>
                <div class="carousel-caption">
                    <h2>${upload}</h2>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('https://www.karltaylorphotography.com/media/wysiwyg/home-main-image-lighter_1.jpg');"></div>
                <div class="carousel-caption">
                    <h2>${edit}</h2>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('http://www.shapecollage.com/blog/wp-content/uploads/2011/01/collage-valentine.jpg');"></div>
                <div class="carousel-caption">
                    <h2>${show}</h2>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>
    </jsp:attribute>
    <jsp:attribute name="pagebody">
         <!-- Marketing Icons Section -->
        <div class="row">
          <div class="col-lg-12">
              <h1 class="page-header">
                  ${welcome}
              </h1>
          </div>
        </div>
        <div class="row equal">
          <div class="col-md-4">
              <div class="panel panel-default">
                  <div class="panel-heading">
                      <h4><i class="fa fa-fw fa-check"></i>${cloudTitle}</h4>
                  </div>
                  <div class="panel-body">
                      <p>${cloudText}</p>
                      <a href="<c:url value="/photo"/>" class="btn btn-default">${moreButton}</a>
                  </div>
              </div>
          </div>
          <div class="col-md-4">
              <div class="panel panel-default">
                  <div class="panel-heading">
                      <h4><i class="fa fa-fw fa-gift"></i>${albumsTitle}</h4>
                  </div>
                  <div class="panel-body">
                      <p>${albumsText}</p>
                      <a href="<c:url value="/photo/albums"/>" class="btn btn-default">${moreButton}</a>
                  </div>
              </div>
          </div>
          <div class="col-md-4">
              <div class="panel panel-default">
                  <div class="panel-heading">
                      <h4><i class="fa fa-fw fa-compass"></i>${editTitle}</h4>
                  </div>
                  <div class="panel-body">
                      <p>${editText}</p>
                      <a href="<c:url value="/photo"/>" class="btn btn-default">${moreButton}</a>
                  </div>
              </div>
          </div>
        </div>
        <!-- /.row -->
        <hr>

        <!-- Call to Action Section -->
        <div class="well">
            <div class="row">
                <div class="col-md-8">
                    <p>${registerTagline}</p>
                </div>
                <div class="col-md-4">
                    <sec:authorize access="isAnonymous()">
                        <a class="btn btn-lg btn-primary btn-block" href="<c:url value="/register"/>">${register}</a>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <a class="btn btn-lg btn-primary btn-block" href="<c:url value="/photo"/>">${myPhoto}</a>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="pagescripts">
        <!-- Script to Activate the Carousel -->
        <script>
            $('.carousel').carousel({
                interval: 5000 //changes the speed
            })
        </script>
    </jsp:attribute>
</t:pagewrapper>
