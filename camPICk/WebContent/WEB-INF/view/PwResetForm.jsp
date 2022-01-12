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
<title>비밀번호 재설정 템플릿</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/IdFindForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">
	
	$(function()
	{
		// 라디오버튼에 따른 폼
		$(".pName").css("display", "none");
		$(".pPhone").css("display", "none");
		$(".pCerNum").css("display", "none");
		$(".pId_btn").css("display", "none");
		$("input[name=campa]").on("click", function()
		{
			var radioV = $("input[name=campa]:checked").val();
			
			if (radioV == "camper")
			{
				$(".cName").css("display", "block");
				$(".cPhone").css("display", "block");
				$(".cCerNum").css("display", "block");
				$(".cId_btn").css("display", "block");
				$(".pName").css("display", "none");
				$(".pPhone").css("display", "none");
				$(".pCerNum").css("display", "none");
				$(".pId_btn").css("display", "none");
			}
			else if (radioV == "partner")
			{
				$(".cName").css("display", "none");
				$(".cPhone").css("display", "none");
				$(".cCerNum").css("display", "none");
				$(".cId_btn").css("display", "none");
				$(".pName").css("display", "block");
				$(".pPhone").css("display", "block");
				$(".pCerNum").css("display", "block");
				$(".pId_btn").css("display", "block");
			}
		});
		
		
		// 캠퍼 휴대폰 번호 대쉬(-) 자동삽입
		$("#phone").keyup(function()
		{
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		

		// 파트너 휴대폰 번호 대쉬(-) 자동삽입
		$("#partnerPhone").keyup(function()
		{
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		
		// 캠퍼 랜덤 인증번호 발송
		var rCode = randomCode(4);
		$("#cerCNum").click(function()
		{
			if (!$("#phone").val())
	        {
				alert("휴대폰번호를 입력해주세요.");
	            $("#phone").focus();
	        }
	         else if ($("#phone").val().length != 13)
			{
	        	alert("휴대폰번호를 확인해주세요.");
	            $("#phone").val("");
		        $("#phone").focus();
			}
			else if ($("#phone").val().length == 13)
			{
				$("#recerCNum").val(rCode);
			}
		});
		
		
		// 파트너 랜덤 인증번호 발송
		var rCode = randomCode(4);
		$("#cerPNum").click(function()
		{
			if (!$("#partnerPhone").val())
	        {
				alert("휴대폰번호를 입력해주세요.");
	        }
	         else if ($("#partnerPhone").val().length != 13)
			{
	        	alert("휴대폰번호를 확인해주세요.");
			}
			else if ($("#partnerPhone").val().length == 13)
			{
				$("#recerPNum").val(rCode);
			}
		});
		
		
		// 캠퍼 인증번호 확인
		$("#chkCerCNum").click(function()
		{
			if ($("#phone").val().length != 13)
			{
				alert("휴대폰번호를 확인해주세요.");
			}
			else if($("#recerCNum").val() != rCode)
			{
				alert("인증번호를 확인해 주십시오.");
			}
			else if ($("#recerCNum").val() == rCode)
			{
				alert("인증번호가 확인 되었습니다.");
				$("#chkCerCNum").attr("disabled", true);
				$("#cerCNum").attr("disabled", true);
				$("#phone").attr("readonly", true);
				$("#recerCNum").attr("readonly", true);
			}
			
		});
		
		
		// 파트너 인증번호 확인
		$("#chkCerPNum").click(function()
		{
			if ($("#partnerPhone").val().length != 13)
			{
				alert("휴대폰번호를 확인해주세요.");
			}
			else if($("#recerPNum").val() != rCode)
			{
				alert("인증번호를 확인해 주십시오.");
			}
			else if ($("#recerPNum").val() == rCode)
			{
				alert("인증번호가 확인 되었습니다.");
				$("#chkCerPNum").attr("disabled", true);
				$("#cerPNum").attr("disabled", true);
				$("#partnerPhone").attr("readonly", true);
				$("#recerPNum").attr("readonly", true);
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
		<img src="<%=cp%>/img/logo_title2.png">
	</div>
 
	<div class="mainItem">
		<jsp:include page="CamperSitemap.jsp"></jsp:include>		
	</div>
 
	<div class="mainItem">
		<c:import url="NavigationBar.jsp"></c:import>
	</div>
	 
	<div class="mainItem" style="background-color: none; height: 70vh;">

		<div class="id_find">
			<h1>비밀번호 재설정</h1>
			<h2>
			이메일 또는 휴대전화번호로 비밀번호 재설정이 가능합니다.
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
							 &nbsp;
							<label>
								<input type="radio" id="campa" name="campa" value="partner">
								파트너회원
							</label>
						</li>
						<li class="cName">
							<strong>이름</strong>
							<input type="text" id="camperName" name="camperName" class="camperName" maxlength="6">
						</li>
						<li class="pName">
							<strong>이름</strong>
							<input type="text" id="partnerName" name="partnerName" class="partnerName" maxlength="6">
						</li>
						<li class="cPhone">
							<strong>휴대폰번호</strong>
							<input type="text" id="phone" name="phone" class="phone" maxlength="13">
							<button type="button" id="cerCNum" class="cerNum">인증번호 받기</button>
						</li>
						<li class="pPhone">
							<strong>휴대폰번호</strong>
							<input type="text" id="partnerPhone" name="partnerPhone" class="partnerPhone" maxlength="13">
							<button type="button" id="cerPNum" class="cerNum">인증번호 받기</button>
						</li>
						<li class="cCerNum">
							<strong>인증번호</strong>
							<input type="text" id="recerCNum" name="recerCNum" class="recerCNum">
							<button type="button" id="chkCerCNum" class="cerNum">인증번호 확인</button>
						</li>
						<li class="pCerNum">
							<strong>인증번호</strong>
							<input type="text" id="recerPNum" name="recerPNum" class="recerPNum">
							<button type="button" id="chkCerPNum" class="cerNum">인증번호 확인</button>
						</li>
					</ul>
					
					<ul class="cId_btn">
						<li class="button" style="border-bottom: 0px solid;">
							<button type="button" class="id_btn">비밀번호 재설정</button>
						</li>
					</ul>
					<ul class="pId_btn">
						<li class="button" style="border-bottom: 0px solid;">
							<button type="button" class="id_btn">비밀번호 재설정</button>
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