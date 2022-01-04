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
<title>캠핑장 조회</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Search.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css"><!-- datepicker -->


<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>	<!-- 알럿창 꾸미는 애 -->
<script type="text/javascript">
	
	
	//jquery 시작
	$(function()
	{
		// 페이지 로딩되면 리스트(ajax) 출력
		ajaxCampgroundList();
		
		
		$("#sort").change(function()
		{
			// 객실타입 값 배열로 받음
			var typeArr = [];
			$("input[name='type']:checked").each(function() {
				var chk = $(this).val();
				typeArr.push(chk);
			});
			
			// 옵션 값 배열로 받음
			var optionArr = [];
			$("input[name='conven']:checked").each(function() {
				var chk = $(this).val();
				optionArr.push(chk);
			});
				
			$("input[name='enter']:checked").each(function() {
				var chk = $(this).val();
				optionArr.push(chk);
			});
			
			// 테마 값 배열로 받음
			var themeArr = [];
			$("input[name='themeOne']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			$("input[name='themeTwo']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			$("input[name='themeThree']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			// 배열로 받은 객실타입, 옵션, 테마 컴마로 구분해서 문자열로 담음
			var type = typeArr.join(',');
			var option = optionArr.join(',');
			var theme = themeArr.join(','); 
			
			
			// 정렬 정보
			var sortkey = $("#sort option:selected").attr("value");
			var sortvalue = $("#sort option:selected").attr("value2");
			
			
			// 타입, 옵션, 테마 선택값이 없다면 문자열에 '' 넣어줌
			if (type == null || typeof type == "undefined" || type == "")
				type = "''";
			if (option == null || typeof option == "undefined" || option == "")
				option = "''";
			if (theme == null || typeof theme == "undefined" || theme == "")
				theme = "''";
			
			
			// 검색어 받기
			var keyword = $.trim($(".mainSearch").val());
			
			
			// 검색어 가지고 ajax 호출
			ajaxCampgroundList(keyword, type, option, theme, sortkey, sortvalue);
		});
		
		
		// 검색 아이콘 누를 때 
		$(".btnSearch").click(function ()
		{
			
			// 객실타입 값 배열로 받음
			var typeArr = [];
			$("input[name='type']:checked").each(function() {
				var chk = $(this).val();
				typeArr.push(chk);
			});
			
			// 옵션 값 배열로 받음
			var optionArr = [];
			$("input[name='conven']:checked").each(function() {
				var chk = $(this).val();
				optionArr.push(chk);
			});
				
			$("input[name='enter']:checked").each(function() {
				var chk = $(this).val();
				optionArr.push(chk);
			});
			
			// 테마 값 배열로 받음
			var themeArr = [];
			$("input[name='themeOne']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			$("input[name='themeTwo']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			$("input[name='themeThree']:checked").each(function() {
				var chk = $(this).val();
				themeArr.push(chk);
			});
			
			// 배열로 받은 객실타입, 옵션, 테마 컴마로 구분해서 문자열로 담음
			var type = typeArr.join(',');
			var option = optionArr.join(',');
			var theme = themeArr.join(','); 
			
			// 정렬 정보
			var sortkey = $("#sort option:selected").attr("value");
			var sortvalue = $("#sort option:selected").attr("value2");
			
			// 타입, 옵션, 테마 선택값이 없다면 문자열에 '' 넣어줌
			if (type == null || typeof type == "undefined" || type == "")
				type = "''";
			if (option == null || typeof option == "undefined" || option == "")
				option = "''";
			if (theme == null || typeof theme == "undefined" || theme == "")
				theme = "''";
			
			
			// 검색어 받기
			var keyword = $.trim($(".mainSearch").val());
			
			// 검색어 + 체크리스트 모두 공백일 경우 알림창 발생
			if(keyword == "" && type == "''" && option == "''" && theme == "''")
			{
				//alert("검색어를 입력하거나, 체크박스를 1개 이상 선택하세요.");
				Swal.fire({
                    icon: 'warning',
                    title: '잘못된 검색입니다.',
                    text: '검색어를 입력하거나, 체크박스를 1개 이상 선택하세요.',
                });
				return;
			}
			
			// 검색어 가지고 ajax 호출
			ajaxCampgroundList(keyword, type, option, theme, sortkey, sortvalue);
			
		});
		
		// Ajax 함수
		function ajaxCampgroundList(keyword, type, option, theme, sortkey, sortvalue)
		{
			
			// 처음로드 할 때 (검색어, 타입, 옵션, 테마 다 없음)
			if (keyword == null && type == null && option == null && theme == null)
			{ 
				var keyword = "";
				var sortkey = "SIGNUPDATE";
				var sortvalue = "DESC";
				var pagenum = 1;
				var urlStr = "campgroundsearchmybatis.wei"; 
			}
			else if(keyword == "" && type == "''" && option == "''" && theme == "''")
			{ 
				var urlStr = "campgroundsearchmybatis.wei"; 
			}
			else
			{
				var urlStr = "campgroundsearchmybatischeck.wei"; 
			}
		
			
			$.ajax(
			{
				type : "POST"
				, url : urlStr
				, data : 
				{
					"keyword" : keyword
					, "type" : type
					, "option" : option
					, "theme" : theme
					, "sortkey" : sortkey
					, "sortvalue" : sortvalue
					, "pagenum" : pagenum
				}
				, dataType : "json"	
				, success : function(jsonObj)	
				{
										
					var out = "";
					
					if(jsonObj == 0)
					{
						var out = "<div><br><img src=\"img/no_search_result.png\" width=\"40%\"><br><br></div>";
						$(".groundInfo").html(out);
					}
					else
					{
						for(var idx=0; idx<jsonObj.length; idx++)	
						{
							var campgroundName = jsonObj[idx].campgroundName;
							var campgroundId = jsonObj[idx].campgroundId;
							var address1 = jsonObj[idx].address1;
							var address2 = jsonObj[idx].address2;
							var address3 = jsonObj[idx].address3;
							var firewood = jsonObj[idx].firewood;
							var roomtypelist = jsonObj[idx].roomtypelist;
							var optionlist = jsonObj[idx].optionlist;
							var themelist = jsonObj[idx].themelist;
							var pick = jsonObj[idx].pick;
							var review = jsonObj[idx].review;
							
							out += "<div class=\"groundList\">";
							out += "					<div class=\"groundInfoContainer\">";
							out += "						<div class=\"groundInfoItem\">";
							out += "							<br><img src=\"img/campingjang1.jpg\" width=\"80%\">";
							out += "						</div>";
							out += "						<div class=\"groundInfoItem\">";
							out += "							<a href=\"campickdetail.wei?campgroundId=" + campgroundId +"\"><span id='cgName'>" + campgroundName + "</span>";
							out += "							<br><span id='cgAddr'>" + address1 + " " +address2 + " " + address3 + "</span></a>";
							out += "							<br>장작점수 : " + firewood + " / 5 <br>";
							for(var i = 0; i<parseInt(firewood); i++)
							{
								out += "<span class='firewoods'><img src=\"img/colorwood.png\" width='35px'></span> ";
							}
							if(parseInt(firewood)<5)
							{
								for(var i = 0; i<(5-parseInt(firewood)); i++)
								{
									out += "<span class='firewoods'><img src=\"img/blackwood.png\" width='35px'></span> ";
								}
							}
							out += "						</div>";
							out += "						<div class=\"groundInfoItem pr\">";
							out += "							PICK　　<span class='badge badge-pill'>" + pick + "</span> <br>";
							out += "							REVIEW　<span class='badge rounded-pill'>" + review + "</span> <br>";
							out += "						</div>";
							out += "						<div class=\"groundInfoItem rot\">";
							out += "						    <br><span class='badge'>객실유형</span><br>"+roomtypelist+" <br><br><span class='badge'>옵　션</span><br>"+optionlist+"<br><br><span class='badge'>테　마</span><br>"+themelist+"";
							out += "						</div>";
							out += "						<br>";
							out += "				    </div>";
							out += "				</div>";
						}
											
						$(".groundInfo").html(out);
						
						var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
						$("#pageIndexList").html(pageIndexList);
					}
				
				}
				, errer : function(e)
				{
					alert(e.responseText);
				}
			});
		}
	});
		

</script>

</head>
<body>

<div class='mainContentContainer'>
	
	
	<div class="mainContentItem">
		
		<!-- 키워드 검색 -->
		<div id="mainSearch">
			<input type="text" class="mainSearch" placeholder="캠핑장을 검색하세요">
			<button type="submit" class="btnSearch"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
</svg></button>
		</div>

	</div>
	
	<!-- 날씨 출력 -->
	<div class="mainContentItem">
		<jsp:include page="/index.html"/>
	</div>
	
	<!-- 객실유형, 테마, 편의시설 체크박스 -->
	<div class="mainContentItem">
		<form action="" method="post">
			<span class="opTitle">&nbsp;객실 유형&nbsp;</span><br>
			<c:forEach varStatus="status" var="roomType" items="${roomType}">
				<input type="checkbox" name="type" value="${roomType.roomTypeNum}" id="type${status.count}">
				<label for="type${status.count}">${roomType.roomTypeName}&nbsp;</label>	
			</c:forEach>
			<br><br>
			
			<span class="opTitle">&nbsp;편의 시설&nbsp;</span><br>
			<c:forEach varStatus="status" var="convenience" items="${campgroundConvenience}">
				<input type="checkbox" name="conven" value="${convenience.optionNum}" id="conven${status.count}">
				<label for="conven${status.count}">${convenience.optionName}&nbsp;</label>
				<c:if test="${status.count % '6' == '0'}">
					<br>
    			</c:if>

			</c:forEach>
			<br><br>
			
			<span class="opTitle">&nbsp;즐길거리&nbsp;</span><br>
			<c:forEach varStatus="status" var="enter" items="${campgroundFun}">
				<input type="checkbox" name="enter" value="${enter.optionNum}" id="enter${status.count}">
				<label for="enter${status.count}">${enter.optionName}&nbsp;</label>
				<c:if test="${status.count % '6' == '0'}">
					<br>
    			</c:if>
			</c:forEach>
			<br><br>
		
			<span class="opTitle">&nbsp;테마 > 계절&nbsp;</span><br>		
			<c:forEach varStatus="status" var="season" items="${campgroundSeason}">
				<input type="checkbox" name="themeOne" value="${season.themeNum}" id="themeOne${status.count}">
				<label for="themeOne${status.count}">${season.themeName}&nbsp;</label>		
			</c:forEach>
			<br><br>
			
			<span class="opTitle">&nbsp;테마 > 구성원&nbsp;</span><br>
			<c:forEach varStatus="status" var="group" items="${campgroundGroupMember }">
				<input type="checkbox" name="themeTwo" value="${group.themeNum}"  id="themeTwo${status.count}">
				<label for="themeTwo${status.count}">${group.themeName}&nbsp;</label>
				<c:if test="${status.count % '4' == '0'}">
					<br>
    			</c:if>		
			</c:forEach>
			<br><br>
		
			<span class="opTitle">&nbsp;테마 > 분위기&nbsp;</span><br>
			<c:forEach varStatus="status" var="mood" items="${campgroundMood}">
				<input type="checkbox" name="themeThree" value="${mood.themeNum}" id="themeThree${status.count}">
				<label for="themeThree${status.count}">${mood.themeName}&nbsp;</label>
			</c:forEach>
			<br>
		</form>
	</div>
	

	<br>
	<!-- 정렬 옵션 -->
	<div class="mainContentItem col-md-12">
		<div class="col-md-12" style="text-align: right;">
			<select name="sort" id="sort" style="font-size: medium;">
				<option value="signupDate" value2="desc" selected="selected">신규 등록 순</option>
				<option value="firewood" value2="desc">장작 많은 순</option>
				<option value="firewood" value2="asc">장작 적은 순</option>
				<option value="review" value2="desc">리뷰 많은 순</option>
				<option value="review" value2="asc">리뷰 적은 순</option>
			</select>
		</div>
	</div>
		
					
		<div class="mainContentItem">
			<div class="groundInfo">
			<!-- 캠핑장 목록 출력 위치 -->
			</div>                  
		</div> 
		<div style="text-align: center; margin: 30px auto;" id="pageIndexList">
			<!-- 페이징 영역 -->
		</div>                                                            
	</div><!-- end container -->


</body>
</html>