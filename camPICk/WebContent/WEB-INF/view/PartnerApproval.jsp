<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PartnerApproval</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/PartnerApproval.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>


<script type="text/javascript">
	function test(a)
	{
		var blId = "bl"+a;
		var piId = "pi"+a;
		var bl = document.getElementById(blId).value;
		var pi = document.getElementById(piId).value;
		location.href = "partnerapprovaldmodal.wei?bl="+bl+"&pi="+pi;
	}
</script>
</head>
<body>


<%-- <%=cp %> --%>

<div class="topContainer">
	<div></div>
	<jsp:include page="AdminTopMenu.jsp"></jsp:include>
</div>

<div id="bbsList">
	<br><br>
	<a href="partnerapproval.wei"><button type="button" class="btn btn-success">승인대기</button></a>
	<a href="partnerapproved.wei"><button type="button" class="btn btn-success">승인완료</button></a>
	<a href="partnernotapproved.wei"><button type="button" class="btn btn-success">승인반려</button></a>
	<hr>
	<div id="bbsList_title1">
		 <span class="badge badge-title">승인 대기 파트너</span>
	</div>
	
	<div id="bbsList_list">
		<div id="title">
			
			<dl>
				<dt class="item1">번호</dt>
				<dt class="item2">아이디</dt>
				<dt class="item3">이름</dt>
				<dt class="item4">휴대폰번호</dt>
				<dt class="item5">사업자번호</dt>
				<dt class="item6">신청일자</dt>
			</dl>
		</div>
		
		<div id="lists">
			<dl>
				<c:forEach var="list" items="${lists}" varStatus="status">
					<c:if test="${list.approvalStatusNum eq '0'}">
						<dd class="item1">${list.approvalNum}</dd>
						<dd class="item2"><input type="hidden" id="pi${status.count }" value="${list.partnerId}">${list.partnerId}</dd>
						<dd class="item3">${list.partnerName}</dd>
						<dd class="item4">${list.partnerPhone}</dd>
						<dd class="item5" ><input type="hidden" id="bl${status.count }" value="${list.businesslicense}">${list.businesslicense}</dd>
						<dd class="item6">${list.approvalDate}</dd>
						<dd class="item7">
							<%-- <a href="partnerapprovalmodal.wei" class="fileButton" id="fileButton">
							<span class="badge badge-file" id="${status.count }">파일</span></a> --%>
							<span class="badge badge-file" id="${status.count }" onclick="test(this.id)">파일</span>
						</dd>
						<br>
					</c:if>
				</c:forEach>
			</dl>
		</div>
		
		<div id="footer">
			<%-- ${pageIndexList } --%>
			<%-- <!-- <p>1 Prev 21 22 23 24 25 26 27 28 29 30 Next 55</p> -->
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
			</p> --%>
		</div>
		
	</div> <!-- close #bbsList_list -->

</div>
</body>
</html>