<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String naviSearch = request.getParameter("naviSearch");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>camPick homepage</title>
<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

.mainContainer
{
	font-family: 'S-CoreDream-6Bold';
}

</style>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainHomepage.css">
</head>
<body>

<div class="mainContainerNN">
	<div class="mainItemNN">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
	<div class="mainItemNN" id="mainLogo">
		<img src="<%=cp%>/img/logo_title.png">
	</div>
	<div class="mainItemNN sitemap" style="z-index: 2;">
		<jsp:include page="CamperSitemap.jsp"></jsp:include>
	</div>
	 <div class="mainItemNN banner" style="z-index: 1;">
		<c:import url="MainBanner.jsp"></c:import>
	</div>
	<div class="mainItemNN">
		<c:import url="Search.jsp">
			<c:param name="naviSearch" value="${naviSearch }"></c:param>
		</c:import>
	</div>
</div>

<footer>
	<jsp:include page="Footer.jsp"></jsp:include>
</footer>

</body>
</html>