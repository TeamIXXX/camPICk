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

$(function()
{
	$('#bookModal').modal('show');

	$('#bookModal').on('hidden.bs.modal', function()
	{
		//alert("확인");
		window.history.back();
	}); 
 
	$('#bookModalSubmit').on("click", function()
	{
		$("#bookModalForm").submit();
	});
	
});

 
</script>
</head>
<body>


<div class="modal fade" id="bookModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<form action="booking.wei" id="bookModalForm">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">예약 확인</h4>
				</div>
				<div class="modal-body">
					예약자명 : ${bookingDTO.name }<br> 핸드폰 번호 : ${bookingDTO.phone }<br> 예약
					일자 : ${bookingDTO.checkInDate } ~ ${bookingDTO.checkOutDate } <br> 객실 : ${bookingDTO.roomName }<br> 예약 인원 :
					${bookingDTO.visitNum }<br> 예약시 요청사항 : ${bookingDTO.request }<br> 결제
					예정 금액 :<span> ${bookingDTO.paymentAmount }</span>원<br>
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