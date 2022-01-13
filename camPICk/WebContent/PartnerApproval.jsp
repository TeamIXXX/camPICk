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
<title>PartnerApproval</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<%-- <link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerApproval.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/tabStyle.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	function sendIt()
	{
		var f = document.searchForm;
		
		// 검색 키워드에 대한 유효성 검사 코드 활용 가능
		
		// check~!~!!!!
		// 검색한 키워드가 있는 결과를 보여주기 위해 List.jsp 를 다시 보여줌.
		f.action = "<%=cp%>/List.jsp";
		f.submit();
	}
</script>
</head>
<body>


<%-- <%=cp %> --%>

<div id="bbsList">

	<div id="bbsList_title">
		게 시 판 (JDBC 연동 버전)
	</div>
	
	<div id="bbsList_header">
		
		<div id="leftHeader">
			<!-- check~!~!!! → form 구성!!!!!! -->
			<form action="" name="searchForm" method="post">
			<%
			if(searchKey.equals("name"))
			{
			%>
				<select name="searchKey" class="selectFiled">
					<option value="subject">제목</option>
					<option value="name" selected>작성자</option>
					<option value="content">내용</option>
				</select>
			<%
			}
			else if(searchKey.equals("content"))
			{
			%>
				<select name="searchKey" class="selectFiled">
					<option value="subject">제목</option>
					<option value="name">작성자</option>
					<option value="content" selected>내용</option>
				</select>
			<%
			}
			else
			{
			%>
				<select name="searchKey" class="selectFiled">
					<option value="subject">제목</option>
					<option value="name">작성자</option>
					<option value="content">내용</option>
				</select>
				
			<%
			}
			%>
				<input type="text" name="searchValue" class="textFiled" value="<%=searchValue%>">
				<input type="button" value="검색" class="btn2" onclick="sendIt()">
			</form>
		</div> <!-- close #LeftHeader -->
		
		<div id="rightHeader">
			<input type="button" value="글올리기" class="btn2" 
			onclick="javascript:location.href='<%=cp%>/Created.jsp'"/>
		</div> <!-- close #rightHeader -->
		
	</div> <!-- close #bbsList_header -->
	
	<div id="bbsList_list">
		<div id="title">
			
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
			 
			 
		</div>
		
		<div id="lists">
			<!-- 
			<dl>
				<dd class="num">1</dd>
				<dd class="subject">안녕하세요</dd>
				<dd class="name">김진희</dd>
				<dd class="created">2021-11-04</dd>
				<dd class="hitCount">0</dd>
			</dl>
			-->
			 
			<%
			for (BoardDTO dto : lists)
			{
			%>
		 	<dl>
				<dd class="num"><%=dto.getNum() %></dd>
				<dd class="subject">
					<a href="<%=articleUrl %>&num=<%=dto.getNum() %>"><%=dto.getSubject() %></a>
				</dd>
				<dd class="name"><%=dto.getName() %></dd>
				<dd class="created"><%=dto.getCreated() %></dd>
				<dd class="hitCount"><%=dto.getHitCount() %></dd>
			</dl>
			<%
			}
			%>
			 
		</div>
		
		<div id="footer">
			<!-- <p>1 Prev 21 22 23 24 25 26 27 28 29 30 Next 55</p> -->
			<!-- <p>등록된 게시물이 존재하지 않습니다.</p> -->
			<p>
			<%
			if(dataCount != 0)
			{
			%>
				<%=pageIndexList %>
			<%
			}
			else
			{
			%>
				등록된 게시물이 존재하지 않습니다.
			<%
			}
			%>
			</p>
		</div>
		
	</div> <!-- close #bbsList_list -->

</div>
</body>
</html>