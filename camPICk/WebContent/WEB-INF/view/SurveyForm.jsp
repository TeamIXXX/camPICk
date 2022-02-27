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
<title>SurveyForm</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/SurveyForm.css">

<style type="text/css">

@font-face 
{
     font-family: 'S-CoreDream-6Bold';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-6Bold.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}

.mainContainer
{
	font-family: 'S-CoreDream-6Bold';
}

#logo:hover
{
	cursor: pointer;
}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript">

	$(function()
	{
		$("#submitBtn").click(function()
		{
			// 데이터 검사(누락된 입력값이 있는지 없는지에 대한 여부 확인)
			<c:forEach var="option" items="${optionList }">
			if ($("input[name='${option.optionNum }']").is(":checked") == false)
			{
				$(".err").html("설문과 리뷰 항목을 모두 채워주세요.");
				$(".err").css("display", "inline");
				return;
			}
			</c:forEach>
						
			
			if( $("input[name='sea']:checked").length < 1
				|| $("input[name='mem']:checked").length < 1
				|| $("input[name='vib']:checked").length < 1
				|| $("input[name='firewood']").is(":checked") == false
				|| $("#reviewtxt").val() == "" 
				|| $("#reviewtxt").val() == " " )
			{
				$(".err").html("설문과 리뷰 항목을 모두 채워주세요.");
				$(".err").css("display", "inline");
				return;
			}
			
		
			var option_name_arr = [];	// option's name array
			var option_check_arr = [];	// option's chekced array
			
			var option = $(".option").find("input[type=radio]"); // .option 라디오 정보를 가져오기
			<c:forEach var="option" items="${optionList }">
				option_name_arr.push("${option.optionNum}");	// name 값만을 추출
			</c:forEach>
			
			for (var i = 0; i < option_name_arr.length; i++)
			{
				option_check_arr[i]=$('input[name="'+option_name_arr[i]+'"]:checked').val();
			}

			var option_name = option_name_arr.join(',');
			var option_check = option_check_arr.join(',');
			
			
			document.surveyForm.option_name.value = option_name;
			document.surveyForm.option_check.value = option_check;
			
			alert("리뷰 남겨주셔서 감사합니다.");
			
			$("#surveyForm").submit();
			
		});
		
		
		
	});
	

</script>

</head>
<body>


