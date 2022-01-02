<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();	
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/BookingList.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	
	var num = <%=num%>;

	$(function()
	{
		
		$("#bookingListLi").addClass("active");
		ajaxBookingList(num);
		
		
		// 탭 클릭시 탭 전환되는 css 처리, 예약 리스트 요청
		$("#bookingListLi > a").on("click", function()
		{
			$("#pickCampgroundLi").removeClass("active");
			$("#bookingListLi").addClass("active");
			$(".bookingList").css("display", "inline");
			ajaxBookingList(num);
		});
		
		// 탭 클릭시 탭 전환되는 css 처리, 예약 리스트 요청
		$("#pickCampgroundLi > a").on("click", function()
		{
			$("#bookingListLi").removeClass("active");
			$("#pickCampgroundLi").addClass("active");
			$(".bookingList").css("display", "none");
			// ㄴ 픽한 캠핑장 목록으로 변경
		});
	
		// 이용 상태 따라 캠핑장 리스트 변경
		$("#status").change(function()
		{
			ajaxBookingList(num);
		});
		
		// 캠핑장 설명 영역을 누르면 예약 상세정보 모달 
		$(".bookingInfoModal").on("click", function() //div
		{
			$('#bookingModal').modal('show');
		});
		
		/* 
		// 예약 취소 버튼 클릭 시 예약 취소 폼
		$(".bookingCancelBtn").click(function() 
		{
			$(this).val();
			alert("5");
			//$(location).attr("href", "bookingcancelform.wei?bookingNum=" + $(this).val() );
		});
		
		// 리뷰  
		$(".reviewBtn").on("click", function() 
		{
			// 리뷰 작성이랑 연결
			//$(location).attr("href", "bookingcancelform.wei");
		});
		*/
		
	});

	
	function ajaxBookingList(camperNum)
	{
		//debugger;
		var out = "";
					
		$.ajax(
		{
			type : "POST"
			, url : "ajaxbookinglist.wei"
			, data : "camperNum=" + camperNum + "&status=" + $("#status option:selected").attr("value")
			, dataType : "json"
			, success : function(jsonObj)
			{
				 
				for(var idx=0; idx<jsonObj.length; idx++)
				{
					var campgroundName = jsonObj[idx].campgroundName;
					var campgroundId = jsonObj[idx].campgroundId;
					var bookingDate = jsonObj[idx].bookingDate;
					var checkInDate = jsonObj[idx].checkInDate;
					var checkOutDate = jsonObj[idx].checkOutDate;
					var bookingNum = jsonObj[idx].bookingNum;
					var status = jsonObj[idx].status;

					
					out += "<div class='container_bookinglist'>";
					out += "	<div class='item_bookinglist'>";
					out += "		<img src='img/logo.png' class='image-room'>";
					out += "	</div>";
					out += "	<div class='item_bookinglist bookingInfoModal'>";
					out += "      <a class='bookingCPground'><p class='campName'> " + campgroundName + "</p></a><br>";
					out += "      <span class='campDate'>결제 일 : " + bookingDate + "<br>";
					out += "      예약 일 : " + checkInDate + " ~ " + checkOutDate + "</span><br>";
					out += "   </div>";
					out += "   <div class='item_bookinglist'><br><span class='campStatus'>" + status + "</span><br> <br>";
					
					
					if( status == '이용 완료')						
						out += "	<button type='button' class='reviewBtn'"
							+ "onclick='location.href=\"surveycheck.wei?campgroundId=" + campgroundId + "&bookingNum=" + bookingNum + "\"'>리뷰 보기</button>";
					else if ( status == '예약 확정')					
						out += "	<button type='button' class='bookingCancelBtn' onclick='location.href=\"bookingcancelform.wei?bookingNum=" + bookingNum + "\"'>예약 취소</button>";
						
					out += "	</div>";
					out += "</div>";
				}	
				
				$("#listDiv").html(out);
				
			}
			
			,error : function(e)
			{
				out = "예약 내역이 없습니다.";
				//alert(e.responseText);
				$("#listDiv").html(out);
			}
			
		}); 
	}
		
		
		
 
</script>
<style type="text/css">

	.nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus 
	{
    	color: #fff;
    	background-color: #45818e;
	}
</style>
</head>
<body>


<ul class="nav nav-pills">
  <li role="presentation" id="bookingListLi" class="campTab"><a>이용 내역</a></li>
  <li role="presentation" id="pickCampgroundLi" class="campTab"><a>PICk 캠핑장</a></li>
</ul>

<div class="bookingList">
	<div class="col-12">
		<div class="col-12" style="font-size: large;">
			<select name="status" id="status" class="selectpicker">
				<option value="전체" selected="selected">-전체-</option>
				<option value="예약 확정">예약 확정</option>
				<option value="이용 완료">이용 완료</option>
				<option value="예약 취소">예약 취소</option>
			</select>
		</div>
	</div>

	<div id="listDiv">
		
	</div>
</div>

<!-- 
<div class='container_roomlist' id="roomId">
	<div class='item_roomlist'>
		<img src='img/logo.png' class='image-room'>
	</div>
	<div class='item_roomlist'>
		<span class='roomname'>  roomname </span><br>
		 기준 인원 basicnum 명 / 최대 인원 maxnum 명<br> 
		 가격 정보 평일 1박 기준 payment 원<br>
		 주말 1박 기준 weekendprice 원<br>
	</div>
	<div class='item_roomlist'>
		<button type='button' class='reserveBtn' id='reservation_btn' onclick="">예약</button>
	</div>
</div>
-->
 	<!-- <div class="col-12">
		<div class="col-12" style="font-size: large;">
			<select name="status" id="status" style="font-size: small;">
				<option value="전체" selected="selected">-전체-</option>
				<option value="예약 확정">예약 확정</option>
				<option value="이용 완료">이용 완료</option>
				<option value="예약 취소">예약 취소</option>
			</select>
		</div>
	</div>

	<div id="listDiv">
		 
	</div>
	 -->

	<div class="modal fade" id="bookingModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<form action="">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">
							<a href="www.naver.com">해오름캠핑장</a>
						</h4>
					</div>
					<div class="modal-body">
						${bookingNum.name }으로 가져오기
						예약번호 : <br> 예약 날짜 : <br> 예약 객실이름 : <br> 예약자 : <br>
						연락처: <br> 결제일 : <br> 결제 금액 :<span> 55,000</span>원<br>
						인원 수 : <br> 예약 시 요청사항 : 그늘자리 부탁드려요 <br>
					</div>
				</div>
			</form>
		</div>
	</div>
	
 
	
</body>
</html>