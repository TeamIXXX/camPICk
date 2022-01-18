<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	String loginId = (String)session.getAttribute("loginId");
	
	//String approvalStatusNum = (String)request.getParameter("approvalStatusNum");
	//String fileExist = (String)request.getParameter("fileExist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PartnerOk.jsp</title>
<%-- <link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerOk.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerAccountApproval.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">

	var approvalStatusNum = ${approvalStatusNum};
	var fileExist = ${fileExist};
	
	$(function()
	{
		if (approvalStatusNum=="0")	// 대기 상태
		{
			var str1 = "";
			var str2 = "";
			if (fileExist=="0")		// 첨부한 파일 없음
			{
				$("#approval1").addClass("red");
				$("#approval2").removeClass("red");
				$("#approval3").removeClass("red");
				$("#fileArea").html("<input type='file' id='ex_filename' name='partnerSignFile'>");
				$("#btns").html("<button type='button' id='submitBtn'>신청</button>");
			}
			else							// 첨부한 파일 있음
			{
				$("#approval1").removeClass("red");
				$("#approval2").addClass("red");
				$("#approval3").removeClass("red");
				$("#fileArea").html("서류첨부 완료. 승인처리 진행 중입니다.")
				$("#btns").html("");
			}
			
		}
		else if(approvalStatusNum=="2")	// 반려 상태
		{
			$("#approval1").removeClass("red");
			$("#approval2").removeClass("red");
			$("#approval3").addClass("red");
			$("#approval3").html("반려");
			$("#fileArea").html("승인 결과 : 반려. 서류 재첨부 바랍니다.<br><input type='file' id='ex_filename' name='partnerSignFile'>");
			$("#btns").html("<button type='button' id='submitBtn'>재신청</button>");
		}
		
		
		$("#submitBtn").click(function()
		{
			if (!$("#ex_filename").val())
			{
				alert("파일을 첨부해주세요.");
				return;
				
			};

			$("#fileUpdateForm").submit();
			
		});
		
	});

</script>
</head>
<body>
	<div class="col-md-12 partnerOkContainer">
		<div class="col-md-12 partnerApprovalTitle">
			[ 승 인 현 황 ]
		</div>
		
		<div class="col-md-12 partnerOkItem1">
			<div class="col-md-1"></div>
			<div class="col-md-2 approvalstatus"><div class="approvalstatusCircle red" id="approval1">임시회원</div></div>
			<div class="col-md-2 approvalArrow"><img src="img/arrow.png" class="arrow"></div>
			<div class="col-md-2 approvalstatus"><div class="approvalstatusCircle" id="approval2">승인대기</div></div>
			<div class="col-md-2 approvalArrow"><img src="img/arrow.png" class="arrow"></div>
			<div class="col-md-2 approvalstatus"><div class="approvalstatusCircle" id="approval3">승인/반려</div></div>
			<div class="col-md-1"></div>
		</div>
		
		<form id="fileUpdateForm" enctype="multipart/form-data" action="signuppartnerfileupdate.wei" method="post">
			<div class="col-md-12 partnerOkItem2" style="text-align: center;">
				<div id="fileArea" style="text-align: center;">
					<!-- <input type="file" id="ex_filename" class="" name="partnerSignFile"> -->
				</div>
				<div class="btns" id="btns">
					<!-- <button type="button" id="submitBtn">신청</button> -->
				</div>
			</div>
		</form>
		
	</div>

</body>
</html>