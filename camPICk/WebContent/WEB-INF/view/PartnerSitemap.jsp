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
<title>PartnerSitemap.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerSitemap.css">
</head>
<body>


<div class="partnerSitemapItem">
	<ul class="partnerMainMenu">
		<li>
			<a href="#">계정 관리</a>
			<ul class="partnerSiteSubMenu">
				<li><a href="#">승인현황</a></li>
				<li><a href="#">계정정보관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">예약 관리</a>
		</li>
		<li>
			<a href="mycampgroundtemplate.wei">내 캠핑장 관리</a>
		</li>
		<li>
			<a href="#">고객 문의</a>
		</li>
	</ul>
</div>


</body>
</html>