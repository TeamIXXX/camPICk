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
<title>Sign.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/SignOk.css">
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

<div class="container">

	<div class="item">
		<img src="img/logo.png" width="13%;" />
	</div>
	
	<div class="item">
		<div style="font-size: 15px;">회원가입을 축하합니다!</div>
		<div style="font-size: 13px;">camPICk 회원으로 서비스를 이용하실 수 있습니다.</div>
	</div>
	
	<div class="item">
		<div class="sel" style="font-size: 13px;">
			<button type="button" class="btn btn-default" 
			style="font-size: 13px;"
			onclick="location.href='loginform.wei'">로그인</button>
		</div>
		<div class="sel">
			<button type="button" class="btn btn-default" 
			style="font-size: 13px;"
			onclick="location.href='campick.wei'">Home</button>
		</div>
	</div>
</div>

</body>

</html>