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
<title>Sign.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/SignCamper.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/js/signupFormCamper.js"></script>

</head>
<body>

<!-- 아이디 중복검사 여부 확인 -->
<input type="hidden" id="checked_id" value="">

<!-- 캠퍼 회원가입 -->
	<form class="containerC" id="cFrm" action="camperInsert.wei">
		
	<!-- 이메일 주소 -->
	<input type="hidden" id="email" name="email" value="">
	
		<div class="itemC">아이디<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="camperId" name="camperId" maxlength="14" placeholder="영문, 숫자 8~14자 이내">
			<button type="button" id="duplBtn">중복확인</button>
			<br><span class="errMsg" id="duplMsg"></span>
		</div>
		
		<div class="itemC">비밀번호<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="password" id="camperPw" name="camperPw" maxlength="14" placeholder="영문, 숫자 5~14자 이내">
			<br><span class="errMsg" id="pwMsg"></span>
		</div>
		
		<div class="itemC">비밀번호 확인<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="password" name="pw2" id="pw2" maxlength="14">
			<br><span class="errMsg" id="pw2Msg"></span>
		</div>
		
		<div class="itemC">이름<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="camperName" name="camperName" maxlength="6" placeholder="한글만 입력 가능">
			<br><span class="errMsg" id="nameMsg"></span>
		</div>
		
		<div class="itemC">휴대폰번호<span class="nec">(*)</span></div>
		<div class="itemC">
			<input type="text" id="phone" name="phone"  placeholder="숫자만 입력">
			<button type="button" id="cerNum">인증번호 발송</button>
			<br><span class="errMsg" id="chkphoneMsg"></span>
		</div>
		<div class="itemC"></div>
		<div class="itemC">
			<input type="text" id="recerNum">
			<button type="button" id="chkCerNum" disabled="disabled">인증번호 확인</button>
			<br><span class="errMsg" id="chkCerMsg"></span>
		</div>
		
		<div class="itemC">이메일<span style="font-size: small;">[선택]</span></div>
		<div class="itemC">
			<input type="text" name="email1" id="email1"> @ <input type="text" name="email2" id="email2">
			<select name="selectEmail" id="selectEmail">
				<option value="1">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
			</select>
		</div>
		
		<div class="itemC">이용약관 및 개인정보 동의 <span class="nec">(*)</span></div>
		<div class="itemC">
		
			<div class="iC">
				<label><input type="checkbox" id="allChkC"> 모든 필수 약관에 동의합니다.</label>
			</div>
		
			<div class="iC">
			<textarea readonly="readonly" class="fregister" >
이용약관
				</textarea>
				<br><label><input type="checkbox" name="chkC"> 이용약관에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
			
			<div class="iC">
				<textarea readonly="readonly" class="fregister">
개인정보 이용 동의
				</textarea>
				<br><label><input type="checkbox" name="chkC"> 개인정보 수집 및 이용에 동의합니다.<span class="nec">(필수)</span></label>
			</div>
		</div>
		
		<div class="itemC">
			<div class="sel">
				<button type="button" id="sign" class="sign">회원가입</button>
			</div>
			<div class="sel">
				<button type="button" class="cancel" onclick="location.href='campick.wei'">취소</button>
			</div>
		</div>
	</form>

</body>
</html>
