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
<title>login_page</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$("#loginBtn").click(function()
		{
			if ($("#id").val()==null || $("#pw").val()==null)
			{
				confirm("아이디/비밀번호 를 입력해주세요");
				return;
			}
			
			$("#loginForm").submit();
			
		});
		
		$("#pw").keyup(function(e)
		{
			if(e.keyCode==13)
				$("#loginForm").submit();
		});
						
	});

</script>

</head>
<body>


<div style="text-align: center; margin-top: 7%; margin-bottom: 3%;">
	<img src="img/logo.png" width="10%;" />
</div>



<div class="col-md-12" id="login" style="width: 400px; float: none; margin: 0 auto;">
	<form action="login.wei" method="post" id="loginForm" class="loginFrm">
	
		<div class="select" style="text-align: center;">
			<label for="camper"><input type="radio" name="campa" id="camper" value="camper" checked="checked"/> 캠퍼</label> 
			<label for="partner"><input	type="radio" name="campa" id="partner" value="partner" /> 파트너</label> <br>
		</div>
	
		<!-- 『form-group』 : 항목 1개 관련 내용만 묶기 -->
		<div class="from-group" style="margin-bottom: 6px;">
			<label for="id">아이디</label>
			<input type="text" id="id" name="id" placeholder="아이디를 입력하세요." 
			required="required" class="form-control"/>
		</div>
		
		<div class="form-group">
			<label for="pw">패스워드</label>
			<input type="password" id="pw" name="pw" placeholder="패스워드를 입력하세요."
			required="required" class="form-control"/>
		</div>
		
		
		<div class="col-md-12" style="text-align: center;">
			<div class="item">
				<a id="loginBtn" class="btn btn-default">로그인</a><span class="vline"></span>
				<a href="" id="joinBtn" class="btn btn-default">회원가입</a>
			</div>

			<div class="col-md-12">
				<a href="" class="btn">아이디찾기</a> | 
				<a href="" class="btn">비밀번호찾기</a>
			</div>
		</div>
	
	</form>
	
</div>

	

</body>
</html>