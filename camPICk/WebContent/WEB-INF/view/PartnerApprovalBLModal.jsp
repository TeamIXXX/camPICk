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
<title>PartnerApprovalBLModal.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">


	
$(function()
{
	$('#BSModal').modal('show');

	$('#BSModal').on('hidden.bs.modal', function()
	{
		//alert("확인");
		window.history.back();
	}); 
 	
	$('#BSModalSubmit').on("click", function()
	{
		location.href = "partnerapprovalinsert.wei?approvalnum=1&pi=${pi }";
	});
	
	$('#BSModalReject').on("click", function()
	{
		location.href = "partnerapprovalinsert.wei?approvalnum=2&pi=${pi }";
	});
	
	$('#BSModalReset').on("click", function()
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
	
</style>
</head>
<body>


<div class="modal fade" id="BSModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span style="font-size: large;">아이디 : ${pi } / 사업자등록번호 : ${bl } </span>
			</div>
			<div class="modal-body">
				<img src="img/Business_license.png">

			</div>

			<div class="modal-footer" style="align-content: center;">
			
				<button type="button" id="BSModalSubmit" class="btn btn-primary">승인</button>
				<button type="button" id="BSModalReject" class="btn btn-warning">반려</button>
				<button type="button" id="BSModalReset" class="btn btn-default" data-dismiss="modal">돌아가기</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>