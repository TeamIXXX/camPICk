<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 템플릿</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/IdFindForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">
<style type="text/css">

#logo:hover
{
	cursor: pointer;
}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

$(function()
{	
	$("#updatePw").click(function()
	{
		var pw1 = $("#partnerPw").val();
		var pw2 = $("#pw2").val();
		var regPw = /^[A-Za-z0-9]{5,14}$/;

		if(pw1 == "")
		{
			alert("비밀번호를 입력하세요.");
			$("#partnerPw").focus();
			return;
		}
		else if(pw2 == "")
		{
			alert("비밀번호 확인을 입력하세요.");
			$("#pw2").focus();
			return;
		}
		else if(!regPw.test($("#partnerPw").val()))
		{
			alert("영문, 숫자 5~14자 이내로 입력해 주십시오.");
			$("#partnerPw").val("");
			$("#partnerPw").focus();
			return;
		}
		else if(pw1 != "" && pw2 != "")
		{
			if (pw1 != pw2)
			{
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			else
			{
				alert("비밀번호가 수정되었습니다. 로그인해주세요.");
				$("#pwFrm").submit();
			}
		}
	});
});

</script>

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
	 
	<div class="mainItem" style="background-color: none; height: 70vh;">

		<div class="pw_reset">
			<h1>비밀번호 재설정</h1>
			<c:choose>
				<c:when test="${empty pw}">
					<h2>가입 정보를 찾을 수 없습니다.</h2>
					
					<fieldset class="idField">
						<legend class="leg">비밀번호 재설정</legend>
						
						<ul class="id_btn">
							<li class="button">
								<button type="button" class="login_btn" 
								onclick="location.href='loginform.wei'">로그인</button>
							</li>
						</ul>
						<ul class="id_btn">
							<li class="button">
								<button type="button" class="sign_btn" 
								onclick="location.href='signupForm.wei'">회원가입</button>
							</li>
						</ul>
					</fieldset>
				</c:when>
				
				<c:otherwise>
					<h2>
					비밀번호를 변경해주세요.
					</h2>
					<form id="pwFrm" action="resetPPw.wei" method="post">
					
					<!-- 캠퍼 아이디 -->
					<input type="hidden" id="partnerId" name="partnerId" value="${id }">
					<!-- 캠퍼 휴대폰번호 -->
					<input type="hidden" id="partnerPhone" name="partnerPhone" value="${phone }">
					
						<fieldset class="pwCField">
							<legend class="leg">비밀번호 재설정</legend>
							<ul>
								<li class="li_pw">
									<strong>비밀번호 입력</strong>
									<input type="text" id="partnerPw" name="partnerPw" maxlength="14"
									placeholder="영문, 숫자 5~14자 이내로 입력">
								</li>
								<li class="li_rePw">
									<strong>비밀번호 확인</strong>
									<input type="text" id="pw2" name="pw2" maxlength="14">
								</li>
							</ul>
							
							<ul class="id_btn">
								<li class="button" style="border-bottom: 0px solid;">
									<button type="button" id="updatePw" class="update_pw">비밀번호 수정</button>
								</li>
							</ul>
						</fieldset>
					</form>
				</c:otherwise>
				
			</c:choose>
		</div>
		
	</div>
	
</div>

<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>

</body>
</html>