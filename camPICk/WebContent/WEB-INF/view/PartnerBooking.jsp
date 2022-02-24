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

<!-- 달력 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js"></script>


<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">

<link rel="stylesheet" type="text/css" href="css/PartnerBooking.css">

<!-- 달력 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css">

<!-- 차트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		// 차트 그리기
		ajaxPTchart();
		
		var jDate = new Date();
		const months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
		
		// 오늘 날짜 형식을 yyyy-mm-dd 형식으로 맞춤
		var jToday = jDate.getFullYear() +"-" + months[jDate.getMonth()] + "-" + (jDate.getDate() < 10 ? '0'+jDate.getDate() : jDate.getDate()); 

		// 달력 그리기
		var weekList = ['일','월','화','수','목','금','토'];
	    var calendarEl = document.getElementById('calendar');
	    
	    var calendar = new FullCalendar.Calendar(calendarEl
	    	, {
	    		initialView: 'dayGridMonth'
				, headerToolbar: 
				{
					left: 'prevYear,prev today next,nextYear'
					, center: 'title'
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
				
				// 이거 의견 묻기
				//, showNonCurrentDates : false
				
				// 달력 스크롤 없이, 이벤트 추가되면 날짜 높이 증가 
				, aspectRatio: 2
				, contentHeight: "auto"
				, fixedWeekCount : false
				
		    	, eventClick: function(info) 
		    	{
		    		$('#ptBookingDetailModal').modal('show');
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
					
					// background-color 초기화
					$(".fc-day-future").css("background-color", "white");
					$(".fc-day-past").css("background-color", "white");
					$(".fc-day-other").css("background-color", "#eee");
					$(".fc-day-today").css("background-color", "rgba(255,220,40,.15)");
					$(info.dayEl).css("background-color", "#d7ecfb");
					
					$.ajax(
					{
						type : "GET"
						, url : "ajaxpartnerdailybookinglist.wei"
						, data : "date=" + dateStr  
	 					, dataType : "json"
	 					, success : function(obj) 
	 					{
	 						$(".selectDate").html(dateStr);
	 						$(".ptBookingDetail").html("예약 없음");
	 						
	 						if(dateStr >= jToday)
	 							$(".ptBookingBtn").html("<button onclick='ptBookingStopModal(this)' class='ptStopBtn' value='" + dateStr + "'>예약 마감</button>");
	 						else
	 							$(".ptBookingBtn").html("");
	 						
	 						for(var idx=0; idx<obj.length; idx++)
	 						{
	 							var bookingNum = obj[idx].bookingNum;
	 							var roomId = obj[idx].roomId;
	 							var roomName = obj[idx].roomName;
	 							var checkInDate = obj[idx].checkInDate;
	 							var name = obj[idx].name;
	 							var phone = obj[idx].phone;
	 							var visitNum = obj[idx].visitNum;	 						
	 							
	 							// 예약 마감일 경우
	 							if(bookingNum.substring(0, 1)=='P')
 								{
 									$("#"+ roomId + ".ptBookingDetail").html("<span style='color: #c4c4c4; font-size: medium;'>" + name + "</span>");
 									
 									if( checkInDate >= jToday )
		 								$("#"+ roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' class='ptCancelBtn' onclick='ptBookingStopCancel(this)'>마감 취소</button>");
	 								else 
	 									$("#"+ roomId + ".ptBookingBtn").html("");
 								}
	 							else	// 아닐 경우
	 							{
 									$("#"+ roomId + ".ptBookingDetail").html( name + " / " + phone + " / " + visitNum + "명");
 									
	 								if( checkInDate > jToday )
		 								$("#"+ roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' class='ptCancelBtn' onclick='ptBookingCancelModal(this)'>취소</button>");
	 								else 
	 									$("#"+ roomId + ".ptBookingBtn").html("<button class='ptCancelBtn2' disabled='disabled'>취소</button>");
	 							}
	 						}
	 						
						}
	 					,error : function(e)
		 				{
	 						$(".selectDate").html(info.dateStr);
	 						$(".ptBookingDetail").html("예약 없음");
	 						
	 						if(dateStr >= jToday)
	 							$(".ptBookingBtn").html("<button onclick='ptBookingStopModal(this)' class='ptStopBtn' value='" + dateStr + "'>예약 마감</button>");
	 						else
	 							$(".ptBookingBtn").html("");	 						
		 				}
					}); // end ajax()
				} // end dateClick
				
			}); // end calendar

		calendar.render();
			
		// 예약현황 표에 오늘 예약 내역이 뜨도록 
		ajaxToday(jToday);
		
	});

	
	// 월별 예약 수 차트 그리기
	function ajaxPTchart()
	{
		$.ajax(
		{
			type : "GET"
			, url : "ajaxpartnerchart.wei"
			, dataType : "json"
			, success : function(obj) 
			{
				// 배열 수신
				var arrMonth = obj.arrMonth;
				var arr91 = obj.arr91;
				var arr92 = obj.arr92;
				var arr93 = obj.arr93;
				var arr94 = obj.arr94;
				
				// 차트 그리기
				var context = document.getElementById('partnerChart').getContext('2d');
				var myChart = new Chart(context, {
					
					type: 'bar' 
					, data:
					{
						labels: arrMonth
						, datasets: [
						{
							label: '오토 캠핑'
							, data: arr91
							//, data: ["1","1","1","1","1","1","1","1","1","1","1","1"]
							, backgroundColor: 'rgba(54, 162, 235, 0.3)'
						}
						, 
						{
							label: '글램핑'
							, data: arr92
							, backgroundColor: 'rgba(153, 102, 255, 0.3)'
						}
						, 
						{
							label: '카라반'
							, data: arr93
							, backgroundColor: 'rgba(255, 205, 86, 0.3)'
						}
						, 
						{
							label: '차박'
							, data: arr94
							, backgroundColor: 'rgba(255, 159, 64, 0.3)'
						}]
						 //
					}
					, options: 
					{
						plugins: 
						{
							title:
							{ 
								display: true
								, text: '월간 유형별 예약 수'
								, font:
								{
									family: 'S-CoreDream-6Bold'
									, size: 20
									, weight: 'bold'
									, lineHeight: 2
								}
							}
						}
						, responsive: true
						, scales: 
						{
							x: 
							{
								stacked: true,
							}
							, y: 
							{
								stacked: true
							}
						}
					}// end options
				});
					
			}
			,error : function(e)
			{
				//alert(e.responseText);
				console.log(e.responseText)
				console.log(JSON.stringify(e));
			}
		});
		
	}	
	
	
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
				$(".ptBookingBtn").html("<button onclick='ptBookingStopModal(this)' class='ptStopBtn' value='" + today + "'>예약 마감</button>");
				
				for(var idx=0; idx<obj.length; idx++)
				{
					var bookingNum = obj[idx].bookingNum;
					var roomId = obj[idx].roomId;
					var roomName = obj[idx].roomName;
					var checkInDate = obj[idx].checkInDate;
					var name = obj[idx].name;
					var phone = obj[idx].phone;
					var visitNum = obj[idx].visitNum;	 						
					
					// 예약 마감일 경우
					if(bookingNum.substring(0, 1)=='P')
					{
						$("#"+ roomId + ".ptBookingDetail").html("<span style='color: #c4c4c4; font-size: medium;'>" + name + "</span>");
						$("#"+ roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' class='ptCancelBtn' onclick='ptBookingStopCancel(this)'>마감 취소</button>");
					}
					else	// 아닐 경우
					{
						$("#"+ roomId + ".ptBookingDetail").html( name + " / " + phone + " / " + visitNum + "명");
						
						if( checkInDate > today )
							$("#"+ roomId + ".ptBookingBtn").html("<button id='" + bookingNum + "' class='ptCancelBtn' onclick='ptBookingCancelModal(this)'>취소</button>");
						else 
							$("#"+ roomId + ".ptBookingBtn").html("<button class='ptCancelBtn2' disabled='disabled'>취소</button>");
					}
					
					
				}
				
			}
			,error : function(e)
			{
				$(".selectDate").html(today);
				$(".ptBookingDetail").html("예약 없음");
				$(".ptBookingBtn").html("<button onclick='ptBookingStopModal(this)' class='ptStopBtn' value='" + today + "'>예약 마감</button>");
			}
		});
		
	}
	
	// 달력에서 이벤트 클릭시 예약 상세 모달 띄우기
	function showBookingDetail(obj)
	{
		$('#ptBookingDetailModal').modal('show');
		
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
				$('.bookingDetailPaymentAmount').html(parseInt(paymentAmount).toLocaleString('ko-KR'));
				$('.bookingDetailVisitNum').text(visitNum);
				$('.bookingDetailRequest').text(request);
				
			}
			,error : function(e)
			{
				alert("상세 예약내역을 불러올 수 없습니다.");
			}
			
		});		
		
	}
	
	// 파트너 예약 취소 모달
	function ptBookingCancelModal(obj)
	{			
		//alert(obj.id);
		$('#ptBookingCancelModal').modal('show');
		$("#err").html("");
		
		// Ajax 처리
		ajaxBookingCancelModal(obj.id);
	}
	
	// 파트너 예약 취소
	function ptBookingCancel()
	{			
		if (!$("input:checked[id='box']").is(":checked"))
		{
			$("#err").html("체크박스를 선택 해주세요");
			$("#err").css("display", "inline");
			$("#box").focus();
			return;
		}
		
		// 금액 계산할 때와 똑같이 err 메세지 출력
		if (parseInt($("#refund").val()) > 100
				|| parseInt($("#refund").val()) < 0)
		{
			$("#err").html("환불% 는 0 ~ 100 사이만 입력 가능합니다.");			
			return;
		}
		
		//var modalBookingNum = $("#bookingNum").val();
		//var modalRefund = $("#refund").val();
		$("#ptBookingCancelForm").submit();
	}	

	
	// 예약 마감
	function ptBookingStopModal(obj)
	{		
		var roomId = $(obj).parent().attr("id");
		var roomName = $(obj).parent().attr("name");
		var checkInDate = obj.value;
		
		// 마감 시작 날짜 넣기부터 
		$("#bookingStopCheckInDate").attr("value", checkInDate);
		$("#bookingStopRoomId").attr("value", roomId);
		$(".bookingStopRoomName").html(roomName);
		
		// 마감 가능 유효성검사 초기화 
		document.getElementById("bookingStopCheckOutDate").value = "";
		document.getElementById("bookingStopCheckOutDate").min = checkInDate;
		$(".bookingStopErr").html("");
		
		$('#ptBookingStopModal').modal('show');
		
		// checkOutDate 선택 시 유효성 검사
		$("#bookingStopCheckOutDate").on("change", function()
		{
			$(".bookingStopErr").html("");
			var checkOutDate = document.getElementById("bookingStopCheckOutDate").value
			
			ajaxBookingStopCheck(roomId, checkInDate, checkOutDate);
		})
		
	}
	
	function ajaxBookingStopCheck(roomId, checkInDate, checkOutDate)
	{
		$.ajax(
		{
			type : "GET"
			, url : "ajaxptbookingstopcheck.wei"
			, data : "roomId=" + roomId + "&checkInDate=" + checkInDate + "&checkOutDate=" + checkOutDate
			, dataType : "text"
			, success : function(bookingCheck)
			{
				$(".bookingStopErr").html("");
				$("#bookingStopBtn").attr("value", bookingCheck);  
				
				if(parseInt(bookingCheck) > 0)
					$(".bookingStopErr").html("예약이 존재하는 기간에는 예약마감이 불가합니다.");
			}
			,error : function(e)
			{
				console.log(e.responseText)
			}
			
		});		
	}
	
	// 예약 마감
	function ptBookingStop(obj)
	{		
		//$(location).attr("href", "ptbookingstop.wei?roomId="+ obj.parentElement.id +"&checkInDate"+ obj.value );
		if (obj.value > 0)
			return;
		
		$("#ptBookingStopForm").submit();
	}	
	
	// 예약 마감 취소
	function ptBookingStopCancel(obj)
	{
		if (confirm("이 객실의 예약을 다시 활성화 하시겠습니까?\n마감되어있던 기간이 전부 활성화 됩니다."))
			$(location).attr("href", "ptbookingstopcancel.wei?bookingNum=" + obj.id);		
	}

	
	
	// 취소 모달 유효성 검사
	$(function()
	{
		$("#err").css("display", "none");
		
		// 환불 금액 변경시 환불 금액 계산
		$("#refund").on("input", function() 
		{
			$("#err").html("");
			
			var paymentAmount = $("#paymentAmount").val();
		
			
			if (parseInt($("#refund").val()) > 100
					|| parseInt($("#refund").val()) < 0)
			{
				$("#err").html("환불%는 0 ~ 100 사이만 입력 가능합니다.");
				$("#err").css("display", "inline");
				$("#refund").focus();
				$(".ptCancelDetailRefundAmount").html("");
				
				return;
			}
			
			if ( $("#refund").val() =="")
			{
				$(".ptCancelDetailRefundAmount").html("");
				return;
			}
			
			var refundAmount = parseInt($("#refund").val()) / 100 * paymentAmount;
			
			$(".ptCancelDetailRefundAmount").html( refundAmount.toLocaleString('ko-KR') + "원");
		});

	});

	
	// 예약 취소 모달띄우기 
	function ajaxBookingCancelModal(bookingNum)
	{
		$.ajax(
		{
			type : "GET"
			, url : "ajaxpartnerbookingcancelmodal.wei"
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
				var paymentAmount = parseInt(jsonObj.paymentAmount);
				var request = jsonObj.request;
				var bookingDate = jsonObj.bookingDate;
				var refund = parseInt(jsonObj.refund);
				
				$('.ptCancelDetailRoomName').text(roomName);
				$('.ptCancelDetailCheckInDate').text(checkInDate);
				$('.ptCancelDetailCheckOutDate').text(checkOutDate);
				$('.ptCancelDetailBookingNum').text(bookingNum);
				$('.ptCancelDetailBookingDate').text(bookingDate);
				$('.ptCancelDetailName').text(name);
				$('.ptCancelDetailPhone').text(phone);
				$('.ptCancelDetailPaymentDate').text(bookingDate);
				$('.ptCancelDetailPaymentAmount').text(paymentAmount.toLocaleString('ko-KR'));
				$('.ptCancelDetailVisitNum').text(visitNum);
				$('.ptCancelDetailRequest').text(request);
				
				
				$('#bookingNum').attr("value", bookingNum);
				$('#paymentAmount').attr("value", paymentAmount);
				$('#refund').attr("value", refund);
				
				var refundAmount = (100 - refund)/100 * paymentAmount;
				
				// 적용해야함
				$('.ptCancelDetailRefundAmount').text(refundAmount.toLocaleString('ko-KR'));
				
			}
			,error : function(e)
			{
				alert("상세 예약내역을 불러올 수 없습니다.");
			}
			
		});		
		
	}
