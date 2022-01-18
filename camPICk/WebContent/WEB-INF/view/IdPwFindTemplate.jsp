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
<title>아이디 찾기 템플릿</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/IdFindForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainTemplate.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/IdPwFind.js"></script>

<style type="text/css">

#logo:hover
{
	cursor: pointer;
}

</style>

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
	 
	<div class="mainItem" style="background-color: none;">

		<div class="id_find">
			<h1>아이디 찾기</h1>
			<h2>
			이메일 또는 휴대전화번호로 아이디 찾기가 가능합니다.<br>
			찾기가 어려우시면 고객문의에 글을 남겨주세요.
			</h2>
			
			<ul style="padding: 0 0 0 10px;">
				<li class="li_idsel" style="border-bottom: 0px solid;">
					<label>
						<input type="radio" name="find_id" value="camper" checked="checked">
						캠퍼회원
					</label>
	                         &nbsp;
					<label>
						<input type="radio" name="find_id" value="partner">
						파트너회원
					</label>
				</li>
			</ul>
			
			<!-- 캠퍼 -->
			<div class="camper">
			<form action="findCId.wei" id="idCFrm" method="post">
				<fieldset class="idCField">
					<legend class="leg">아이디찾기</legend>
					<ul>
						<li class="li_name">
							<strong>이름</strong>
							<input type="text" id="camperName" name="camperName" maxlength="6">
						</li>
						<li class="li_phone">
							<strong>휴대폰번호</strong>
							<input type="text" id="camperPhone" name="camperPhone" class="camperPhone" maxlength="13">
							<button type="button" id="cerIdCNum" class="cerNum">인증번호 받기</button>
						</li>
						<li class="li_num">
							<strong>인증번호</strong>
							<input type="text" id="reIdCNum" name="reIdCNum">
							<button type="button" id="chkIdCNum" class="cerNum">인증번호 확인</button>
						</li>
					</ul>
						
					<ul class="id_btn">
						<li class="" style="border-bottom: 0px solid;">
							<button type="button" id="id_cBtn" class="cBtn">아이디 찾기</button>
						</li>
					</ul>
				</fieldset>
			</form>
			</div>
			
			<!-- 파트너 -->
			<div class="partner">
			<form action="findPId.wei" id="idPFrm" method="post">
				<fieldset class="idPField">
					<legend class="leg">아이디찾기</legend>
					<ul>
						<li class="li_name">
							<strong>이름</strong>
							<input type="text" id="partnerName" name="partnerName" maxlength="6">
						</li>
						<li class="li_phone">
							<strong>휴대폰번호</strong>
							<input type="text" id="partnerPhone" name="partnerPhone" class="partnerPhone" maxlength="13">
							<button type="button" id="cerIdPNum" class="cerNum">인증번호 받기</button>
						</li>
						<li class="li_num">
							<strong>인증번호</strong>
							<input type="text" id="reIdPNum" name="reIdPNum">
							<button type="button" id="chkIdPNum" class="cerNum">인증번호 확인</button>
						</li>
					</ul>
						
					<ul class="id_btn">
						<li class="" style="border-bottom: 0px solid;">
							<button type="button" id="id_pBtn" class="pBtn">아이디 찾기</button>
						</li>
					</ul>
				</fieldset>
			</form>
			</div>
		</div>
		
		
		<!-- 비밀번호 찾기 -->
		<div class="pw_find">
			<h1 style="margin-bottom: 40px;">비밀번호 찾기</h1>
			
			<ul style="padding: 0 0 0 10px;">
				<li class="li_idsel" style="border-bottom: 0px solid;">
					<label>
						<input type="radio" name="pw_find" value="camper" checked="checked">
						캠퍼회원
					</label>
	                         &nbsp;
					<label>
						<input type="radio" name="pw_find" value="partner">
						파트너회원
					</label>
				</li>
			</ul>
			
			<!-- 캠퍼 -->
			<div class="camper">
			<form action="findCamper.wei" id="pwCFrm" method="post">
				<fieldset class="pwCField">
					<legend class="leg">비밀번호 찾기</legend>
					<ul>
						<li class="li_id">
							<strong>아이디</strong>
							<input type="text" id="camperId" name="camperId" maxlength="14">
						</li>
						<li class="li_phone">
							<strong>휴대폰번호</strong>
							<input type="text" id="camperPhone" name="camperPhone" class="camperPhone" maxlength="13">
							<button type="button" id="cerPwCNum" class="cerNum">인증번호 받기</button>
						</li>
						<li class="li_num">
							<strong>인증번호</strong>
							<input type="text" id="rePwCNum">
							<button type="button" id="chkPwCNum" class="cerNum">인증번호 확인</button>
						</li>
					</ul>
						
					<ul class="id_btn">
						<li class="" style="border-bottom: 0px solid;">
							<button type="button" id="pw_cBtn" class="cBtn">비밀번호 찾기</button>
						</li>
					</ul>
				</fieldset>
			</form>
			</div>
			
			<!-- 파트너 -->
			<div class="partner">
			<form action="findPartner.wei" id="pwPFrm" method="post">
				<fieldset class="pwPField">
					<legend class="leg">비밀번호 찾기</legend>
					<ul>
						<li class="li_id">
							<strong>아이디</strong>
							<input type="text" id="partnerId" name="partnerId" maxlength="14">
						</li>
						<li class="li_phone">
							<strong>휴대폰번호</strong>
							<input type="text" id="partnerPhone" name="partnerPhone" class="partnerPhone" maxlength="13">
							<button type="button" id="cerPwPNum" class="cerNum" name="cerPwNum">인증번호 받기</button>
						</li>
						<li class="li_num">
							<strong>인증번호</strong>
							<input type="text" id="rePwPNum" name="rePwPNum">
							<button type="button" id="chkPwPNum" class="cerNum" name="chkPwNum">인증번호 확인</button>
						</li>
					</ul>
						
					<ul class="id_btn">
						<li class="" style="border-bottom: 0px solid;">
							<button type="button" id="pw_pBtn" class="pBtn">비밀번호 찾기</button>
						</li>
					</ul>
				</fieldset>
			</form>
			</div>
			
		</div>
		
	</div>
	
</div>

<div>
  <c:import url="Footer.jsp"></c:import>
</div>

</body>
</html>