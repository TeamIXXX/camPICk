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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Sign.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

*
{
	font-family: 'S-CoreDream-6Bold';
}

#logo:hover
{
	cursor: pointer;
}

</style>

<script type="text/javascript">
	$(function()
	{
		// 라디오버튼에 따른 회원가입 폼
		$("#pDiv").css("display", "none");
		$("input[name=campa]").on("click", function()
		{
			var radioV = $("input[name=campa]:checked").val();
			
			if (radioV == "camper")
			{
				$("#cDiv").css("display", "block");
				$("#pDiv").css("display", "none");
			}
			else if (radioV == "partner")
			{
				$("#cDiv").css("display", "none");
				$("#pDiv").css("display", "block");
			}
		});
		
	});
		
</script>

</head>
<body>

<div class="item" style="text-align: center; margin: 30px auto; width: 1080px;">
	<img src="img/logo.png" width="13%;" onclick="location.href='campick.wei'" id="logo"/>
</div>

<div class="itemSel">
	<div class="sel">
		<label for="camper">
			<input type="radio" name="campa" id="camper" value="camper" checked="checked"/> 개인회원
		</label> 
	</div>
	<div class="sel">
		<label for="partner">
			<input type="radio" name="campa" id="partner" value="partner"/> 파트너회원
		</label>
	</div>
</div>

<hr style="width: 800px; border: 0; border-top: 3px solid #eee;">
<!-- 캠퍼 회원가입 -->
<div id="cDiv">
	 <c:import url="/signupCamperForm.wei"></c:import>
</div>


<!-- 파트너 회원가입 -->
<div id="pDiv">
	<c:import url="/signupPartnerForm.wei"></c:import>
</div>



</body>
</html>