<div class="mainContainer">

	
	<div class="mainItem">
		<jsp:include page="/WEB-INF/view/TopMenu.jsp"></jsp:include>
	</div>
 
	<div class="mainItem" id="mainLogo">
		<img src="<%=cp%>/img/logo_title2.png" onclick="location.href='campick.wei'" id="logo">
	</div>
 
	<div class="mainItem">
		<jsp:include page="/WEB-INF/view/CamperSitemap.jsp"></jsp:include>		
	</div>
	
	<div class="mainItem">
		<%-- <jsp:include page="NavigationBar.jsp"></jsp:include> --%>
		<c:import url="NavigationBar.jsp"></c:import>
	</div>
	
 	<div class="mainItem">

		<div class="container-survey">
		
			<form action="surveyinsert.wei?campgroundId=${campgroundId }" method="post" id="surveyForm" name="surveyForm">
			<input type="hidden" value="${memberNum }" id="memberNum" name="memberNum">
			<input type="hidden" value="${bookingNum }" id="bookingNum" name="bookingNum">
			<input type="hidden" value="" id="option_name" name="option_name">
			<input type="hidden" value="" id="option_check" name="option_check">
			
				<div class="item-survey">
					<p>1. 캠핑장의 편의시설을 평가해주세요.</p>
					<c:forEach var="option" items="${optionList }">
						<c:if test="${option.optionTypeNum eq 11 }">
							<div class="option">
								<span class="surlist">
								${option.optionName }
								</span>
								<span class="input">
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }1" value="1">1</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }2" value="2">2</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }3" value="3">3</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }4" value="4">4</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }5" value="5">5</label>
							  	</span>						
							</div>
						</c:if>
					</c:forEach>
					
				</div>
				
			
				<div class="item-survey">
					<p>2. 캠핑장의 즐길거리를 평가해주세요.</p>
					<c:forEach var="option" items="${optionList }">
						<c:if test="${option.optionTypeNum eq 12 }">
							<div class="option">
								<span class="surlist">
								${option.optionName }
								</span>
								<span class="input">                                                              
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }1" value="1">1</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }2" value="2">2</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }3" value="3">3</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }4" value="4">4</label>
							    	<label><input type="radio" name="${option.optionNum }" id="${option.optionNum }5" value="5">5</label>
							  	</span>
							</div>
						</c:if>
					</c:forEach>
					
				</div>	
				
				
				<div class="item-survey">
					<p>3. 캠핑장과 어울리는 테마를 골라주세요.</p>
					<div class="theme">
						<div class="season">
							<div class="surlist">계절</div>
							<div class="input">
								<label>
						    	<input type="radio" name="sea" value="1" id="sea1">봄
						    	</label>
						    	<label>
						    	<input type="radio" name="sea" value="2" id="sea2">여름
						    	</label>
						    	<label>
						    	<input type="radio" name="sea" value="3" id="sea3">가을
						    	</label>
						    	<label>
						    	<input type="radio" name="sea" value="4" id="sea4">겨울
						    	</label>
							</div>
						</div><br>
						
						<div class="member">
							<div class="surlist">어울리는 구성원</div>
							<div class="input">
						    	<label>
						    	<input type="radio" name="mem" value="5" id="mem1">혼자 힐링하러
						    	</label>
						    	<label>
						    	<input type="radio" name="mem" value="6" id="mem2">연인과 사랑하러
						    	</label>
						    	<label>
						    	<input type="radio" name="mem" value="7" id="mem3">가족과 행복하러
						    	</label><br>
						    	<label>
						    	<input type="radio" name="mem" value="8" id="mem4">친구와 우정을 다지러
						    	</label>
						    	<label>
						    	<input type="radio" name="mem" value="9" id="mem5">반려동물과 추억을 쌓으러
						    	</label>
							</div>
						</div><br>
						
						<div class="vibe">
							<div class="surlist">분위기</div>
							<div class="input">
						    	<label>
						    	<input type="radio" name="vib" value="10" id="vib1">차분하다
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="11" id="vib2">에너제틱
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="12" id="vib3">레트로
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="13" id="vib4">신식
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="14" id="vib5">포근함
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="15" id="vib6">프라이빗
						    	</label>
						    	<label>
						    	<input type="radio" name="vib" value="16" id="vib7">로맨틱
						    	</label>
							</div>
						</div>
						
						
					</div>
					
				</div>
				
				
				<div class="item-survey">
					<p>4. 캠핑장에 장작을 태워주세요.</p>
					<div class="fire-wood">
					<span class="star-input">
						<span class="star-input">
					    	<label for="p1"><input type="radio" name="firewood" value="1" id="p1">
					    	1</label>
					    	<label for="p2"><input type="radio" name="firewood" value="2" id="p2">
					    	2</label>
					    	<label for="p3"><input type="radio" name="firewood" value="3" id="p3">
					    	3</label>
					    	<label for="p4"><input type="radio" name="firewood" value="4" id="p4">
					    	4</label>
					    	<label for="p5"><input type="radio" name="firewood" value="5" id="p5">
					    	5</label>
					  	</span>
					</span>
						
					</div>
				</div>
				
				
				<div class="item-survey">
					<div class="end">
					
						<textarea rows="7px" cols="70px" name="textreview" id="textreview" class="textreview" maxlength="100"
						placeholder="100자 이내로 작성가능합니다."></textarea>
						<br>
						<button type="button" class="btn1" id="submitBtn">등록</button>
						<button type="button" class="btn1" onclick="location.href='campick.wei'">취소</button><br>
						<!-- onclick="javascript:window.open('about:blank', '_self').close();" 크롬에서는 안됨 -->
						<span class="err" style="color: red; font-weight: bold; display: none;"></span>
					</div>
				</div>
				
			</form>
			
		</div>

	</div>

</div>
<%-- 
<footer>
	<c:import url="Footer.jsp"></c:import>
</footer>
 --%>
</body>
</html>