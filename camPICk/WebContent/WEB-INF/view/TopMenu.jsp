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
<title>TopMenu.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TopMenu.css">
</head>
<body>

<div id="topmenu">
	<%if(session.getAttribute("num")==null && session.getAttribute("account")==null)
	{%>
		<ul class="topmenu">
			<li class="topmenu">
				<a href="campick.wei" class="topmenu">HOME</a>
			</li>
			<li class="topmenu">
				<a href="loginform.wei" class="topmenu">로그인</a>
			</li>
			<li class="topmenu">
				<a href="signupForm.wei" class="topmenu">회원가입</a>
			</li>
		</ul>
	<%} 
	else
	{%>
		<ul class="topmenu">
			<li class="topmenu">
				<%=account %>님 반갑습니다. :)
			</li>
			<li class="topmenu">
				<a href="campick.wei" class="topmenu">HOME</a>
			</li>
			<li class="topmenu">
				<a href="logout.wei" class="topmenu">로그아웃</a>
			</li>
		</ul>
	<%
	} 
	%>
	
</div>

</body>
</html>