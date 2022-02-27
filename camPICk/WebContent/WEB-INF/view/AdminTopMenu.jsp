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
<title>TopMenu.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TopMenu.css">
</head>
<body>

<div id="topmenu">
		<ul class="topmenu">
			<li class="topmenu">
				<%=loginId %> 관리자님 반갑습니다. :)
			</li>
			<li class="topmenu">
				<a href="admincampick.wei" class="topmenu">HOME</a>
			</li>
			<li class="topmenu">
				<a href="logout.wei" class="topmenu">로그아웃</a>
			</li>
			<li class="topmenu">
				<a href="adminmenu.wei" class="topmenu">관리자메뉴</a>
			</li>
		</ul>
</div>

</body>
</html>