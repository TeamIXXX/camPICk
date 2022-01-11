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
<title>Sitemap.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/CamperSitemap.css">
</head>
<body>


<div class="sitemapItem">
	<ul class="mainMenu">
		<li>
			<a href="#">campers</a>
			<ul class="siteSubMenu">
				<li><a href="#">camPICk 투게더</a></li>
				<li><a href="#">camPICk 마켓</a></li>
			</ul>
		</li>
		<li>
			<a href="#">camper'Story</a>
		</li>
		<li>
			<a href="#">캠핑크루</a>
		</li>
		<li>
			<a href="#">my 캠핑</a>
			<ul class="siteSubMenu">
				<li><a href="#">캘린더</a></li>
				<li><a href="checkPwForm.wei">계정관리</a></li>
				<li><a href="bookinglist.wei">my 캠핑장</a></li>
				<li><a href="#">my Story</a></li>
				<li><a href="#">my 크루</a></li>
			</ul>
		</li>
		<li>
			<a href="#">고객 문의</a>
			<ul class="siteSubMenu">
				<li><a href="#">FAQ</a></li>
				<li><a href="#">문의하기</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
		</li>
	</ul>
</div>


</body>
</html>