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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Sign.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		// 라디오버튼에 따른 회원가입 폼
		$("#pDiv").hide();
		$("input[name=campa]").on("click", function()
		{
			var radioV = $("input[name=campa]:checked").val();
			
			if (radioV == "camper")
			{
				$("#cDiv").css("display", "block");
				$("#pDiv").css("display", "none");
			}
			else if (radioV == "partner")
			{
				$("#cDiv").css("display", "none");
				$("#pDiv").css("display", "block");
			}
		});
		
		
		// 진령쓰 여기부터 안건드림 
		
		// 아이디 중복 확인
		$("#duplBtn").click(function()
		{
			var params = "userId=" + $.trim($("#camperId").val());
			
			$.ajax({
				type: "POST"
				, url: "AjaxSignCamper.jsp"
				, data: params
				, success: function(args)
				{
					$("#result").html(args);
					
					$("#camperName").val("");
				}
				, beforeSend: showRequest
				, error: function(e)
				{
					alert(e.responseText);
				}
			})
			
			//$(document).ajaxStart(기능, 동작, 행위).ajaxComplete(기능, 동작, 행위);
			$(document).ajaxStart(function()
			{
				// AJAX 시작 시...
				$("#loading").show();
				$("#result").hide();
				
			}).ajaxComplete(function()
			{
				// AJAX 종료 시...
				$("#loading").hide();
				$("#result").show();
				
			});
			
		});
		
		
		
		// 비밀번호 확인
		$("#fault").hide();
		$("#pwd2").keyup(function()
		{
			var pwd1 = $("#camperPw").val();
			var pwd2 = $("#pwd2").val();
			
			if (pwd1 != "" || pwd2 != "")
			{
				if (pwd1 == pwd2)
				{
					$("#fault").hide();
					/* $("#submit").removeAttr("disabled"); */
				}
				else
				{
					$("#fault").show();
					/* $("#submit").attr("disabled", "disabled"); */
				}
				
			}
			
		});
		
		// 이메일 선택
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
		
		 
		// 필수입력 항목 확인
		
		
	});
	
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

</script>

</head>
<body>

<div class="item" style="text-align: center; margin-top: 5%; margin-bottom: 3%;">
	<img src="img/logo.png" width="15%;" />
</div>

<div class="itemSel" style="text-align: center; margin-bottom: 3%;">
	<div class="sel">
		<label for="camper">
			<input type="radio" name="campa" id="camper" value="camper" checked="checked"/> 개인회원
		</label> 
	</div>
	<div class="sel">
		<label for="partner">
			<input type="radio" name="campa" id="partner" value="partner"/> 파트너회원
		</label>
	</div>
</div>


<!-- 캠퍼 회원가입 -->
<div id="cDiv">
	<form class="containerC" id="cFrm">
		
		<div class="itemC">아이디<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="camperId">
			<button type="button" class="" id="duplBtn">중복확인</button>
			<br><span class="errMsg" id="result"></span>
		</div>
		
		<div class="itemC">비밀번호<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="password" name="camperPw" id="camperPw">
		</div>
		
		<div class="itemC">비밀번호 확인<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="password" name="reUserPwd" id="pwd2">
			<br><span class="errMsg" id="fault">입력하신 비밀번호와 일치하지 않습니다.</span>
		</div>
		
		<div class="itemC">이름<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="camperName">
		</div>
		
		<div class="itemC">휴대폰번호<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="camperPhone" placeholder="xxx-xxxx-xxxx">
			<button type="button" id="cerNum">인증번호 발송</button>
			<br><span class="errMsg">휴대폰번호를 확인해주세요.</span>
		</div>
		<div class="itemC"></div>
		<div class="itemC">
			<input type="text">
			<button type="button" id="reCerNum">인증번호 확인</button>
			<br><span class="errMsg">인증번호가 일치하지 않습니다.</span>
		</div>
		<div class="itemC">이메일<span style="font-size: small;">[선택]</span></div>
		<div class="itemC">
			<input type="text" name="email1" id="email1"> @ <input type="text" name="email2" id="email2">
			<select name="selectEmail" id="selectEmail">
				<option value="1">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
			</select>
		</div>
		
		<div class="itemC">이용약관 동의<span class="nec">(*)</span></div>
		<div class="itemC">
			<textarea cols="60" rows="10" style="resize: none;">이용약관</textarea>
			<br><input type="checkbox" id="chk">이용약관에 동의합니다.
		</div>
		
		<div class="itemC">
			<div class="sel">
				<button type="button" id="submit">회원가입</button>
			</div>
			<div class="sel">
				<button type="button">취소</button>
			</div>
		</div>
	</form>	
</div>


<!-- 파트너 회원가입 -->
<div id="pDiv">
	<form class="containerP" id="partnerFrm">
			
		<div class="itemP">아이디</div>
		<div class="itemP">
			<input type="text">
			<button type="button" class="">중복확인</button>
			<br><span class="errMsg">아이디를 입력하세요.</span>
		</div>
		<div class="itemP">비밀번호</div>
		<div class="itemP">
			<input type="text">
		</div>
		<div class="itemP">비밀번호 확인</div>
		<div class="itemP">
			<input type="text">
			<br><span class="errMsg">입력하신 비밀번호와 일치하지 않습니다.</span>
		</div>
		<div class="itemP">이름</div>
		<div class="itemP">
			<input type="text">
		</div>
		<div class="itemP">휴대폰번호</div>
		<div class="itemP">
			<input type="text" placeholder="xxx-xxxx-xxxx">
			<button type="button">인증번호 발송</button>
			<br><span class="errMsg">휴대폰번호를 확인해주세요.</span>
		</div>
		<div class="itemP"></div>
		<div class="itemP">
			<input type="text">
			<button type="button">인증번호 확인</button>
			<br><span class="errMsg">인증번호가 일치하지 않습니다.</span>
		</div>
		<div class="itemP">사업자번호</div>
		<div class="itemP">
			<input type="text">
		</div>
		<div class="itemP">증빙서류첨부</div>
		<div class="itemP">
			<input type="file">
		</div>
		<div class="itemP">이메일<span style="font-size: small;">[선택]</span></div>
		<div class="itemP">
			<input type="text" name="emailP1" id="emailP1"> @ <input type="text" name="emailP2" id="emailP2">
			<select name="selectEmail" id="selectEmailP">
				<option value="1">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
			</select>
		</div>
		<div class="itemP">이용약관 동의</div>
		<div class="itemP">
			<textarea cols="60" rows="10" style="resize: none;">이용약관</textarea>
			<br><input type="checkbox">이용약관에 동의합니다.
		</div>
		<div class="itemP">
		
			<div class="sel">
				<button type="button">회원가입</button>
			</div>
			<div class="sel">
				<button type="button">취소</button>
			</div>
		</div>
	</form>
</div>

</body>
</html>