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
<title>PartnerSitemap.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerSitemap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		var num = "<%=num%>";
		
		if (num=="0")
		{
			$("#myBooking").click(function()
			{
				alert("회원 승인 완료 후 이용 가능합니다.");
				return;
			});
			$("#myCampground").click(function()
			{
				alert("회원 승인 완료 후 이용 가능합니다.");
				return;
			});
			$("#myQnA").click(function()
			{
				alert("회원 승인 완료 후 이용 가능합니다.");
				return;
			});
		}
		else
		{
			$("#myBooking").click(function()
			{			
				$(this).attr("href", "partnerbookingtemplate.wei");
			});
			
			$("#myCampground").click(function()
			{			
				$(this).attr("href", "mycampgroundtemplate.wei");
			});
			
			$("#myAccount").click(function()
			{
				$(this).attr("href", "partneraccounttemplate.wei");
			});
		}
		

	});

</script>
</head>
<body>


<div class="partnerSitemapItem">
	<ul class="partnerMainMenu">
		<li>
			<a href="" id="myAccount">계정 관리</a>
		</li>
		<li>
			<a href="" id="myBooking">예약 관리</a>
		</li>
		<li>
			<a href="" id="myCampground">내 캠핑장 관리</a>
		</li>
		<li>
			<a href="" id="myQnA">고객 문의</a>
		</li>
	</ul>
</div>


</body>
</html>