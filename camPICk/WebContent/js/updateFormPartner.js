/**
 * updateFormPartner.js
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


// 비밀번호 영문 + 숫자 검사
function chkPwLengthP()
{
	//var regId = /^[A-Za-z0-9+]*$/;
	var regPw = /^[A-Za-z0-9]{5,14}$/;
	
	if(!$("#partnerPwTemp").val())
	{
		$("#pwMsgP").html("영문, 숫자 5~14자 이내로 입력해 주십시오.");
		return;
	}
	else if (!regPw.test($("#partnerPwTemp").val()))
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
	var pw1 = $("#partnerPwTemp").val();
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
	if(!regExp.test($("#partnerNameTemp").val()))
	{
		$("#nameMsgP").html("이름은 한글만 입력 가능합니다.");
		$("#partnerNameTemp").val("");
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
	if (!$("#partnerPhoneTemp").val())
	{
		$("#chkTelMsgP").html("휴대폰번호를 입력해주세요.");
		return false;
	}
	else if (!regPhone.test($("#partnerPhoneTemp").val()))
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



/////////////////////////