</script>


</head>
<body>

<div class="partnerBookingContainer">

	<!-- 차트 영역 -->
	<div class="partnerBookingItem" style="width: 800px;">
		<canvas id="partnerChart"></canvas>
	</div>
	
	<!-- 달력 영역 -->
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
				<td id="${room.roomId}" name="${room.roomName}" class="ptBookingBtn"></td>
				
			</tr>
			</c:forEach>
		</table>
	</div>
</div>


<!-- 예약 상세 모달 -->
<div class="modal fade" id="ptBookingDetailModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
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
				<span class="bookingDetailSubTitle">결제 금액</span> : <span id="payAmount" class="bookingDetailPaymentAmount"></span>원<br>
				<span class="bookingDetailSubTitle">예약 인원</span> : <span class="bookingDetailVisitNum"></span><br>
				<span class="bookingDetailSubTitle">예약 시 요청사항</span> : <span class="bookingDetailRequest"></span><br>
			</div>
		</div>
	</div>
</div>


<!-- 예약 취소 모달 -->
<div class="modal fade" id="ptBookingCancelModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<span class="modal-title" id="myModalLabel">
					<span class="ptCancelDetailRoomName roomName">객실 이름</span>
					( 체크인 : <span class="ptCancelDetailCheckInDate"></span> / 체크아웃 : <span class="ptCancelDetailCheckOutDate"></span> )
				</span>
			</div>
			<div class="modal-body" style="font-size: medium;">
				<form action="partnerbookingcancel.wei" id="ptBookingCancelForm">
					<span class="bookingDetailSubTitle">예약 번호</span> : <span class="ptCancelDetailBookingNum"></span><br>
					<input type="hidden" id="bookingNum" name="bookingNum">
					<span class="bookingDetailSubTitle">예약일</span> : <span class="ptCancelDetailBookingDate"></span><br> 
					<span class="bookingDetailSubTitle">예약자</span> : <span class="ptCancelDetailName"></span><br>
					<span class="bookingDetailSubTitle">연락처</span> : <span class="ptCancelDetailPhone"></span><br> 
					<span class="bookingDetailSubTitle">결제일</span> : <span class="ptCancelDetailPaymentDate"></span><br> 
					<span class="bookingDetailSubTitle">결제 금액</span> : <span class="ptCancelDetailPaymentAmount"></span>원<br>
					<input type="hidden" id="paymentAmount">
					<span class="bookingDetailSubTitle">예약 인원</span> : <span class="ptCancelDetailVisitNum"></span><br>
					<span class="bookingDetailSubTitle">예약 시 요청사항</span> : <span class="ptCancelDetailRequest"></span><br>
					
					<hr>
					<div class="col-12" style="display: flex;">				
						<span class="bookingDetailSubTitle" style="color: red;">환불 % </span> &nbsp;
						<input type="number" class="form-control" id="refund" name="refund" min="0" max="100" step="5" 
								style="width: 100px;">
					</div>
				</form>
				<span class="bookingDetailSubTitle">환불 예정 금액</span> : <span class="ptCancelDetailRefundAmount"></span><br><br>
			
				<span class="input-group-addon" style="background-color: #ffc0ce80">
	        		<label>
	        			<input type="checkbox" id="box"><span style="color: red;"> * </span> 환불금액을 확인했으며, 취소후에는 번복이 불가함을 확인했습니다. 
	        		</label>
	      		</span>
				
				<div style="text-align: center;">
					<p id="err" style="color: red; font-weight: bold; display: none;"></p>
				</div>
				<hr>
				
				<div style="display: flex; justify-content: center;">
					<button type="button" class="btn btn-default" onclick="ptBookingCancel()">예약 취소하기</button>
				</div>
			</div>		
		</div>
	</div>
</div>


<!-- 예약 마감 모달 -->
<div class="modal fade" id="ptBookingStopModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<span class="modal-title" id="myModalLabel">
					<span class="bookingStopRoomName roomName">객실 이름</span>
				</span>
			</div>
			<div class="modal-body" style="font-size: medium;">
				<form action="ptbookingstop.wei" id="ptBookingStopForm">
					마감할 날짜를 선택하세요 <br> 
					<input type="hidden" id="bookingStopRoomId" name="roomId">
					
					<span class="bookingDetailSubTitle">마감 시작</span> : <input type="date" readonly="readonly" id="bookingStopCheckInDate" name="stopStartDate"><br>
					<span class="bookingDetailSubTitle">마감 끝</span> : <input type="date" id="bookingStopCheckOutDate" name="stopEndDate"><br>
					<span class="bookingStopErr" style="color: red;"></span><br>
				</form>
			</div>
			<div class="modal-footer">
				<div style="display: flex; justify-content: center;">
					<button type="button" id="bookingStopBtn" class="btn btn-default" onclick="ptBookingStop(this)">예약 마감하기</button><br>
					
				</div>
			</div>
		</div>
	</div>
</div>




</body>
</html>