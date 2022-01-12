<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	String loginId = (String)session.getAttribute("loginId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PartnerOk.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerOk.css">
</head>

<body>
	<div class="partnerOkContainer">
		<div class="partnerOkItem">
			<h1>승 인 현 황</h1>
		</div>
		<div class="partnerOkItem">
			<!-- <p>※ 2021년 12월 25일까지 승인되지 않을 경우 탈퇴처리됩니다.</p> -->
		</div>
		<div class="partnerOkItem"><span>임시회원</span></div>
		<div class="partnerOkItem"><img src="img/arrow.png" class="arrow"></div>
		<div class="partnerOkItem2"><span>서류첨부</span></div>
		<div class="partnerOkItem"><img src="img/arrow.png" class="arrow"></div>
		<div class="partnerOkItem"><span>승인/반려</span></div>
		
		<div class="partnerOkItem2">
          <label for="ex_filename">업로드</label>
          <input type="file" id="ex_filename" class="upload-hidden"> 
        </div>
		
		<div class="partnerOkItem">
		<button type="submit" id="submit">신청</button>
		<button type="submit" id="submit">재신청</button>
		</div>
		
	</div>

</body>
</html>