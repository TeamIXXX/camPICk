<%-- <%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파트너메인템플릿</title>
<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

.mainContainer
{
	font-family: 'S-CoreDream-6Bold';
}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerMainTemplate.css">

</head>
<body>

<div class="PartnerMainTemplate">
   <div class="partnerMainItem">
      <jsp:include page="TopMenu.jsp"></jsp:include>
   </div>
   <div class="partnerMainItem" id="mainLogo">
      <img src="<%=cp%>/img/logo_title.png">
   </div>
   <div class="partnerMainItem">
      <jsp:include page="PartnerSitemap.jsp"></jsp:include>
   </div>
   <div class="partnerMainItem">
      내용부분
   </div>
</div>

<footer>
    <c:import url="Footer.jsp"></c:import>
</footer>

</body>
</html> --%>