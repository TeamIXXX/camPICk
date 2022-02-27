<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	String loginId = (String)session.getAttribute("loginId");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminMenu.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/AdminMenu.css">
</head>
<body>
	
	<div class="topContainer">
		<div></div>
		<jsp:include page="AdminTopMenu.jsp"></jsp:include>
	</div>

	<div class="outterContainer">
		<div class="outterItem"><p>관리자 캠핑</p></div>

		<div class="innerContainer">
			<div class="adminitem"><a href=""><br><br><br>통계관리</a></div>
			<div class="adminitem"><a href="partnerapproval.wei"><br><br><br>임시회원<br> 관리</a></div>
			<div class="adminitem"><a href=""><br><br><br>크루관리</a></div>
			<div class="adminitem"><a href=""><br><br><br>캠핑장<br> 관리</a></div>
			<div class="adminitem"><a href=""><br><br><br>신고관리</a></div>
			<div class="adminitem"><a href=""><br><br><br>고객문의<br> 관리</a></div>
			<div class="adminitem"><a href=""><br><br><br>임시페이지<br> 설정</a></div>
		</div>

		<div id="back">
			<a href="admincampick.wei">사용자 메인으로<br> 돌아가기</a> 
		</div>
	</div>
	<!--end form_wrap -->
</body>
</html>


