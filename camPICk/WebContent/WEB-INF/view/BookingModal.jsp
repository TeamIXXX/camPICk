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
<title>BookingModal.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	var paymentAmount = ${bookingDTO.paymentAmount }
	var visitNum = ${bookingDTO.visitNum }
	
$(function()
{
	$('#bookModal').modal('show');

	$("#paymentAmount").html( (paymentAmount*visitNum).toLocaleString('ko-KR'));
	
	$('#bookModal').on('hidden.bs.modal', function()
	{
		//alert("확인");
		window.history.back();
	}); 
 
	$('#bookModalSubmit').on("click", function()
	{
		$("#bookModalForm").submit();
	});
	
	$('#bookModalReset').on("click", function()
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
	
	.bookingDetailSubTitle
	{
    	color: #45818E;
		display: inline-block;
		width: 120px;
		text-align: right;
		padding: 3px 2px;
	}
	
</style>
</head>
<body>


<div class="modal fade" id="bookModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<form action="booking.wei" id="bookModalForm">
			<div class="modal-content">
				<div class="modal-header">
					<span style="font-size: large;">예약 확인</span>
				</div>
				<div class="modal-body">
					<span class="bookingDetailSubTitle">예약자</span> : ${bookingDTO.name }<br> 
					<span class="bookingDetailSubTitle">연락처</span> : ${bookingDTO.phone }<br> 
					<span class="bookingDetailSubTitle">체크인 ~ 체크아웃</span>: ${bookingDTO.checkInDate } ~ ${bookingDTO.checkOutDate }<br> 
					<span class="bookingDetailSubTitle">객실</span> : ${bookingDTO.roomName }<br> 
					<span class="bookingDetailSubTitle">예약 인원</span>: ${bookingDTO.visitNum }<br> 
					<span class="bookingDetailSubTitle">예약시 요청사항</span> : ${bookingDTO.request }<br> 
					<span class="bookingDetailSubTitle">결제 예정 금액</span> : <span id="paymentAmount"></span>원<br>
					
					<br> 위 내용으로 예약하시겠습니까? 확인시 결제가 진행됩니다.<br>
	
				</div>
	
				<div class="modal-footer" style="align-content: center;">
					<button type="button" id="bookModalSubmit" class="btn btn-primary">확인</button>
					<button type="button" id="bookModalReset" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>


</body>
</html>