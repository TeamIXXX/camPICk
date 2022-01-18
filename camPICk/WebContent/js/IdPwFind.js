/*
	IdPwFind.js
*/


$(function()
{	
	///////////////* 아이디 찾기 *///////////////
	// 라디오버튼에 따른 아이디 찾기 폼
	$(".id_find .partner").css("display", "none");
	$("input[name=find_id]").on("click", function()
	{
		var radioV = $("input[name=find_id]:checked").val();
		
		if (radioV == "camper")
		{
			$(".id_find .camper").css("display", "block");
			$(".id_find .partner").css("display", "none");
		}
		else if (radioV == "partner")
		{
			$(".id_find .camper").css("display", "none");
			$(".id_find .partner").css("display", "block");
		}
	});
	
	// 캠퍼 휴대폰 번호 대쉬(-) 자동삽입
	$(".camperPhone").keyup(function()
	{
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
	});
	
	// 파트너 휴대폰 번호 대쉬(-) 자동삽입
	$(".partnerPhone").keyup(function()
	{
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
	});
	
	// 캠퍼 아이디 찾기 랜덤 인증번호 받기
	var rCode = randomCode(4);
	$("#cerIdCNum").click(function()
	{
		if (!$(".id_find #camperPhone").val())
        {
			alert("휴대폰번호를 입력해주세요.");
			$(".id_find #camperPhone").focus();
        }
         else if ($("#camperPhone").val().length != 13)
		{
        	alert("휴대폰번호를 확인해주세요.");
        	$(".id_find #camperPhone").val("");
        	$(".id_find #camperPhone").focus();
		}
		else if ($("#camperPhone").val().length == 13)
		{
			$("#reIdCNum").val(rCode);
		}
	});
	
	// 파트너 아이디 찾기 랜덤 인증번호 받기
	var rCode = randomCode(4);
	$("#cerIdPNum").click(function()
	{
		if (!$(".id_find #partnerPhone").val())
        {
			alert("휴대폰번호를 입력해주세요.");
			$("#partnerPhone").focus();
        }
         else if ($(".id_find #partnerPhone").val().length != 13)
		{
        	alert("휴대폰번호를 확인해주세요.");
        	$(".id_find #partnerPhone").val("");
        	$(".id_find #partnerPhone").focus();
		}
		else if ($(".id_find #partnerPhone").val().length == 13)
		{
			$("#reIdPNum").val(rCode);
		}
	});
	
	// 캠퍼 아이디 찾기 인증번호 확인
	$("#chkIdCNum").click(function()
	{
		if ($(".id_find #camperPhone").val().length != 13)
		{
			alert("휴대폰번호를 확인해주세요.");
		}
		else if($("#reIdCNum").val() != rCode)
		{
			alert("인증번호를 확인해 주십시오.");
		}
		else if ($("#reIdCNum").val() == rCode)
		{
			alert("인증번호가 확인 되었습니다.");
			$("#chkIdCNum").attr("disabled", true);
			$("#cerIdCNum").attr("disabled", true);
			$(".id_find #camperPhone").attr("readonly", true);
			$("#reIdCNum").attr("readonly", true);
		}
		
	});
	
	// 파트너 아이디 찾기 인증번호 확인
	$("#chkIdPNum").click(function()
	{
		if ($(".id_find #partnerPhone").val().length != 13)
		{
			alert("휴대폰번호를 확인해주세요.");
		}
		else if($("#reIdPNum").val() != rCode)
		{
			alert("인증번호를 확인해 주십시오.");
		}
		else if ($("#reIdPNum").val() == rCode)
		{
			alert("인증번호가 확인 되었습니다.");
			$("#chkIdPNum").attr("disabled", true);
			$("#cerIdPNum").attr("disabled", true);
			$(".id_find #partnerPhone").attr("readonly", true);
			$("#reIdPNum").attr("readonly", true);
		}
		
	});
	
	// 캠퍼 아이디 찾기 버튼 클릭 시
	$("#id_cBtn").click(function()
	{
		if($("#camperName").val() == "")
		{
			alert("이름을 입력해 주십시오.");
			$("#camperName").focus();
			return;
		}
		else if($(".id_find #camperPhone").val() == "")
		{
			alert("휴대폰번호를 입력해 주십시오.");
			$(".id_find #camperPhone").focus();
			return;
		}
		else if( ($("#cerIdCNum").is(":enabled")) )
		{
			alert("인증번호를 확인해 주십시오.");
			return;
		}
		else
		{
			$("#idCFrm").submit();
		}
	});
	
	// 파트너 아이디 찾기 버튼 클릭 시
	$("#id_pBtn").click(function()
	{
		if($("#partnerName").val() == "")
		{
			alert("이름을 입력해 주십시오.");
			$("#partnerName").focus();
			return;
		}
		else if($(".id_find #partnerPhone").val() == "")
		{
			alert("휴대폰번호를 입력해 주십시오.");
			$(".id_find #partnerPhone").focus();
			return;
		}
		else if( ($("#cerIdPNum").is(":enabled")) )
		{
			alert("인증번호를 확인해 주십시오.");
			return;
		}
		else
		{
			$("#idPFrm").submit();
		}
	});
	
	
	
	///////////////* 비밀번호 재설정 *///////////////
	// 라디오버튼에 따른 비밀번호 재설정 폼
	$(".pw_find .partner").css("display", "none");
	$("input[name=pw_find]").on("click", function()
	{
		var radioV = $("input[name=pw_find]:checked").val();
		
		if (radioV == "camper")
		{
			$(".pw_find .camper").css("display", "block");
			$(".pw_find .partner").css("display", "none");
		}
		else if (radioV == "partner")
		{
			$(".pw_find .camper").css("display", "none");
			$(".pw_find .partner").css("display", "block");
		}
	});
	
	// 캠퍼 비밀번호 재설정 랜덤 인증번호 받기
	var rCode = randomCode(4);
	$("#cerPwCNum").click(function()
	{
		if (!$(".pw_find #camperPhone").val())
        {
			alert("휴대폰번호를 입력해주세요.");
			$(".pw_find #camperPhone").focus();
        }
         else if ($(".pw_find #camperPhone").val().length != 13)
		{
        	alert("휴대폰번호를 확인해주세요.");
        	$(".pw_find #camperPhone").val("");
        	$(".pw_find #camperPhone").focus();
		}
		else if ($(".pw_find #camperPhone").val().length == 13)
		{
			$("#rePwCNum").val(rCode);
		}
	});
	
	// 파트너 비밀번호 재설정 랜덤 인증번호 받기
	var rCode = randomCode(4);
	$("#cerPwPNum").click(function()
	{
		if (!$(".pw_find #partnerPhone").val())
        {
			alert("휴대폰번호를 입력해주세요.");
			$(".pw_find #partnerPhone").focus();
        }
         else if ($(".pw_find #partnerPhone").val().length != 13)
		{
        	alert("휴대폰번호를 확인해주세요.");
        	$(".pw_find #partnerPhone").val("");
        	$(".pw_find #partnerPhone").focus();
		}
		else if ($(".pw_find #partnerPhone").val().length == 13)
		{
			$("#rePwPNum").val(rCode);
		}
	});
	
	// 캠퍼 비밀번호 재설정 인증번호 확인
	$("#chkPwCNum").click(function()
	{
		if ($(".pw_find #camperPhone").val().length != 13)
		{
			alert("휴대폰번호를 확인해주세요.");
		}
		else if($("#rePwCNum").val() != rCode)
		{
			alert("인증번호를 확인해 주십시오.");
		}
		else if ($("#rePwCNum").val() == rCode)
		{
			alert("인증번호가 확인 되었습니다.");
			$("#chkPwCNum").attr("disabled", true);
			$("#cerPwCNum").attr("disabled", true);
			$(".pw_find #camperPhone").attr("readonly", true);
			$("#rePwCNum").attr("readonly", true);
		}
		
	});
	
	// 파트너 비밀번호 재설정 인증번호 확인
	$("#chkPwPNum").click(function()
	{
		if ($(".pw_find #partnerPhone").val().length != 13)
		{
			alert("휴대폰번호를 확인해주세요.");
		}
		else if($("#rePwPNum").val() != rCode)
		{
			alert("인증번호를 확인해 주십시오.");
		}
		else if ($("#rePwPNum").val() == rCode)
		{
			alert("인증번호가 확인 되었습니다.");
			$("#chkPwPNum").attr("disabled", true);
			$("#cerPwPNum").attr("disabled", true);
			$(".pw_find #partnerPhone").attr("readonly", true);
			$("#rePwPNum").attr("readonly", true);
		}
		
	});
	
	// 캠퍼 비밀번호 재설정 버튼 클릭 시
	$("#pw_cBtn").click(function()
	{
		if(!$("#camperId").val())
		{
			alert("아이디를 입력해 주십시오.");
			$("#camperId").focus();
			return;
		}
		else if(!$(".pw_find #camperPhone").val())
		{
			alert("휴대폰번호를 입력해 주십시오.");
			$(".pw_find #camperPhone").focus();
			return;
		}
		else if( ($("#cerPwCNum").is(":enabled")) )
		{
			alert("인증번호를 확인해 주십시오.");
			return;
		}
		else
		{
			$("#pwCFrm").submit();
		}
	});
	
	// 파트너 비밀번호 재설정 버튼 클릭 시
	$("#pw_pBtn").click(function()
	{
		if(!$("#partnerId").val())
		{
			alert("아이디를 입력해 주십시오.");
			$("#partnerId").focus();
			return;
		}
		else if(!$(".pw_find #partnerPhone").val())
		{
			alert("휴대폰번호를 입력해 주십시오.");
			$(".pw_find #partnerPhone").focus();
			return;
		}
		else if( ($("#cerPwPNum").is(":enabled")) )
		{
			alert("인증번호를 확인해 주십시오.");
			return;
		}
		else
		{
			$("#pwPFrm").submit();
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

