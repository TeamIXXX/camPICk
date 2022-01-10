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
<title>BookingCancelForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function()
	{
		
		var paymentAmount = ${bookingDTO.paymentAmount};
		// 환불율 퍼센트로 환산.
		var refund = (100 - ${refund})/100;
		
		var refundAmount = refund*paymentAmount;
		
		$("#paymentAmount").html( paymentAmount.toLocaleString('ko-KR') + "원");
		$("#refundAmount").html( refundAmount.toLocaleString('ko-KR') + "원" );
		
		
		$("#bookingCancelBtn").click(function()
		{
			if (!$("input:checked[id='box']").is(":checked"))
			{
				$("#err").html("체크박스를 선택 해주세요");
				$("#err").css("display", "inline");
				$("#box").focus();
				return;
			}
			
				//확인버튼 눌렀을때 이동
				$(location).attr("href", "bookingcancelmodal.wei");
		});
		
		$("#bookingCancelCloseBtn").click(function()
		{
			window.history.back();
		});
		
		
		
	});
</script>
<style type="text/css">
	
	@font-face 
	{
	     font-family: 'S-CoreDream-6Bold';
	     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
	     font-weight: normal;
	     font-style: normal;
	}
	
	* {	font-family: 'S-CoreDream-6Bold'; }
	
   .form-group > .control-label { padding-left : 30px; }
   
   .star
   {
      padding : 0 5px;
      color : red;
   }
   
   .center
   {
      text-align: center;
   }
   #refund
   {
      width: 70%;
   }
</style>

</head>

<body>

	<h1 style="text-align: center; font-family: 'S-CoreDream-6Bold';">이용내역</h1>

	<div class="form-horizontal">
		<div class="form-group">
			<label class="col-xs-4 control-label">예약번호</label>
			<div class="col-xs-4" >
				<p class="form-control-static">${bookingDTO.bookingNum}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">예약 날짜</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.bookingDate}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">객실 이름</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.roomName }</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">예약자 명</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.name}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">연락처</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.phone}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">결제일</label>
			<div class="col-xs-4">
				<p class="form-control-static">${bookingDTO.bookingDate }</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">결제 금액</label>
			<div class="col-xs-4">
				<p class="form-control-static" id=paymentAmount><!-- 금액 --></p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-4 control-label">환불 금액</label>
			<div class="col-xs-4">
				<p class="form-control-static" id=refundAmount style="color: red; font-weight: bold; "><!-- 환불규정에 맞춰서 계산 --></p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-xs-4 control-label">환불규정</label>
			<div class="col-xs-6">
				<textarea rows="3" cols="80" class="form-control" name="refund" id="refund" 
					readonly="readonly">예약 당일 ~ 3일전 : 결제금액의 ${100- campgroundDTO.policyStandard1 }% 환불
예약 4일전~9일전 : ${100- campgroundDTO.policyStandard2 }% 환불
예약 10일전까지 : ${100- campgroundDTO.policyStandard3 }% 환불</textarea>
			</div>
		</div>

		<div class="form-group center">
			<span class="input-group-addon"> <label> 
				<input type="checkbox" id="box"><span class="star">*</span>
					환불규정을 확인하였습니다.
				</label>
			</span>
		</div>

		<div class="form-group center">
			<button type="button" id="bookingCancelBtn" class="btn btn-default">예약 취소</button>
			<button type="button" id="bookingCancelCloseBtn" class="btn btn-default">창닫기</button>
		</div>				
		
	</div>

</body>
</html>