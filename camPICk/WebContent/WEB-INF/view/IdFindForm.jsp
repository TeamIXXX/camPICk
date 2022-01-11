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
<title>아이디 찾기 템플릿</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/IdFindForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">

<script type="text/javascript">
	
	$(function()
	{
		// 랜덤 인증번호 확인
		$("#chkCerNum").click(function()
		{
			if ($("#phone").val().length != 13)
			{
				$("#chkphoneMsg").html("휴대폰번호를 확인해주세요.");
			}
			else if($("#recerNum").val() != rCode)
			{
				$("#chkCerMsg").css("color", "red");
				$("#chkCerMsg").html("인증번호를 확인해 주십시오.");
			}
			else if ($("#recerNum").val() == rCode)
			{
				$("#chkCerMsg").css("color", "#34aadc");
				$("#chkCerMsg").html("인증번호가 확인 되었습니다.");
				$("#chkCerNum").attr("disabled", true);
				$("#cerNum").attr("disabled", true);
				$("#phone").attr("readonly", true);
				$("#recerNum").attr("readonly", true);
			}
			
		});
		
	});

	//랜덤 자리수 발생
	function randomCode(n)
	{
		var str = "";
		for (var i = 0; i <n; i++)
		{
			str += Math.floor(Math.random()*10);
		}
		
		return str;
	}

</script>

</head>
<body>

<div class="mainContainer">
	
	<div class="mainItem">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
 
	<div class="mainItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title.png">
	</div>
 
	<div class="mainItem">
		<jsp:include page="CamperSitemap.jsp"></jsp:include>		
	</div>
 
	<div class="mainItem">
		<c:import url="NavigationBar.jsp"></c:import>
	</div>
	 
	<div class="mainItem" style="background-color: none;">

		<div class="container">
			<h1>아이디찾기</h1>
			<h2>
			이메일 또는 휴대전화번호로 아이디 찾기가 가능합니다.<br>
			찾기가 어려우시면 고객문의에 글을 남겨주세요.
			</h2>
			<form action="">
				<fieldset>
					<legend>아이디찾기</legend>
					<ul>
						<li class="findId">
							<label>
								<input type="radio" id="find_member" name="find_member" checked="checked">
								캠퍼회원
							</label>
							<label>
								<input type="radio" id="find_member" name="find_member">
								파트너회원
							</label>
						</li>
						<li class="findId">
							<strong>이름</strong>
							<input type="text" id="camperName" name="camperName" class="camperName" maxlength="6"
							 placeholder="이름을 입력해주세요.">
						</li>
						<li class="findId">
							<strong>이름</strong>
							<input type="text" id="partnerName" name="partnerName" class="partnerName" maxlength="6"
							 placeholder="이름을 입력해주세요.">
						</li>
						<li class="findId">
							<strong>휴대폰번호</strong>
							<input type="text" id="phone" name="phone" class="phone" maxlength="13"
							 placeholder="회원가입시 등록한 핸드폰번호를 입력해주세요.">
							<button type="button">인증번호 받기</button><br>
							<input type="text" id="phone" name="phone" class="phone">
						</li>
					</ul>
					
					<ul>
						<li class="button">
							<button type="button">아이디찾기</button>
						</li>
					</ul>
				</fieldset>
			</form>
		</div>
		
	</div>
	
</div>

<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>

</body>
</html>