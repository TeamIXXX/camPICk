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
	
	function keywordCheck()
	{
		var naviSearch = document.getElementById("naviSearch").value;
		var naviSearch = $.trim(naviSearch);
		
		if(naviSearch == "")
		{
			alert("검색어를 입력하세요");
			return;
		}
		else
		{
			searchForm.submit();
		}
		
	}
	
</script>

</head>
<body>

<div class="col-md-12" id="leftNav" style="margin-top: 10px;">
	<ul class="menu" >
		<li style="line-height: 2;">
			<a href="campick.wei" class="Menu" style="font-weight: bold; font-size: medium;">HOME</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" onclick="campers()" style="font-size: medium;">campers <span class="glyphicon glyphicon-chevron-down" aria-hidden="true" 
			style="vertical-align: middle; font-size: small;"></span></span>
			<a href="" class="subMenu" id="together">camPICK 투게더</a>
			<a href="" class="subMenu" id="market">camPICK 마켓</a>
		</li>
		
		<li style="line-height: 2; ">
			<a href="" class="Menu" style="font-weight: bold; font-size: medium;">camper'Story</a>
		</li>
		
		<li style="line-height: 2; vertical-align: middle;">
			<a href="" class="Menu" style="font-weight: bold; font-size: medium;">캠핑크루</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" onclick="camping()" style="font-size: medium;">my 캠핑 <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"
			style="vertical-align: middle; font-size: small;"></span></span>
			<a href="" class="subMenu" id="calender">캘린더</a>
			<a href="checkPwForm.wei" class="subMenu" id="member">계정관리</a>
			<a href="bookinglist.wei" class="subMenu" id="camping">my 캠핑장</a>
			<a href="" class="subMenu" id="story">my stroy</a>
			<a href="" class="subMenu" id="crew">my 크루</a>
		</li>
		
		<li style="line-height: 2;">
			<span class="Menu" id="QnA" onclick="QnA()" style="font-size: medium;">고객문의 <span class="glyphicon glyphicon-chevron-down" aria-hidden="true" 
			style="vertical-align: middle; font-size: small;"></span></span>
			<a href="" class="subMenu" id="F&A" >F&A</a>
			<a href="" class="subMenu"  id="report">신고하기</a>
			<a href="" class="subMenu"  id="question">문의하기</a>
			<a href="" class="subMenu" id="alert">공지사항</a>

		</li>
		<li style="line-height: 5;">
			<form name ="searchForm" action="campgroundlist.wei" method="POST">
				<input type="text" class="naviSearch" name="naviSearch" id="naviSearch" placeholder="캠핑장을 검색하세요">
				 <button type="button" class="SearchBtn" onclick="keywordCheck()">
				 <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				 	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				 </svg>
				 </button>
				 
			</form>
		</li>
		 
	</ul>
</div>

</body>
</html>