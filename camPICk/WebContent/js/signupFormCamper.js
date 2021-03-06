/*
	signupFormCamper.js
*/

$(function()
{
	// 아이디 중복 확인
	// 아이디 중복 확인 후 수정할 수 있으므로 다시 중복 확인하게 하기 위함
	$("#camperId").keydown(function()
	{
		$("input[id=checked_id]").val("n");
	});
	
	$("#duplBtn").click(function()
	{
		// 영문 + 숫자 8~14자 이내 검사
		var regId = /^[A-Za-z0-9]{8,14}$/;

		if(!$("#camperId").val())
		{
			alert("아이디를 입력하세요.");
			$("#camperId").focus();
			return;
		}
		else if(!regId.test($("#camperId").val()))
		{
			alert("아이디는 영문, 숫자 8~14자 이내로 사용 가능합니다.");

			$("#camperId").val("");
			$("#camperId").focus();
			return;
		}
		
		var param = "id=" + $.trim($("#camperId").val());
		
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
	$("#camperPw").keyup(function()
	{
		var regPw = /^[A-Za-z0-9]{5,14}$/;
		
		if(!regPw.test($("#camperPw").val()))
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
		if ($("#phone").val() == "")
        {
			$("#chkphoneMsg").html("휴대폰번호를 입력해주세요.");
        }
         else if ($("#phone").val().length != 13)
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
	
	
	// 모든 약관 동의 체크박스
	$("#allChkC").click(function()
	{
		if($("#allChkC").is(":checked"))
			$("input[name=chkC]").prop("checked", true);
		else
			$("input[name=chkC]").prop("checked", false);
	});

	$("input[name=chkC]").click(function()
	{
		var total = $("input[name=chkC]").length;
		var checked = $("input[name=chkC]:checked").length;

		if(total != checked)
			$("#allChkC").prop("checked", false);
		else
			$("#allChkC").prop("checked", true); 
	});
	

	// 필수입력 항목 확인
	var infoCheck = function()
	{
		if($("#camperId").val() == "")
		{
			alert("아이디를 입력해 주십시오.");
			$("#camperId").focus();
			return;
		}
		else if($("#checked_id").val() == "n" || $("#checked_id").val() == "")
		{
			alert("아이디 중복검사를 해 주십시오.");
			$("#camperId").focus();
			return;
		}
		else if($("#pwMsg").html() != "")
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
		else if( !($("#allChkC").is(":checked")) )
		{
			alert("모든 필수 약관에 동의하지 않으면 회원가입이 불가합니다.");
			return;
		}
		else
		{
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
	
	if(!$("#camperId").val())
	{
		alert("아이디를 입력하세요.");
		$("#camperId").focus();
		flag=false;
	}
	
	return flag;
}

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
