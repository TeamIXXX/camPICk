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
<title>PartnerOk.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerOk.css">
</head>

<body>
	<div class="partnerOkContainer">
		<div class="partnerOkItem">
			<h1>승 인 현 황</h1>
		</div>
		<div class="partnerOkItem">
			<p>※ 2021년 12월 25일까지 승인되지 않을 경우 탈퇴처리됩니다.</p>
		</div>
		<div class="partnerOkItem"><span>임시회원</span></div>
		<div class="partnerOkItem"><img src="img/arrow.png" class="arrow"></div>
		<div class="partnerOkItem2"><span>서류첨부</span></div>
		<div class="partnerOkItem"><img src="img/arrow.png" class="arrow"></div>
		<div class="partnerOkItem"><span>승인/반려</span></div>
		
		<div class="partnerOkItem2">
          <label for="ex_filename">업로드</label>
          <input type="file" id="ex_filename" class="upload-hidden"> 
          <p>승인완료. 회원가입을 축하합니다.🎉</p>
          <p>반려 사유 : 서류 형식이 잘못되었습니다.</p>
        </div>

		
		<div class="partnerOkItem">
		<button type="submit" id="submit">신청</button>
		<button type="submit" id="submit">재신청</button>
		</div>
		<div class="partnerOkItem2">ㅇㅇㅇ 회원님 반갑습니다. 
			<p>회원정보 수정 하려면 <a href="">여기</a>를 클릭하세요.</p>
		</div>

	</div>





</body>
</html>