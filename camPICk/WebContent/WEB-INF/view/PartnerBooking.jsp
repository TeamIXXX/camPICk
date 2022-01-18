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
<title>PartnerBooking.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js"></script>
<!-- <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="https://unpkg.com/tippy.js@6"></script> -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css">

<script type="text/javascript">
	
	$(function()
	{
		var jDate = new Date();   

		var jToday = jDate.getFullYear() +"-" + jDate.getMonth() + 1 + "-" + jDate.getDate(); 

		
		var weekList = ['일','월','화','수','목','금','토'];
	    var calendarEl = document.getElementById('calendar');
	    
	    var calendar = new FullCalendar.Calendar(calendarEl
	    	, {
	    		initialView: 'dayGridMonth'
				, headerToolbar: 
				{
					left: 'prevYear,prev today next,nextYear'
					, center: 'title'
					/* , right: 'dayGridMonth,dayGridDay' */ 
					, right: 'dayGridMonth,listMonth'
				}
				, titleFormat : function(date) 
				{ 
					return date.date.year + "년 " + (date.date.month +1) + "월"; 
		    	}  
				, dayHeaderContent: function (date) 
				{
					return weekList[date.dow];
				}
	    	/* , eventLimit: true */

		    	, eventClick: function(info) 
		    	{
		    		//alert('Event: ' + info.event.id); // 상세 정보 띄우는...모달이나 뭐로 연결
		    		$('#bookingModal').modal('show');
		    		ajaxBookingDetailModal(info.event.id);
		    		
				} 
	 			, events : function(info, successCallback, failureCallback) 
 				{
					$.ajax(
					{
						type : "GET"
						, url : "ajaxpartnerbookinglist.wei"
	 					, dataType : "json"
	 					, success : function(obj) {
	 						successCallback(obj);
					}
	 					,error : function(e)
		 				{
		 					alert(e.responseText);
		 				}
					});	// end ajax()
				}// end events
				, dateClick: function(info)
				{
					var dateStr = info.dateStr
					$.ajax(
					{
						type : "GET"
						, url : "ajaxpartnerdailybookinglist.wei"
						, data : "date=" + info.dateStr  
	 					, dataType : "json"
	 					, success : function(obj) 
	 					{
	 						$(".selectDate").html(info.dateStr);
	 						$(".ptBookingDetail").html("예약 없음");
	 						$(".ptBookingBtn").html("<button onclick='ptBookingStop(this)' value='" + dateStr + "'>예약 마감</button>");

	 						for(var idx=0; idx<obj.length; idx++)
	 						{
	 							var bookingNum = obj[idx].bookingNum;
	 							var roomId = obj[idx].roomId;
	 							var roomName = obj[idx].roomName;
	 							var name = obj[idx].name;
	 							var phone = obj[idx].phone;
	 							var visitNum = obj[idx].visitNum;	 						
		 						
	 							$("#"+ roomId + ".ptBookingDetail").html( name + " / " + phone + " / " + visitNum + "명");
	 							$("#"+ roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' onclick='ptBookingCancel(this)'>취소</button>");
	 						}
	 						
						}
	 					,error : function(e)
		 				{
	 						$(".selectDate").html(info.dateStr);
	 						$(".ptBookingDetail").html("예약 없음");
	 						$(".ptBookingBtn").html("<button onclick='ptBookingStop(this)' value='" + dateStr + "'>예약 마감</button>");
		 				}
					}); // end ajax()
				} // end dateClick
				
			}); // end calendar

		calendar.render();
			
		// 예약현황 표에 오늘 예약 내역이 뜨도록 
		ajaxToday(jToday);
		
	});

	
	// 예약 페이지 뜨자마다 오늘 날짜 예약 내역이 표에 입력되는 에이젝스 
	function ajaxToday(today)
	{
		$.ajax(
		{
			type : "GET"
			, url : "ajaxpartnerdailybookinglist.wei"
			, data : "date=" + today 
			, dataType : "json"
			, success : function(obj) 
			{
				$(".selectDate").html(today);
				$(".ptBookingDetail").html("예약 없음");
				$(".ptBookingBtn").html("<button onclick='ptBookingStop(this)' value='" + today + "'>예약 마감</button>");

				
				for(var idx=0; idx<obj.length; idx++)
				{
					var bookingNum = obj[idx].bookingNum;
					var roomId = obj[idx].roomId;
					var roomName = obj[idx].roomName;
					var name = obj[idx].name;
					var phone = obj[idx].phone;
					var visitNum = obj[idx].visitNum;
					
					$("#" + roomId + ".ptBookingDetail").html( name + " / " + phone + " / " + visitNum + "명" );
					$("#" + roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' onclick='ptBookingCancel(this)'>취소</button>");
				}
				
			}
			,error : function(e)
			{
				$(".selectDate").html(today);
				$(".ptBookingDetail").html("예약 없음");
				$(".ptBookingBtn").html("<button onclick='ptBookingStop(this)' value='" + today + "'>예약 마감</button>");
			}
		});
		
	}
	
	// 달력에서 이벤트 클릭시 예약 상세 모달 띄우기
	function showBookingDetail(obj)
	{
		$('#bookingModal').modal('show');
		
		// Ajax 처리
		ajaxBookingDetailModal(obj.id)
	}	
		
	
	// 예약 상세 모달띄우기 
	function ajaxBookingDetailModal(bookingNum)
	{
		//alert("함수 호출");
		var bookingNum = bookingNum;
				
		$.ajax(
		{
			type : "POST"
			, url : "ajaxbookingdetailmodal.wei"
			, data : "bookingNum=" + bookingNum
			, dataType : "json"
			, success : function(jsonObj)
			{
				var roomName = jsonObj.roomName;
				var checkInDate = jsonObj.checkInDate;
				var checkOutDate = jsonObj.checkOutDate;
				var campgroundId = jsonObj.campgroundId;
				var campgroundName = jsonObj.campgroundName;
				var name= jsonObj.name;
				var phone = jsonObj.phone;
				var visitNum = jsonObj.visitNum;
				var paymentAmount = jsonObj.paymentAmount;
				var request = jsonObj.request;
				var bookingDate = jsonObj.bookingDate;
				
				$('.bookingDetailRoomName').text(roomName);
				$('.bookingDetailCheckInDate').text(checkInDate);
				$('.bookingDetailCheckOutDate').text(checkOutDate);
				$('.bookingDetailBookingNum').text(bookingNum);
				$('.bookingDetailBookingDate').text(bookingDate);
				$('.bookingDetailName').text(name);
				$('.bookingDetailPhone').text(phone);
				$('.bookingDetailPaymentDate').text(bookingDate);
				$('.bookingDetailPaymentAmount').text(parseInt(paymentAmount).toLocaleString('ko-KR'));
				$('.bookingDetailVisitNum').text(visitNum);
				$('.bookingDetailRequest').text(request);
				
			}
			,error : function(e)
			{
				alert("상세 예약내역을 불러올 수 없습니다.");
			}
			
		});		
		
	}
	
	// 파트너 예약 취소
	function ptBookingCancel(obj)
	{			
		//alert(obj.id);
		//$(location).attr("href", "ptBookingCancel.wei?campgroundId="+ obj.id);
	}	
	
	function ptBookingStop(obj)
	{		
		//alert(obj.parentElement.id + " / " + obj.value);
		//$(location).attr("href", "ptBookingStop.wei?roomId="+ obj.parentElement.id +"&checkInDate"+ obj.value );
	}	
	
	
</script>
<style type="text/css">

	* { font-size: medium;}
	a { color: black; }
	.fc-day-sun a { color: red; } 
	.fc-day-sat a { color: blue; }
	
	.partnerBookingItem { padding: 50pt; width:800px;}
	.partnerBookingContainer
	{
		display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	
	table { text-align: center; }
	th { text-align: center; font-size: 14pt; }
	.ptBookingRoomName { color: #45818E; }
	.selectDate { font-size: 14pt; }
	
	.ptBookingBtn > button 
	{
		font-size: small;
		border: none;
		border-radius: 40px;
		padding: 5px;
		width: 100px;
		background-color: #FFD032;
	}
	
	.ptBookingBtn > button:hover { background-color: #c4c4c4; }

	.bookingDetailSubTitle
	{
    	color: #45818E;
		display: inline-block;
		width: 150px;
		text-align: right;
		padding: 3px 2px;
	}
	
	.roomName {	font-size: 20px; }

</style>

</head>
<body>

<div class="partnerBookingContainer">

	<div class="partnerBookingItem" style="height: 400px; background-color: gray;" > 차트 영역
	</div>
	
	<div class="partnerBookingItem" id='calendar'>
	</div>
	
	<div class="partnerBookingItem bookingDaily">
		<table class="table table-hover table-bordered">
			<tr>
				<th style="width: 200px">객실 이름</th>
				<th>예약 현황 (<span class="selectDate"></span>)</th>
				<th style="width: 100px">관리</th>
			</tr>
			
			<c:forEach var="room" items="${roomList}">
			<tr>
				<td id="${room.roomId}" class="ptBookingRoomName">${room.roomName}</td>
				<td id="${room.roomId}" class="ptBookingDetail"></td>
				<td id="${room.roomId}" class="ptBookingBtn"></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>



<div class="modal fade" id="bookingModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<span class="modal-title" id="myModalLabel">
					<span class="bookingDetailRoomName roomName">객실 이름</span>
					( 체크인 : <span class="bookingDetailCheckInDate"></span> / 체크아웃 : <span class="bookingDetailCheckOutDate"></span> )
				</span>
			</div>
			<div class="modal-body" style="font-size: medium;">
				<span class="bookingDetailSubTitle">예약 번호</span> : <span class="bookingDetailBookingNum"></span><br>
				<span class="bookingDetailSubTitle">예약일</span> : <span class="bookingDetailBookingDate"></span><br> 
				<span class="bookingDetailSubTitle">예약자</span> : <span class="bookingDetailName"></span><br>
				<span class="bookingDetailSubTitle">연락처</span> : <span class="bookingDetailPhone"></span><br> 
				<span class="bookingDetailSubTitle">결제일</span> : <span class="bookingDetailPaymentDate"></span><br> 
				<span class="bookingDetailSubTitle">결제 금액</span> : <span class="bookingDetailPaymentAmount"></span>원<br>
				<span class="bookingDetailSubTitle">예약 인원</span> : <span class="bookingDetailVisitNum"></span><br>
				<span class="bookingDetailSubTitle">예약 시 요청사항</span> : <span class="bookingDetailRequest"></span><br>
			</div>
		</div>
	</div>
</div>




</body>
</html>