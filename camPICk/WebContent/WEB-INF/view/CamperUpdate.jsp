<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	String camperNum = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/CamperUpdate.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">

<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

.mainContainer
{
	font-family: 'S-CoreDream-6Bold';
}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script type="text/javascript">
	$(function()
	{		
		// 비밀번호 영문 + 숫자 검사
		$("#camperPw").keyup(function()
		{
			var regId = /^[A-Za-z0-9]{5,14}$/;
			
			if(!regId.test($("#camperPw").val()))
			{
				$("#pwMsg").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
			}
			else
			{
				$("#pwMsg").html("");
			}
			
			chkPw();
			
		});
		

		// 비밀번호 확인
		$("#pw2").keyup(function()
		{
			chkPw();
		});

		
		// 이름 한글 검사
		$("#camperName").blur(function()
		{
			var regExp = /^[가-힣]+$/;
			if(!regExp.test($("#camperName").val()))
			{
				$("#nameMsg").html("이름은 한글만 입력 가능합니다.");
				$("#camperName").val("");
			}
			else
			{
				$("#nameMsg").html("");
			}
		});

		
		// 휴대폰 번호 대쉬(-) 자동삽입
		$("#phone").keyup(function()
		{
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		
		// 이메일 주소 선택
		$("#selectEmail").change(function()
		{
			// 직접입력일 경우
			if($(this).val() == "1")
			{
				$("#email2").val("");
				$("#email2").attr("disabled", false);	//활성화
			}
			// 셀렉트박스 선택일 경우
			else
			{
				$("#email2").val($("#selectEmail").val());
				$("#email2").attr("disabled", true);	// 비활성화
			}
			
		});
		
		
		// 랜덤 인증번호 발송
		var rCode = randomCode(4);
		$("#cerNum").click(function()
		{
			if ($("#phone").val().length != 13)
			{
				$("#chkphoneMsg").html("휴대폰번호를 확인해주세요.");
			}
			else if ($("#phone").val().length == 13)
			{
				$("#chkphoneMsg").html("");
				$("#recerNum").val(rCode);
				$("#chkCerNum").attr("disabled", false);
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
		

		// 필수입력 항목 확인
		var infoCheck = function()
		{
			if($("#pwMsg").html() != "")
			{
				alert("비밀번호를 확인해 주십시오.");
				$("#camperPw").focus();
				return;
			}
			else if($("#pw2").val() == "")
			{
				alert("비밀번호 확인을 입력해 주십시오.");
				$("#pw2").focus();
				return;
			}
			else if($("#camperPw").val() != $("#pw2").val())
			{
				alert("비밀번호와 비밀번호 확인이 다릅니다.");
				$("#camperPw").focus();
				return;
			}
			else if($("#camperName").val() == "")
			{
				alert("이름을 입력해 주십시오.");
				$("#camperName").focus();
				return;
			}
			else if($("#phone").val() == "")
			{
				alert("휴대폰번호를 입력해 주십시오.");
				$("#phone").focus();
				return;
			}
			else if( ($("#cerNum").is(":enabled")) )
			{
				alert("인증번호를 확인해 주십시오.");
				return;
			}
			else if( ($("#email1").val()=="" && $("#email2").val()!="") || ($("#email1").val()!="" && $("#email2").val()=="") )
			{
				alert("이메일을 확인해 주십시오.");
				return;
			}
			else
			{
				$("#cFrm").submit();
				alert("회원정보 수정이 완료되었습니다.");
			}
		};
		 

		$("#sign").click(function()
		{
			if ($("#email1").val() != "" && $("#email2").val() != "")
			{
				$("#email").val($("#email1").val()+"@"+$("#email2").val());
			}
			infoCheck();
		});
		
	});
	
	
	// 비밀번호 값과 비밀번호 확인 값 비교
	function chkPw()
	{
		var pw1 = $("#camperPw").val();
		var pw2 = $("#pw2").val();

		if (pw1 != "" && pw2 != "")
		{
			if (pw1 != pw2)
			{
				$("#pw2Msg").html("비밀번호가 일치하지 않습니다.");
			}
			else
			{
				$("#pw2Msg").html("");
			}
		}
		
	}
	
	
	// 랜덤 자리수 발생
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
		<div style="margin-top: 50px; font-size: 20px;">
			회원정보
			<hr style="border-top: 3px solid #eee;">
		</div>
		
		<form class="containerC" id="cFrm" action="camperUpdate.wei">
		
		<!-- 이메일 주소 -->
		<input type="hidden" id="email" name="email" value="">
		<!-- 회원번호 -->
		<input type="hidden" id="camperNum" name="camperNum" value="<%=camperNum %>">
			
			<div class="itemC">아이디<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="camperId" name="camperId" value="${camper.camperId }" disabled="disabled">
			</div>
			
			<div class="itemC">비밀번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="password" id="camperPw" name="camperPw" maxlength="14">
				<br><span class="errMsg" id="pwMsg"></span>
			</div>
			
			<div class="itemC">비밀번호 확인<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="password" name="pw2" id="pw2" maxlength="14">
				<br><span class="errMsg" id="pw2Msg"></span>
			</div>
			
			<div class="itemC">이름<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="camperName" name="camperName" value="${camper.camperName }">
				<br><span class="errMsg" id="nameMsg"></span>
			</div>
			
			<div class="itemC">휴대폰번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="phone" name="phone" value="${camper.phone }">
				<button type="button" id="cerNum">인증번호 발송</button>
				<br><span class="errMsg" id="chkphoneMsg"></span>
			</div>
			<div class="itemC"></div>
			<div class="itemC">
				<input type="text" id="recerNum">
				<button type="button" id="chkCerNum" disabled="disabled">인증번호 확인</button>
				<br><span class="errMsg" id="chkCerMsg"></span>
			</div>
			
			<div class="itemC">이메일<span style="font-size: small;">[선택]</span></div>
			<div class="itemC">
				<input type="text" name="email1" id="email1" value="${fn:split(camper.email,'@')[0] }">
				 @ <input type="text" name="email2" id="email2" value="${fn:split(camper.email,'@')[1] }">
				<select name="selectEmail" id="selectEmail">
					<option value="1">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
				</select>
			</div>
			
			<div class="itemC">
				<div class="sel">
					<button type="button" id="sign" class="sign">수정하기</button>
				</div>
			</div>
		</form>
	</div>
	 
</div> 

<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>


</body>
</html>
