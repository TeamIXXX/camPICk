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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplateNN.css">
</head>
<body>

<div class="mainContainerNN">
	<div class="mainItemNN">
		<jsp:include page="/WEB-INF/view/TopMenu.jsp"></jsp:include>
	</div>
	<div class="mainItemNN" id="mainLogo">
		<img src="<%=cp%>/img/logo_title.png">
	</div>
	<div class="mainItemNN">
		<jsp:include page="/WEB-INF/view/CamperSitemap.jsp"></jsp:include>
	</div>
	<div class="mainItemNN">
		내용영역
	</div>
</div>

<footer>
	<jsp:include page="/WEB-INF/view/Footer.jsp"></jsp:include>
</footer>

</body>
</html>