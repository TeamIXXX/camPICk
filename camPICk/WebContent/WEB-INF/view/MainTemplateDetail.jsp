<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// 확인을 위한 코드
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	String loginId = (String)session.getAttribute("loginId");
	
	String campgroundId = request.getParameter("campgroundId");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main.jsp</title>
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

#logo:hover
{
	cursor: pointer;
}

</style>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>


</head>
<body>

<div class="mainContainer">
	
	<div class="mainItem">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
 
	<div class="mainItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title2.png" onclick="location.href='campick.wei'" id="logo">
	</div>
 
	<div class="mainItem">
		<jsp:include page="CamperSitemap.jsp"></jsp:include>		
	</div>
 
	<div class="mainItem">
		<c:import url="NavigationBar.jsp"></c:import>
	</div>
	 
	<div class="mainItem" style="background-color: none;">
		회원번호 : <%=num %><br>
		캠퍼/파트너/관리자 : <%=account %>
		<c:import url="/campgrounddetail.wei">
			<c:param name="campgroundId" value="${campgroundId }"></c:param>
		</c:import>
	</div>
	 
</div> 

<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>


</body>
</html>