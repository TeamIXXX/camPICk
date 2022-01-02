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
<title>payment</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

$(function()
{
	$('#paymentModal').modal('show');
	$('.row').css("display", "none");
});

  
setTimeout( function()
{
	$('#paymentModal').modal('hide');
	$('.row').css("display", "inline");
	
} , 2000);
 
</script>
</head>
<body>


<div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" 
     aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">결제 중</h4>
			</div>
			<div class="modal-body">
				<div class="progress">
					<div class="progress-bar progress-bar-striped active"
						role="progressbar" aria-valuenow="80" aria-valuemin="0"
						aria-valuemax="100" style="width: 80%">
					</div>
				</div>
			</div>
			<div class="modal-footer" style="align-content: center;">
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-12" style="text-align: center; font-size: 13pt;">
		<br><br><br><br><br><br><br>
		예약이 완료되었습니다.<br>
		예약 번호 : ${bookingNum }<br> 
		<a href="bookinglist.wei">my 캠핑 > 캠핑 예약 및 이용 내역 조회</a> 에서 확인할 수 있습니다.
	</div>
</div>

</body>
</html>