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

			}
			else							// 첨부한 파일 있음
			{

			}
			
		}
		else if(approvalStatusNum=="2")	// 반려 상태
		{

		}
		
	});

</script>
</head>
<body>
	<div class="col-md-12 partnerOkContainer">
		<div class="col-md-12 partnerApprovalTitle">
			승 인 현 황
		</div>
		
		<div class="col-md-12 partnerOkItem1">
			<div class="col-md-3 approvalstatus" id="approval1"><div class="approvalstatusCircle red">임시회원</div></div>
			<div class="col-md-1 approvalArrow"><img src="img/arrow.png" class="arrow"></div>
			<div class="col-md-3 approvalstatus" id="approval2"><div class="approvalstatusCircle">승인대기</div></div>
			<div class="col-md-1 approvalArrow"><img src="img/arrow.png" class="arrow"></div>
			<div class="col-md-3 approvalstatus" id="approval3"><div class="approvalstatusCircle" id="appResult">승인/반려</div></div>
		</div>
		
		<div class="col-md-12 partnerOkItem2">
			<div class="col-md-6 partnerFile" id="fileUpload">
				<label for="ex_filename">업로드</label>
				<div><input type="file" id="ex_filename" class=""></div>
	        </div>
			
			<div class="col-md-6 partnerSubmit" id="submitArea">
				<button type="submit" id="submit">신청</button>
				<button type="submit" id="submit">재신청</button>
			</div>
		</div>

		
	</div>

</body>
</html>