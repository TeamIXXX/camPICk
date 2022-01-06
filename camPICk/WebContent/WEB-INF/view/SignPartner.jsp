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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/SignPartner.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script type="text/javascript">
	$(function()
	{
		// 수지가 아이디 바꿔서 넣으면 될 듯!!
		
		// 아이디 중복 확인
		// 아이디 중복 확인 후 수정할 수 있으므로 다시 중복 확인하게 하기 위함
		$("#partnerId").keydown(function()
		{
			$("input[id=checked_id]").val("n");
		});
		
		$("#duplBtn").click(function()
		{
			// 영문 + 숫자 8~14자 이내 검사
			var regId = /^[A-Za-z0-9]{8,14}$/;

			if(!regId.test($("#partnerId").val()))
			{
				alert("아이디는 영문, 숫자 8~14자 이내로 사용 가능합니다.");

				$("#partnerId").val("");
				$("#partnerId").focus();

				return;
			}
			
			var param = "id=" + $.trim($("#partnerId").val());
			
			$.ajax({
				type: "GET"
				, url: "ajaxSignupId.wei"
				, data: param
				, dataType: "text"
				, success: function(args)
				{
					if (args==0)
					{
						$("#duplMsg").css("color", "#34aadc");
						$("#duplMsg").html("사용 가능한 아이디입니다.");
						
						$("input[id=checked_id]").val("y");
						
					}
					else if (args==1)
					{
						$("#duplMsg").css("color", "red");
						$("#duplMsg").html("이미 사용 중인 아이디입니다.");
					}

				}
				, beforeSend: showRequest
				, error: function(e)
				{
					alert(e.responseText);
				}
			});
			
		});
		
		
		// 비밀번호 영문 + 숫자 검사
		$("#partnerPw").keyup(function()
		{
			var regId = /^[A-Za-z0-9+]*$/;
			
			if(!regId.test($("#partnerPw").val()))
			{
				$("#pwMsg").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
				$("#partnerPw").val("");
				return;
			}
			else if ($("#partnerPw").val().length < 5)
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
		$("#partnerName").blur(function()
		{
			var regExp = /^[가-힣]+$/;
			if(!regExp.test($("#partnerName").val()))
			{
				$("#nameMsg").html("이름은 한글만 입력 가능합니다.");
				$("#partnerName").val("");
			}
			else
			{
				$("#nameMsg").html("");
			}
		});
		

		// 휴대폰 번호 대쉬(-) 자동삽입
		$("#partnerPhone").keyup(function()
		{
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		// 이메일 입력 시 input에 들어가게
		$("#email1").keyup(function()
		{
			//$("#email").val($("#email1").val());
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
			if ($("#partnerPhone").val().length != 13)
			{
				$("#chkTelMsg").html("휴대폰번호를 확인해주세요.");
			}
			else if ($("#partnerPhone").val().length == 13)
			{
				$("#chkTelMsg").html("");
				$("#recerNum").val(rCode);
				$("#chkCerNum").attr("disabled", false);
			}
		});
		
		
		// 랜덤 인증번호 확인
		$("#chkCerNum").click(function()
		{
			if ($("#partnerPhone").val().length != 13)
			{
				$("#chkpartnerPhoneMsg").html("휴대폰번호를 확인해주세요.");
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
				$("#partnerPhone").attr("readonly", true);
				$("#recerNum").attr("readonly", true);
			}
			
		});
		
		
		// 모든 약관 동의 체크박스
		$("#allChk").click(function()
		{
			if($("#allChk").is(":checked"))
				$("input[name=chk]").prop("checked", true);
			else
				$("input[name=chk]").prop("checked", false);
		});

		$("input[name=chk]").click(function()
		{
			var total = $("input[name=chk]").length;
			var checked = $("input[name=chk]:checked").length;
	
			if(total != checked)
				$("#allChk").prop("checked", false);
			else
				$("#allChk").prop("checked", true); 
		});
		

		// 필수입력 항목 확인
		var infoCheck = function()
		{
			if($("#partnerId").val() == "")
			{
				alert("아이디를 입력해 주십시오.");
				$("#partnerId").focus();
				return;
			}
			else if($("#checked_id").val() == "n" || $("#checked_id").val() == "")
			{
				alert("아이디 중복검사를 해 주십시오.");
				$("#partnerId").focus();
				return;
			}
			else if($("#partnerPw").val() == "" || $("#partnerPw").val().length < 5)
			{
				alert("비밀번호를 확인해 주십시오.");
				$("#partnerPw").focus();
				return;
			}
			else if($("#pw2").val() == "")
			{
				alert("비밀번호 확인을 입력해 주십시오.");
				$("#pw2").focus();
				return;
			}
			else if($("#partnerPw").val() != $("#pw2").val())
			{
				alert("비밀번호와 비밀번호 확인이 다릅니다.");
				$("#partnerPw").focus();
			}
			else if($("#partnerName").val() == "")
			{
				alert("이름을 입력해 주십시오.");
				$("#partnerName").focus();
				return;
			}
			else if($("#partnerPhone").val() == "")
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
			
			////// 사업자번호 확인 추가
			
			else if( ($("#email1").val()=="" && $("#email2").val()!="") || ($("#email1").val()!="" && $("#email2").val()=="") )
			{
				alert("이메일을 확인해 주십시오.");
				return;
			}
			else if( !($("#allChk").is(":checked")) )
			{
				alert("모든 필수 약관에 동의하지 않으면 회원가입이 불가합니다.");
				return;
			}
			else
			{
				alert("회원가입이 완료되었습니다.");
				$("#cFrm").submit();
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
	
	
	
	// 아이디 중복 확인 ajax beforeSend
	function showRequest()
	{
		var flag = true;
		
		if(!$("#partnerId").val())
		{
			alert("아이디를 입력하세요.");
			$("#partnerId").focus();
			flag=false;
		}
		
		return flag;
	}
	
	// 비밀번호 값과 비밀번호 확인 값 비교
	function chkPw()
	{
		var pw1 = $("#partnerPw").val();
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

<!-- 아이디 중복검사 여부 확인 -->
<input type="hidden" id="checked_id" value="">

<!-- 파트너 회원가입 -->
	<form class="container" id="pFrm">
			
		<div class="item">아이디<span class="nec">(*)</span></div>
		<div class="item">
			<input type="text" id="partnerId">
			<button type="button" class="" id="duplBtn">중복확인</button>
			<br><span class="errMsg" id="duplMsg"></span>
		</div>
		
		<div class="item">비밀번호<span class="nec">(*)</span></div>
		<div class="item">
			<input type="password" id="partnerPw" maxlength="14">
			<br><span class="errMsg" id="pwMsg"></span>
		</div>
		
		<div class="item">비밀번호 확인<span class="nec">(*)</span></div>
		<div class="item">
			<input type="password" name="pw2" id="pw2" maxlength="14">
			<br><span class="errMsg" id="pw2Msg"></span>
		</div>
		
		<div class="item">이름<span class="nec">(*)</span></div>
		<div class="item">
			<input type="text" id="partnerName" maxlength="6">
			<br><span class="errMsg" id="nameMsg"></span>
		</div>
		
		<div class="item">휴대폰번호<span class="nec">(*)</span></div>
		<div class="item">
			<input type="text" id="partnerPhone">
			<button type="button" id="cerNum">인증번호 발송</button>
			<br><span class="errMsg" id="chkTelMsg"></span>
		</div>
		
		<div class="item"></div>
		<div class="item">
			<input type="text" id="recerNum">
			<button type="button" id="chkCerNum" disabled="disabled">인증번호 확인</button>
			<br><span class="errMsg" id="chkCerMsg"></span>
		</div>
		<div class="item">사업자번호<span class="nec">(*)</span></div>
		<div class="item">
			<input type="text">
		</div>
		<div class="item">증빙서류첨부</div>
		<div class="item">
			<input type="file">
		</div>
		
		<div class="item">이메일<span style="font-size: small;">[선택]</span></div>
		<div class="item">
			<input type="text" name="email1" id="email1"> @ <input type="text" name="email2" id="email2">
			<select name="selectEmail" id="selectEmail">
				<option value="1">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
			</select>
		</div>
		
		<div class="item">이용약관 및 개인정보 동의 <span class="nec">(*)</span></div>
		<div class="item">
		
			<div class="iC">
				<label><input type="checkbox" id="allChk"> 모든 필수 약관에 동의합니다.</label>
			</div>
		
			<div class="iC">
			<textarea readonly="readonly" class="fregister" >
이용약관
				</textarea>
				<br><label><input type="checkbox" name="chk"> 이용약관에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
			
			<div class="iC">
				<textarea readonly="readonly" class="fregister">
개인정보 이용 동의
				</textarea>
				<br><label><input type="checkbox" name="chk"> 개인정보 수집 및 이용에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
		</div>
		
		<div class="item">
			<div class="sel">
				<button type="button" id="sign" class="sign">회원가입</button>
			</div>
			<div class="sel">
				<button type="button" class="cancel">취소</button>
			</div>
		</div>
	</form>

</body>
</html>
