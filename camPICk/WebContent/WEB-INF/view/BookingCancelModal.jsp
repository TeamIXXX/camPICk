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
<title>BookingCancelModal.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$('#bookCancelModal').modal('show');
		
		var paymentAmount = ${bookingDTO.paymentAmount};
		// 환불율 퍼센트로 환산.
		var refund = (100 - ${refund})/100;
		var refundAmount = refund*paymentAmount;
		
		$("#paymentAmount").html( paymentAmount.toLocaleString('ko-KR') );
		$("#refundAmount").html( refundAmount.toLocaleString('ko-KR') );
		
		
		$('#bookCancelModal').on('hidden.bs.modal', function()
		{
			//리다이렉트
			$(location).attr("href", "bookingcancel.wei");
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
	<div class="modal fade" id="bookCancelModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">예약 취소가 완료 되었습니다.</h4>
				</div>
				<div class="modal-body">
					<span class="bookingDetailSubTitle">예약번호</span> : ${bookingDTO.bookingNum }<br> 
					<span class="bookingDetailSubTitle">예약 날짜</span> : ${bookingDTO.bookingDate }<br> 
					<span class="bookingDetailSubTitle">객실</span> : ${bookingDTO.roomName }<br>
					<span class="bookingDetailSubTitle">예약자 명</span> : ${bookingDTO.name }<br> 
					<span class="bookingDetailSubTitle">체크인 ~ 체크아웃</span> : ${bookingDTO.checkInDate } ~ ${bookingDTO.checkOutDate }<br>
					<span class="bookingDetailSubTitle">결제 금액</span> : <span id="paymentAmount"></span>원<br> <span
						class="bookingDetailSubTitle">환불 금액</span> : <span id="refundAmount" style="color: red;"></span>원<br>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 모달 div end -->

</body>
</html>