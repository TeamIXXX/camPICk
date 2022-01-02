<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네비게이션 바</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/NavigationBar.css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<script type="text/javascript">
	
	function campers()
	{
		var sub1 = document.getElementById("together");
		var sub2 = document.getElementById("market");

		sub1.style.display ="block";
		sub2.style.display ="block";
	}
	
	function camping()
	{
		var sub1 = document.getElementById("calender");
		var sub2 = document.getElementById("member");
		var sub3 = document.getElementById("camping");
		var sub4 = document.getElementById("story");
		var sub5 = document.getElementById("crew");

		sub1.style.display ="block";
		sub2.style.display ="block";
		sub3.style.display ="block";
		sub4.style.display ="block";
		sub5.style.display ="block";
	}
	
	function QnA()
	{
		var sub1 = document.getElementById("F&A");
		var sub3 = document.getElementById("question");
		var sub4 = document.getElementById("alert");
		
		sub1.style.display ="block";
		sub3.style.display ="block";
		sub4.style.display ="block";
		
	}
	
	
</script>

</head>
<body>

<div class="col-md-12" id="leftNav">
	<ul class="menu" >
		<li style="line-height: 2;">
			<a href="campick.wei" class="Menu" style="font-weight: bold; font-size: 1.3vw;">HOME</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" onclick="campers()" style="font-size: 1.3vw;">campers <span class="glyphicon glyphicon-chevron-down" aria-hidden="true" 
			style="vertical-align: middle; font-size: medium;"></span></span>
			<a href="" class="subMenu" id="together">camPICK 투게더</a>
			<a href="" class="subMenu" id="market">camPICK 마켓</a>
		</li>
		
		<li style="line-height: 2; ">
			<a href="" class="Menu" style="font-weight: bold; font-size: 1.3vw;">camper'Story</a>
		</li>
		
		<li style="line-height: 2; vertical-align: middle;">
			<a href="" class="Menu" style="font-weight: bold; font-size: 1.3vw;">캠핑크루</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" onclick="camping()" style="font-size: 1.3vw;">my 캠핑 <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"
			style="vertical-align: middle; font-size: medium;"></span></span>
			<a href="" class="subMenu" id="calender">캘린더</a>
			<a href="" class="subMenu" id="member">계정관리</a>
			<a href="bookinglist.wei" class="subMenu" id="camping">my 캠핑장</a>
			<a href="" class="subMenu" id="story">my stroy</a>
			<a href="" class="subMenu" id="crew">my 크루</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" id="QnA" onclick="QnA()" style="font-size: 1.3vw;">고객문의 <span class="glyphicon glyphicon-chevron-down" aria-hidden="true" 
			style="vertical-align: middle; font-size: medium;"></span></span>
			<a href="" class="subMenu" id="F&A" >F&A</a>
			<a href="" class="subMenu"  id="report">신고하기</a>
			<a href="" class="subMenu"  id="question">문의하기</a>
			<a href="" class="subMenu" id="alert">공지사항</a>

		</li>
		
		<li style="line-height: 5;">
			<input type="text" class="naviSearch" placeholder="캠핑장을 검색하세요.">   
			<a href="" id="naviToSearch"><span class="glyphicon glyphicon-search" aria-hidden="true" 
			style="vertical-align: middle; font-size: large; color: black;"></span></a>
			<!-- 돋보기 이미지로 만들기 -->
		</li>
		 
	</ul>
</div>

</body>
</html>