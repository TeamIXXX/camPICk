<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PartnerMain</title>
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
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerMain.css">

<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$("#myCampground").click(function()
		{
			$(location).attr("href", "mycampgroundtemplate.wei");
		});
		
		
	});

</script>

</head>
<body>

<div class="PartnerMain">
	<div class="partnerItem">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
	<div class="partnerItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title.png">
	</div>
	<div class="partnerItem">
		<div class="partnerMainButton">
			<button type="button" id="" class="btn  btn-warning btn-lg" style="background-color: rgba(255,208,50,0.7)">
				<img src="img/turtle.png" id="turtleImg" style="width: 200px; height: 250px;"><br><br>
				<span class="buttonName">계정관리</span>
			</button>
		</div>
		<div class="partnerMainButton">
			<button type="button" id="" class="btn  btn-warning btn-lg" style="background-color: rgba(69,129,142,0.7)">
				<img src="img/turtle.png" id="turtleImg" style="width: 200px; height: 250px;"><br><br>
				<span class="buttonName">예약관리</span>
			</button>
		</div>
		<div class="partnerMainButton">
			<button type="button" id="myCampground" class="btn btn-warning btn-lg" style="background-color: rgba(255,208,50,0.7)">
				<img src="img/turtle.png" id="turtleImg" style="width: 200px; height: 250px;"><br><br>
				<span class="buttonName">내 캠핑장 관리</span>
			</button>
		</div>
		<div class="partnerMainButton">
			<button type="button" id="" class="btn btn-warning btn-lg" style="background-color: rgba(69,129,142,0.7)">
				<img src="img/turtle.png" id="turtleImg" style="width: 200px; height: 250px;"><br><br>
				<span class="buttonName">고객문의</span>
			</button>
		</div>
	</div>
</div>

<footer>
	 <c:import url="Footer.jsp"></c:import>
</footer>

</body>
</html>