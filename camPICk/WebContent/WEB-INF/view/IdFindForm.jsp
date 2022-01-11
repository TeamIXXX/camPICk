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
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">
	
	$(function()
	{
		// 라디오버튼에 따른 폼
		$(".pName").css("display", "none");
		$(".pPhone").css("display", "none");
		$("input[name=campa]").on("click", function()
		{
			var radioV = $("input[name=campa]:checked").val();
			
			if (radioV == "camper")
			{
				$(".cName").css("display", "block");
				$(".cPhone").css("display", "block");
				$(".pName").css("display", "none");
				$(".pPhone").css("display", "none");
			}
			else if (radioV == "partner")
			{
				$(".cName").css("display", "none");
				$(".cPhone").css("display", "none");
				$(".pName").css("display", "block");
				$(".pPhone").css("display", "block");
			}
		});
		
		
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

		<div class="id_find">
			<h1>아이디찾기</h1>
			<h2>
			이메일 또는 휴대전화번호로 아이디 찾기가 가능합니다.<br>
			찾기가 어려우시면 고객문의에 글을 남겨주세요.
			</h2>
			<form action="">
				<fieldset class="idField">
					<legend class="leg">아이디찾기</legend>
					<ul>
						<li class="userType">
							<label>
								<input type="radio" id="campa" name="campa" value="camper" checked="checked">
								캠퍼회원
							</label>
							<label>
								<input type="radio" id="campa" name="campa" value="partner">
								파트너회원
							</label>
						</li>
						<li class="cName">
							<strong>이름</strong>
							<input type="text" id="camperName" name="camperName" class="camperName" maxlength="6"
							 placeholder="이름을 입력해주세요.">
						</li>
						<li class="pName">
							<strong>이름</strong>
							<input type="text" id="partnerName" name="partnerName" class="partnerName" maxlength="6"
							 placeholder="이름을 입력해주세요.">
						</li>
						<li class="cPhone">
							<strong>휴대폰번호</strong>
							<input type="text" id="phone" name="phone" class="phone" maxlength="13"
							 placeholder="회원가입시 등록한 핸드폰번호를 입력해주세요.">
							<button type="button">인증번호 받기</button><br>
							<input type="text" id="cerPhone" name="cerPhone" class="cerPhone">
						</li>
						<li class="pPhone">
							<strong>휴대폰번호</strong>
							<input type="text" id="partnerPhone" name="partnerPhone" class="partnerPhone" maxlength="13"
							 placeholder="회원가입시 등록한 핸드폰번호를 입력해주세요.">
							<button type="button">인증번호 받기</button><br>
							<input type="text" id="cerPartnerPhone" name="cerPartnerPhone" class="cerPartnerPhone">
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