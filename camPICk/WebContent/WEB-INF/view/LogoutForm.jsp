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
<title>LogoutForm.jsp</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

*
{
	font-family: 'S-CoreDream-6Bold';
}

</style>

</head>
<body>

<div style="text-align: center; margin-top: 7%; margin-bottom: 3%;">
	<a href="campick.wei"><img src="img/logo.png" width="10%;" /></a>
</div>

<div class="col-md-12" id="login" style="width: 400px; float: none; margin: 0 auto; text-align: center;">
	정상적으로 로그아웃되었습니다.<br><br>
	<button type="button" onclick="location.href='campick.wei'" class="btn btn-default">
		camPICk 홈으로 돌아가기
	</button>
</div>

</body>
</html>