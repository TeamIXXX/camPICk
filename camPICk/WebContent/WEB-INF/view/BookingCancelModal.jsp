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

			$('#bookCancelModal').on('hidden.bs.modal', function()
			{
				
				//리다이렉트
				$(location).attr("href", "bookingcancel.wei");
				
			}); 
			
		});
</script>
</head>
<body>
<div class="modal fade" id="bookCancelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
   
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">예약 취소가 완료 되었습니다.</h4>
      </div>
      <div class="modal-body">
					예약번호 : ${bookingDTO.bookingNum }<br>
					예약 날짜 : ${bookingDTO.bookingDate }<br> 
					객실 : ${bookingDTO.roomName }<br> 
					예약자 명 :	${bookingDTO.name }<br>
					결제 예정 금액 :<span> ${bookingDTO.paymentAmount  }</span>원<br><br> 
					환불금액 : ${bookingDTO.paymentAmount  }	
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