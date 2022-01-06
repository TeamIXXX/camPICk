<%@page import="com.campick.dto.BookingDTO"%>
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
<title>BookingDetail.jsp</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		var basicNum = ${roomDTO.basicNum}; 
		var maxNum = ${roomDTO.maxNum};
		var paymentAmount = ${bookingDTO.paymentAmount}; 
		
		$("#paymentAmount").html( paymentAmount.toLocaleString('ko-KR') + "원 (1인 기준)");
		
		$("#err").css("display", "none");

		//예약 확인창
		$("#bookingInfoBtn").click( function()
		{
			if ($.trim($("#name").val()) == "" )
			{
				$("#err").html("필수입력 항목을 모두 입력해주세요");
				$("#err").css("display", "inline");
				$("#name").focus();
				return;
			}
			
			if ($.trim($("#phone").val()) == "")
			{
				$("#err").html("필수입력 항목을 모두 입력해주세요");
				$("#err").css("display", "inline");
				$("#phone").focus();
				return;
			}
			
			
			//전화번호 형식
			if (!isValidPhone($("#phone").val()))
			{
				$("#err").html("전화번호 형식을 확인 해주세요");
				$("#err").css("display", "inline");
				$("#phone").focus();
				return;
			}
			//전화 번호 자릿수
			if ($("#phone").val().length != 13)
			{
				$("#err").html("전화번호 자리수를 확인 해주세요");
				$("#err").css("display", "inline");
				$("#phone").focus();
				return;

			}

			if (!$("input:checked[id='box']").is(":checked"))
			{
				$("#err").html("체크박스를 선택 해주세요");
				$("#err").css("display", "inline");
				$("#box").focus();
				return;
			}

			$("#bookingForm").submit();
			
		});
 
		// 인원수 변경 시 결제 금액 변경
		$("#visitNum").on("input", function() 
		{
			$("#err").html("");
			
			if (parseInt($("#visitNum").val()) > maxNum
					|| parseInt($("#visitNum").val()) < basicNum 
					|| $("#visitNum").val()=="" )
			{
				$("#err").html("기준인원이상 최대인원이하 예약이 가능합니다");
				$("#err").css("display", "inline");
				$("#visitNum").focus();
				
				$("#paymentAmount").html( paymentAmount.toLocaleString('ko-KR') + "원 (1인 기준)");
				return;
			}
			
			$("#paymentAmount").html( (paymentAmount * parseInt($("#visitNum").val())).toLocaleString('ko-KR') + "원");
			
		});

		$('#bookingResetBtn').on("click", function()
		{
			window.history.back();
		});
		
		
	});
	
	
	
</script>
<style type="text/css">
	.form-group > .control-label { padding-left : 30px; }
	
	.star { padding : 0 5px; color : red; }
	
	.center { text-align: center; }
	
	#refund { width: 80%; }
   
	#paymentAmount { font-weight: bold;}
   
</style>

</head>
<body>

	<h1 style="text-align: center;">예약 정보 입력</h1>

	<form action="bookingmodal.wei" class="form-horizontal" id="bookingForm">
		<div class="form-group">
			<label class="col-xs-4 control-label">캠핑장 이름</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.campgroundName }</p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">객실 이름</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.roomName }</p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">체크인 ~ 체크아웃</label>
			<div class="col-xs-6">
				<p class="form-control-static">${bookingDTO.checkInDate } ~ ${bookingDTO.checkOutDate }</p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">예약자 명<span class="star">*</span></label>
			<div class="col-xs-4">
				<input type="text" class="form-control" id="name" name="name"
					placeholder="이름">
			</div>
		</div>


		<div class="form-group">
			<label class="col-xs-4 control-label">연락처<span class="star">*</span></label>
			<div class="col-xs-4">
				<input type="text" class="form-control" id="phone" name="phone"
					placeholder="xxx-xxxx-xxxx">
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">인원 수<span class="star">*</span></label>
			<div class="col-xs-4">
				<input type="number" class="form-control" id="visitNum" name="visitNum"  min="${roomDTO.basicNum}" max="${roomDTO.maxNum}"
					placeholder="${bookingDTO.roomName }방의 기준 인원 : ${roomDTO.basicNum}  /  최대 인원 : ${roomDTO.maxNum}">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-xs-4 control-label">금액</label>
			<div class="col-xs-4">
				<!-- 여기 AJAX로 처리 -->
				<p class="form-control-static" id=paymentAmount></p>
				<!-- ${bookingDTO.paymentAmount } -->
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">예약 시 요청사항</label>
			<div class="col-xs-4">
				<textarea rows="6" cols="50" class="form-control" name="request"
					placeholder="요청사항"></textarea>
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">
				<span sytle="color: blue;">${bookingDTO.campgroundName }</span>의 환불규정
			</label>
			<div class="col-xs-6">
					<!-- 여기 AJAX로 처리 -->
				<textarea rows="3" cols="50" class="form-control" name="refund" id="refund"
					readonly="readonly">예약 당일 ~ 3일전 : 결제금액의 30% 환불
예약 4일전~9일전 : 50% 환불
예약 10일전까지 : 100% 환불</textarea>
			</div>
		</div>
	
		<div class="form-group center" style="text-align: center;">
			<span class="input-group-addon">
        		<label>
        			<input type="checkbox" id="box"><span class="star">*</span>환불규정을 확인하였습니다.
        		</label>
      		</span>
			
			<label class="col-12 control-label">
				<span id="err" style="color: red; font-weight: bold; display:none;"></span>
			</label>
		</div>
			
		<div class="form-group center">
			<button type="button" id="bookingInfoBtn" class="btn btn-default">예약</button>
			<button type="button" id="bookingResetBtn" class="btn btn-default">취소</button>
		</div>

	</form>


</body>
</html>