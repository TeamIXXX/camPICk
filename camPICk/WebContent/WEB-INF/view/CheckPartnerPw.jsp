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
<title>패스워드 재확인</title>
<%-- <link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css"> --%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<style type="text/css">

.containerPw
{
    margin: 40px auto;
	display: grid;
	height: 20vh;
	grid-template-columns: 100px 230px;
	grid-template-rows: repeat(auto-fit, minmax(0, auto));
	justify-content: center;
	align-items: center;
}

.itemPw:nth-last-child(1)
{
	grid-column: 1 / 3;
	margin: 0 auto;
	padding-top: 30px;
}

.txt
{
	margin: 40px auto;
    padding-top: 160px;
    font-size: 11px;
	background: url(//image.makeshop.co.kr/makeshop/d3/basic_simple/member/bg_reconfirm.gif) 50% 0 no-repeat;
	text-align: center;
	line-height: 20px;
	color: #7f7f7f;
}

#logo:hover
{
	cursor: pointer;
}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script type="text/javascript">
	
	$(function()
	{		
		// 비밀번호 영문 + 숫자 검사
		$("#partnerPw").keyup(function()
		{
			var regId = /^[A-Za-z0-9]{5,14}$/;
			
			if(!regId.test($("#partnerPw").val()))
			{
				$("#pwMsg").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
				$("#pwMsg").css("color", "red");
				$("#pwMsg").css("font-size", "12px");
			}
			else
			{
				$("#pwMsg").html("");
			}
			
		});
		
		
		$("#sign").click(function()
		{
			if($("#partnerPw").val()=="")
			{
				alert("비밀번호를 입력해 주십시오.");
				$("#partnerPw").focus();
				return;
			}
			
			ajaxCheckPartnerPw();
		});
		
		$("#partnerPw").keyup(function(e)
		{
			if(e.keyCode==13)
				ajaxCheckPartnerPw();
		});
		
	});
	
	// 
	function ajaxCheckPartnerPw()
	{
		debugger;
		var partnerPw = $("#partnerPw").val();
		var partnerId = "<%=loginId%>";
		var param = "partnerId=" + partnerId + "&partnerPw=" + partnerPw;
		//var returnResult = false;
		
		$.ajax(
		{
			type : "GET"
			, url : "ajaxcheckpartnerpw.wei"
			, data : param
			, dataType : "json"
			, success : function(args)
			{
				var result = args.result;
				
				if (result!=1)
				{
					alert("비밀번호가 일치하지 않습니다.");
					$("#partnerPw").val("");
					$("#partnerPw").focus();
					return;
				}
				else
				{
					$(location).attr("href", "partnerupdateform.wei");
				}
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
	}
	
</script>
</head>
<body>

<!-- <div class="mainContainer"> -->
	<%-- 
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
	  --%>
	<div class="mainItem" style="background-color: none; width: 900px;">
		<div style="margin: 40px auto; font-size: 20px; text-align: center;">
			<span style="font-size: 15px;">비밀번호 재확인</span>
			<br>
			<p class="txt">
				회원님의 소중한 개인정보를 안전하게 보호하고<br>
				개인정보 도용으로 인한 피해를 예방하기 위하여 비밀번호를 확인합니다.<br>
				비밀번호는 타인에게 노출되지 않도록 주의해주세요.</p>
		</div>
		<hr style="border-top: 3px solid #eee;">
		
		<div class="containerPw">
			<!-- 회원번호 -->
			<div class="itemPw">아이디</div>
			<div class="itemPw"><%=loginId %></div>

			<div class="itemPw">비밀번호</div>
			<div class="itemPw">
				<input type="password" id="partnerPw" name="partnerPw" maxlength="14">
				<br><span class="errMsg" id="pwMsg"></span>
			</div>
			
			<div class="itemPw">
				<button type="button" id="sign" class="sign">내 정보 확인하기</button>
			</div>
		</div>
		<hr style="border-top: 3px solid #eee;">
	</div>
	 
<!-- </div> -->
<%-- 
<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>
 --%>

</body>
</html>