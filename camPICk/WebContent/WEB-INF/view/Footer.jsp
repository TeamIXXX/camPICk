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
<title>FootMenu.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Footer.css">
</head>
<body>

<div id="foot">

	<div class="footmenu">
	
	<%if(session.getAttribute("num")==null && session.getAttribute("account")==null)
	{%>
			개인정보 취급방침
			<span class="vline">|</span>
			홈페이지 이용약관
			<span class="vline">|</span>
			광고 및 제휴문의
			<span class="vline">|</span>
			<a href="signupForm.wei" class="foot">회원가입</a>
			<span class="vline">|</span>
			<a href="loginform.wei" class="foot">로그인</a>
			<span class="vline">|</span>
	<%} 
	else
	{%>
			개인정보 취급방침
			<span class="vline">|</span>
			홈페이지 이용약관
			<span class="vline">|</span>
			광고 및 제휴문의
	<%
	} 
	%>
	
	</div>

</div>

</body>
</html>