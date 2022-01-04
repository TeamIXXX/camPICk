<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>banner</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainBanner.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<!-- slider -->

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class='bannerContentContainer'>
	<div id="quick" class="bannerContentItem quick">
		<span class="quick1">
			바쁘다 바빠 현대사회<br>camPICk과 함께 일상을 벗어나 보세요<br>
		</span>
		<span class="quick2">
			<br>나를 위한 캠핑장 찾기<br>
			<a href="#mainSearch"><input type="button" value="start" class="btn btn-default"></a>
		</span>
	</div>
	
	<div id="newAndBest" class="bannerContentItem">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0"
						class="active"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="5"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img class="d-block w-100" src="<%=cp%>/img/newcam1.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="<%=cp%>/img/newcam2.jfif">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="<%=cp%>/img/newcam3.png">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="<%=cp%>/img/campingking1.png">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="<%=cp%>/img/campingking2.png">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="<%=cp%>/img/campingking3.png">
					</div>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleIndicators"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		</div> <!-- end newAndBest -->	 

</div><!-- end container -->


</body>
</html>