/**
 * signupFormPartner.js
 */

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

// 모든 약관 동의 체크박스
function callAllChkP()
{
	if($("#allChkP").is(":checked"))
		$("input[name=chkP]").prop("checked", true);
	else
		$("input[name=chkP]").prop("checked", false);
}

function callChkP()
{
	var total = $("input[name=chkP]").length;
	var checked = $("input[name=chkP]:checked").length;

	if(total != checked)
		$("#allChkP").prop("checked", false);
	else
		$("#allChkP").prop("checked", true); 
}

// 아이디 중복검사 전, 아이디입력 여부 / 아이디 입력 조건 확인
function showRequestP()
{
	var flag = true;
	
	var regId = /^[A-Za-z0-9]{8,14}$/;

	if(!$("#partnerId").val())
	{
		alert("아이디를 입력하세요.");
		$("#partnerId").focus();
		flag=false;
	}
	else if (!regId.test($("#partnerId").val())) 
	{
		alert("아이디는 영문, 숫자 8~14자 이내로 사용 가능합니다.");

		$("#partnerId").val("");
		$("#partnerId").focus();
		flag=false;
	}
	
	return flag;
}

// 비밀번호 영문 + 숫자 검사
function chkPwLengthP()
{
	//var regId = /^[A-Za-z0-9+]*$/;
	var regPw = /^[A-Za-z0-9]{5,14}$/;
	
	if(!$("#partnerPw").val())
	{
		$("#pwMsgP").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
		return;
	}
	else if (!regPw.test($("#partnerPw").val()))
	{
		$("#pwMsgP").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
		return;
	}
	else
	{
		$("#pwMsgP").html("");
		return;
	}
}

//비밀번호 값과 비밀번호 확인 값 비교
function chkPwP()
{
	var pw1 = $("#partnerPw").val();
	var pw2 = $("#pw2P").val();
	
	if (pw1 != "" && pw2 != "")
	{
		if (pw1 != pw2)
		{
			$("#pw2MsgP").html("비밀번호가 일치하지 않습니다.");
		}
		else
		{
			$("#pw2MsgP").html("");
		}
	}
}

//이름 한글 검사
function chkNameP()
{
	var regExp = /^[가-힣]+$/;
	if(!regExp.test($("#partnerName").val()))
	{
		$("#nameMsgP").html("이름은 한글만 입력 가능합니다.");
		$("#partnerName").val("");
	}
	else
	{
		$("#nameMsgP").html("");
	}
}

//이메일 주소 선택
function chkEmailP()
{
	// 직접입력일 경우
	if($("#selectEmailP").val() == "1")
	{
		$("#emailP2").val("");
		$("#emailP2").attr("disabled", false);	//활성화
	}
	// 셀렉트박스 선택일 경우
	else
	{
		$("#emailP2").val($("#selectEmailP").val());
		$("#emailP2").attr("disabled", true);	// 비활성화
	}
}

// 인증번호 받기 클릭 시, 휴대폰번호 유효성 검사
function chkPhoneLengthP()
{
	var regPhone = /^\d{3}-\d{4}-\d{4}$/;
	if (!$("#partnerPhone").val())
	{
		$("#chkTelMsgP").html("휴대폰번호를 입력해주세요.");
		return false;
	}
	else if (!regPhone.test($("#partnerPhone").val()))
	{
		$("#chkTelMsgP").html("휴대폰번호가 유효하지 않습니다.");
		return false;
	}
	else
	{
		//$("#chkTelMsgP").html("");
		//$("#recerNumP").val(rCodeP);
		//$("#chkCerNumP").attr("disabled", false);
		return true;
	}
}

// 사업자번호 유효성 검사 => 진짜 사업장이 있다면 필요. 
// 그러나 현재는 진짜 사업자 등록번호를 확인할 수 없으므로 자리수만 확인. => chkLicenseLength()
function chkLicense()
{
	var numberMap = number.replace(/-/gi, '').split('').map(function (d){
		return parseInt(d, 10);
	});
	
	if(numberMap.length == 10){
		var keyArr = [1, 3, 7, 1, 3, 7, 1, 3, 5];
		var chk = 0;
		
		for(var i=0; i<keyArr.length; i++)
		{
			chk += numberMap[i] * keyArr[i];
		}
		
		chk += parseInt((keyArr[8] * numberMap[8])/ 10, 10);
		//console.log(chk);
		return Math.floor(numberMap[9]) === ( (10 - (chk % 10) ) % 10);
	}
	
	return false;
}

function chkLicenseLength()
{
	var regLicense = /^\d{3}-\d{2}-\d{5}$/;
	if (!regLicense.test($("#businesslicense").val()))
	{
		return false;
	}
	return true;
}











