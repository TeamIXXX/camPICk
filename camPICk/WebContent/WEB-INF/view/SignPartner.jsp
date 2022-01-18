<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String root = pageContext.getServletContext().getRealPath("/");
	//C:\FinalCampick\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\camPICk\
	//System.out.println(root);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/SignPartner.css">
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/js/signupFormPartner.js"></script>

<script type="text/javascript">

	$(function()
	{
		// 모든 약관 동의
		$("#allChkP").click(function()
		{
			callAllChkP();
		});
		$("input[name=chkP]").click(function()
		{
			callChkP();         
		});
      
      
		// 아이디 중복 확인
		// 아이디 중복 확인 후 수정할 수 있으므로 다시 중복 확인하게 하기 위함
		$("#partnerId").keyup(function()
		{
			$("input[id=checked_idP]").val("n");
		});
      

		$("#duplBtnP").click(function()
		{
			var param = "id=" + $.trim($("#partnerId").val());

			$.ajax(
			{
				type : "GET",
				url : "ajaxSignupId.wei",
				data : param,
				dataType : "text",
				success : function(args)
				{
					if (args == 0)
					{
						$("#duplMsgP").css("color", "#34aadc");
						$("#duplMsgP").html("사용 가능한 아이디입니다.");

						$("input[id=checked_idP]").val("y");

					} else if (args == 1)
					{
						$("#duplMsgP").css("color", "red");
						$("#duplMsgP").html("이미 사용 중인 아이디입니다.");
					}

				},
				beforeSend : showRequestP,
				error : function(e)
				{
					alert(e.responseText);
				}
			});

		});

		// 비밀번호 영문 + 숫자 검사
		$("#partnerPw").keyup(function()
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

		// 이름 한글 검사
		$("#partnerName").blur(function()
		{
			chkNameP();
		});

		// 휴대폰 번호 대쉬(-) 자동삽입
		$("#partnerPhone").keyup(function()
		{
			$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-"));
		});

		// 사업자등록번호 (-) 자동삽입
		$("#businesslicense").keyup(function name()
		{
			$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/^(\d{2,3})(\d{1,2})(\d{5})$/,"$1-$2-$3"));
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
			;
		});

		// 랜덤 인증번호 확인
		$("#chkCerNumP").click(function()
		{
			var regPhone = /^\d{3}-\d{4}-\d{4}$/;

			if (!$("#partnerPhone").val())
			{
				$("#chkTelMsgP").html("휴대폰번호를 입력해주세요.");
			} else if (!regPhone.test($("#partnerPhone").val()))
			{
				$("#chkTelMsgP").html("휴대폰번호가 유효하지 않습니다.");
			} else if ($("#recerNumP").val() != rCodeP)
			{
				$("#chkCerMsgP").css("color", "red");
				$("#chkCerMsgP").html("인증번호를 확인해 주십시오.");
			} else if ($("#recerNumP").val() == rCodeP)
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
		$("#partnerPhone").keyup(function()
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
			if ($("#partnerId").val() == "")
			{
				alert("아이디를 입력해 주십시오.");
				$("#partnerId").focus();
				return false;
			} 
			else if ($("#checked_idP").val() == "n" || $("#checked_idP").val() == "")
			{
				alert("아이디 중복검사를 해 주십시오.");
				$("#partnerId").focus();
				return false;
			} 
			else if ($("#partnerPw").val() == "" || $("#partnerPw").val().length < 5)
			{
				alert("비밀번호를 확인해 주십시오.");
				$("#partnerPw").focus();
				return false;
			} 
			else if ($("#pw2P").val() == "")
			{
				alert("비밀번호 확인을 입력해 주십시오.");
				$("#pw2P").focus();
				return false;
			} 
			else if ($("#partnerPw").val() != $("#pw2P").val())
			{
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				$("#partnerPw").focus();
				return false;
			} 
			else if ($("#partnerName").val() == "")
			{
				alert("이름을 입력해 주십시오.");
				$("#partnerName").focus();
				return false;
			} 
			else if (!$("#partnerPhone").val() == "" && $("#checked_phoneP").val() == "n" || $("#checked_phoneP").val() == "")
			{
				alert("휴대폰번호 인증을 해주세요.");
				return false;
			} 
			else if ($("#partnerPhone").val() == "")
			{
				alert("휴대폰번호를 입력해 주십시오.");
				$("#partnerPhone").focus();
				return false;
			} 
			else if (($("#cerNumP").is(":enabled")))
			{
				alert("인증번호를 확인해 주십시오.");
				return false;
			}
			////// 사업자번호 확인 추가
			//else if(!chkLicense($("#licenseNum").val()))
			else if ($("#businesslicense").val() == "")
			{
				alert("사업자 등록번호를 입력해주십시오.");
				$("#businesslicense").focus();
				return false;
			} 
			else if (!chkLicenseLength())
			{
				alert("사업자 등록번호가 유효하지 않습니다.");
				$("#businesslicense").focus();
				return false;
			} 
			else if (($("#emailP1").val() == "" && $("#emailP2").val() != "")	|| ($("#emailP1").val() != "" && $("#emailP2").val() == ""))
			{
				alert("이메일을 확인해 주십시오.");
				return false;
			} 
			else if (!($("#allChkP").is(":checked")))
			{
				alert("모든 필수 약관에 동의하지 않으면 회원가입이 불가합니다.");
				return false;
			}
			return true;
		};

		$("#signP").click(function()
		{
			if ($("#emailP1").val() != "" && $("#emailP2").val() != "")
			{
				$("#partnerEmail").val($("#emailP1").val() + "@" + $("#emailP2").val());
			}
			//alert("이메일:" + $("#partnerEmail").val())
			if (infoCheck())
			{
				if (confirm("회원가입 하시겠습니까?"))
				{
					$("#pFrm").submit();
				}
				;
			}
			;
		});

	});
</script>

</head>
<body>

<!-- 아이디 중복검사 여부 확인 -->
<input type="hidden" id="checked_idP" value="">
<input type="hidden" id="checked_phoneP" value="">

<!-- 파트너 회원가입 -->
	<form class="containerP" id="pFrm" method="post" enctype="multipart/form-data" action="signuppartner.wei">
	
		<!-- 이메일 주소 -->
		<input type="hidden" id="partnerEmail" name="partnerEmail">
			
		<div class="itemP">아이디<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="text" id="partnerId" name="partnerId" maxlength="14" placeholder="영문, 숫자 8~14자 이내">
			<button type="button" class="" id="duplBtnP">중복확인</button>
			<br><span class="errMsg" id="duplMsgP"></span>
		</div>
		
		<div class="itemP">비밀번호<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="password" id="partnerPw" name="partnerPw" maxlength="14" placeholder="영문, 숫자 5~14자 이내">
			<br><span class="errMsg" id="pwMsgP"></span>
		</div>
		
		<div class="itemP">비밀번호 확인<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="password" name="pw2" id="pw2P" maxlength="14">
			<br><span class="errMsg" id="pw2MsgP"></span>
		</div>
		
		<div class="itemP">이름<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="text" id="partnerName" name="partnerName" maxlength="6" placeholder="한글만 입력 가능">
			<br><span class="errMsg" id="nameMsgP"></span>
		</div>
		
		<div class="itemP">휴대폰번호<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="text" id="partnerPhone" name="partnerPhone" placeholder="숫자만 입력">
			<button type="button" id="cerNumP">인증번호 발송</button>
			<br><span class="errMsg" id="chkTelMsgP"></span>
		</div>
		
		<div class="itemP"></div>
		<div class="itemP">
			<input type="text" id="recerNumP">
			<button type="button" id="chkCerNumP" disabled="disabled">인증번호 확인</button>
			<br><span class="errMsg" id="chkCerMsgP"></span>
		</div>
		<div class="itemP">사업자번호<span class="nec">(*)</span></div>
		<div class="itemP">
			<input type="text" id="businesslicense" name="businesslicense" maxlength="12">
		</div>
		<div class="itemP">증빙서류첨부</div>
		<div class="itemP">
			<input type="file" id="partnerSignFile" name="partnerSignFile">
		</div>
		
		<div class="itemP">이메일<span style="font-size: small;">[선택]</span></div>
		<div class="itemP">
			<input type="text" name="emailP1" id="emailP1"> @ <input type="text" name="emailP2" id="emailP2">
			<select name="selectEmailP" id="selectEmailP">
				<option value="1">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
			</select>
		</div>
		
		<div class="itemP">이용약관 및 개인정보 동의 <span class="nec">(*)</span></div>
		<div class="itemP">
		
			<div class="iC">
				<label><input type="checkbox" id="allChkP"> 모든 필수 약관에 동의합니다.</label>
			</div>
		
			<div class="iC">
			<textarea readonly="readonly" class="fregister" >
이용약관
				</textarea>
				<br><label><input type="checkbox" name="chkP"> 이용약관에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
			
			<div class="iC">
				<textarea readonly="readonly" class="fregister">
개인정보 이용 동의
				</textarea>
				<br><label><input type="checkbox" name="chkP"> 개인정보 수집 및 이용에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
		</div>
		
		<div class="itemP">
			<div class="sel">
				<button type="button" id="signP" class="sign">회원가입</button>
			</div>
			<div class="sel">
				<button type="button" class="cancel" onclick="location.href='campick.wei'">취소</button>
			</div>
		</div>
	</form>

</body>
</html>
