<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partnerUpdate.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/CamperUpdate.css">
<%-- <link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerMainTemplate.css">
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

#logo:hover
{
	cursor: pointer;
}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/js/updateFormPartner.js"></script>

<script type="text/javascript">
	$(function()
	{		
		// 비밀번호 영문 + 숫자 검사
		$("#partnerPwTemp").keyup(function()
		{
			$("#pwMsgP").html("");
			chkPwLengthP();
			chkPwP();
		});

		// 비밀번호 확인
		$("#pw2P").keyup(function()
		{
			chkPwP();
		});
		
		$("#partnerPwTemp").focusout(function()
		{
			if ($("#partnerPwTemp").val()=="")
				$("#pwMsgP").html("");
		});

		// 이름 한글 검사
		$("#partnerNameTemp").blur(function()
		{
			chkNameP();
		});

		
		// 휴대폰 번호 대쉬(-) 자동삽입
		$("#partnerPhoneTemp").keyup(function()
		{
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		

		// 랜덤 인증번호 발송
		var rCodeP = randomCode(4);
		$("#cerNumP").click(function()
		{
			if (chkPhoneLengthP())
			{
				$("#chkTelMsgP").html("");
				$("#recerNumP").val(rCodeP);
				$("#chkCerNumP").attr("disabled", false);
			}
		});

		// 랜덤 인증번호 확인
		$("#chkCerNumP").click(function()
		{
			var regPhone = /^\d{3}-\d{4}-\d{4}$/;

			if (!$("#partnerPhoneTemp").val())
			{
				$("#chkTelMsgP").html("휴대폰번호를 입력해주세요.");
			}
			else if (!regPhone.test($("#partnerPhone").val()))
			{
				$("#chkTelMsgP").html("휴대폰번호가 유효하지 않습니다.");
			}
			else if ($("#recerNumP").val() != rCodeP)
			{
				$("#chkCerMsgP").css("color", "red");
				$("#chkCerMsgP").html("인증번호를 확인해 주십시오.");
			}
			else if ($("#recerNumP").val() == rCodeP)
			{
				$("#chkCerMsgP").css("color", "#34aadc");
				$("#chkCerMsgP").html("인증번호가 확인 되었습니다.");
				$("#chkCerNumP").attr("disabled", true);
				$("#cerNumP").attr("disabled", true);
				//$("#partnerPhone").attr("readonly", true);
				//$("#recerNumP").attr("readonly", true);
			}
		});

		// 휴대폰번호 수정했을 경우
		$("#partnerPhoneTemp").keyup(function()
		{
			$("#checked_phoneP").val("n");
			$("#recerNumP").val("");
			$("#chkCerMsgP").html("");
			$("#cerNumP").attr("disabled", false);

		});

		// 이메일 주소 선택
		$("#selectEmailP").change(function()
		{
			chkEmailP();
		});

		
		// 필수입력 항목 확인
		var infoCheck = function()
		{
			if ($("#partnerPwTemp").val() != "" && $("#partnerPwTemp").val().length < 5)
			{
				alert("비밀번호를 확인해 주십시오.");
				$("#partnerPwTemp").focus();
				return false;
			}
			else if ($("#partnerPwTemp").val() != "" && $("#pw2P").val() == "")
			{
				alert("비밀번호 확인을 입력해 주십시오.");
				$("#pw2P").focus();
				return false;
			}
			else if ($("#partnerPwTemp").val() != "" && $("#partnerPwTemp").val() != $("#pw2P").val())
			{
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				$("#partnerPwTemp").focus();
				return false;
			} 
			else if ($("#partnerNameTemp").val() == "")
			{
				alert("이름을 입력해 주십시오.");
				$("#partnerNameTemp").focus();
				return false;
			} 
			else if (!$("#partnerPhoneTemp").val() == "" && $("#checked_phoneP").val() == "n" || $("#checked_phoneP").val() == "")
			{
				alert("휴대폰번호 인증을 해주세요.");
				return false;
			} 
			else if ($("#partnerPhoneTemp").val() == "")
			{
				alert("휴대폰번호를 입력해 주십시오.");
				$("#partnerPhoneTemp").focus();
				return false;
			} 
			else if (($("#cerNumP").is(":enabled")))
			{
				alert("인증번호를 확인해 주십시오.");
				return false;
			}
			else if (($("#emailP1").val() == "" && $("#emailP2").val() != "") || ($("#emailP1").val() != "" && $("#emailP2").val() == ""))
			{
				alert("이메일을 확인해 주십시오.");
				return false;
			} 
			
			if ($("#partnerPwTemp").val()!="")
			{
				$("#partnerPw").val($("#partnerPwTemp").val());
			}
		
			$("#partnerName").val($("#partnerNameTemp").val());
			$("#partnerPhone").val($("#partnerPhoneTemp").val());
			
			return true;
		};

		$("#signP").click(function()
		{
			if ($("#emailP1").val() != "" && $("#emailP2").val() != "")
				$("#partnerEmail").val($("#emailP1").val() + "@" + $("#emailP2").val());
			
			if (infoCheck())
			{
				if (confirm("회원정보를 수정하시겠습니까?"))
				{
					//alert($("#partnerPw").val() + " / " + $("#partnerName").val() + " / " + $("#partnerPhone").val());
					$("#partnerUpdateForm").submit();
				}
			}
		});
		
	});
	

</script>

</head>
<body>

<div class="PartnerMainTemplate">
	
	<div class="partnerMainItem">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
	<div class="partnerMainItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title2.png" style="width: 400px;" onclick="location.href='campick.wei'" id="logo">
	</div>
	<div class="partnerMainItem">
		<jsp:include page="PartnerSitemap.jsp"></jsp:include>
	</div>
	 
	<div class="partnerMainItem" style="background-color: none; flex-direction: column;">
		<div style="margin-top: 30px; font-size: 17px; width: 800px; align-self: center;">
			회원정보
			<hr style="border-top: 2px solid #eee;">
		</div>
		
		<div class="containerC">
			<div class="itemC">아이디<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="partnerIdTemp" name="partnerIdTemp" value="${partner.partnerId }" disabled="disabled">
			</div>
			
			<div class="itemC">현재 비밀번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="password" id="partnerNowPw" name="partnerNowPw" value="${partner.partnerPw }" disabled="disabled">
			</div>
			
			<div class="itemC">수정할 비밀번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="password" id="partnerPwTemp" name="partnerPwTemp" maxlength="14">
				<br><span class="errMsg" id="pwMsgP"></span>
			</div>
			
			<div class="itemC">수정 비밀번호 확인<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="password" name="pw2P" id="pw2P" maxlength="14">
				<br><span class="errMsg" id="pw2MsgP"></span>
			</div>
			
			<div class="itemC">이름<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="partnerNameTemp" name="partnerNameTemp" value="${partner.partnerName }">
				<br><span class="errMsg" id="nameMsgP"></span>
			</div>
			
			<div class="itemC">휴대폰번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="partnerPhoneTemp" name="partnerPhoneTemp" value="${partner.partnerPhone }">
				<button type="button" id="cerNumP">인증번호 발송</button>
				<br><span class="errMsg" id="chkphoneMsgP"></span>
			</div>
			<div class="itemC"></div>
			<div class="itemC">
				<input type="text" id="recerNumP">
				<button type="button" id="chkCerNumP" disabled="disabled">인증번호 확인</button>
				<br><span class="errMsg" id="chkCerMsgP"></span>
			</div>
			
			<div class="itemC">사업자등록번호<span class="nec">(*)</span></div>
			<div class="itemC">
				<input type="text" id="businesslicense" name="businesslicense" value="${partner.businesslicense }" disabled="disabled">
			</div>
			
			<div class="itemC">이메일<span style="font-size: small;">[선택]</span></div>
			<div class="itemC">
				<input type="text" name="emailP1" id="emailP1" value="${fn:split(partner.partnerEmail,'@')[0] }">
				 @ <input type="text" name="emailP2" id="emailP2" value="${fn:split(partner.partnerEmail,'@')[1] }">
				<select name="selectEmailP" id="selectEmailP">
					<option value="1">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
				</select>
			</div>
			
			<div class="itemC">
				<div class="sel">
					<button type="button" id="signP" class="sign">수정하기</button>
				</div>
			</div>
		</div>
		
		<form class="containerC" id="partnerUpdateForm" action="partnerupdate.wei" method="post" style="height: 5px;">
			<!-- 아이디 -->
			<input type="hidden" id="partnerId" name="partnerId" value="${partner.partnerId }">
			<!-- 회원번호 -->
			<input type="hidden" id="partnerNum" name="partnerNum" value="<%=num %>">
			<!-- 비밀번호 -->
			<input type="hidden" id="partnerPw" name="partnerPw" value="${partner.partnerPw }" >
			<!-- 이름 -->
			<input type="hidden" id="partnerName" name="partnerName" value="${partner.partnerName }">
			<!-- 휴대폰번호 -->
			<input type="hidden" id="partnerPhone" name="partnerPhone" value="${partner.partnerPhone }">
			<!-- 이메일 주소 -->
			<input type="hidden" id="partnerEmail" name="partnerEmail" value="${partner.partnerEmail }">
		</form>
	</div>
	 
</div> 

<div >
  <c:import url="Footer.jsp"></c:import>
</div>


</body>
</html>
