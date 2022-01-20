<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<%@ page isELIgnored="false" %>
<meta charset="UTF-8">
<title>아이디 찾기 결과 템플릿</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/IdFindForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

</script>

</head>
<body>

<div class="mainContainer">
	
	<div class="mainItem">
		<jsp:include page="TopMenu.jsp"></jsp:include>
	</div>
 
	<div class="mainItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title2.png" onclick="location.href='campick.wei'" id="logo">
	</div>
 
	<div class="mainItem">
		<jsp:include page="CamperSitemap.jsp"></jsp:include>		
	</div>
 
	<div class="mainItem">
		<c:import url="NavigationBar.jsp"></c:import>
	</div>
	 
	<div class="mainItem" style="background-color: none; height: 70vh;">

		<div class="id_find">
			<h1>아이디찾기</h1>
			<c:choose>
				<c:when test="${empty id }">
					<h2>가입 정보를 찾을 수 없습니다.</h2>
					
					<fieldset class="idField">
						<legend class="leg">아이디찾기</legend>
						
						<ul class="id_btn">
							<li class="button" style="border-bottom: 0px solid;">
								<button type="button" class="login_btn" 
								onclick="location.href='loginform.wei'">로그인</button>
							</li>
						</ul>
						<ul class="id_btn">
							<li class="button" style="border-bottom: 0px solid;">
								<button type="button" class="sign_btn" 
								onclick="location.href='signupForm.wei'">회원가입</button>
							</li>
						</ul>
					</fieldset>
				</c:when>
				
				<c:otherwise>
					<h2>
					아이디 찾기가 완료되었습니다.<br>
					전체 아이디는 고객센터로 문의해 주세요.
					</h2>
				
					<fieldset class="idField">
						<legend class="leg">아이디찾기</legend>
						<ul>
							<li class="li_id">
								<strong>아이디</strong>
								
								<c:if test="${id ne null && id !='' }">
								
									<c:forEach begin="1" end="2" step="1">
									*
									</c:forEach>
									
									${fn:substring(id,2,5) }
								</c:if>
								
								<c:forEach begin="${fn:length(id)-1}" end="${fn:length(id)}" step="1">
									*
								</c:forEach>
							</li>
						</ul>
						
						<ul class="id_btn">
							<li class="button">
								<button type="button" class="login_btn" 
								onclick="location.href='loginform.wei'">로그인</button>
							</li>
						</ul>
						
						<ul class="id_btn">
							<li class="button">
								<button type="button" class="sign_btn" 
								onclick="location.href='idFindForm.wei'">비밀번호 찾기</button>
							</li>
						</ul>
					</fieldset>
				</c:otherwise>
			</c:choose>
		</div>
		
	</div>
	
</div>

<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>

</body>
</html>