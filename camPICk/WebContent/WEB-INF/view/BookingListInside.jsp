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
			
		$(document).ajaxStart(function()			// ajax 처리시 로딩 gif 추가
		{
			// AJAX 시작 시...
			$("#hide").show();
			$("#reviewList").hide();
			
		}).ajaxComplete(function()
		{
			// AJAX 종료 시...
			$("#hide").hide();
			$("#reviewList").show();
			
		});
		
		
	});

	// 예약번호 ~ 예약 일 영역 클릭시 예약 상세 모달 띄우기
	function showBookingDetail(obj)
	{
		$('#bookingModal').modal('show');
		
		// Ajax 처리
		ajaxBookingDetailModal(obj.id)
	}	
			
	
	function ajaxBookingList(camperNum)
	{
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
					out += "	<div class='item_bookinglist'>";
					out += "      <a href='campickdetail.wei?campgroundId="+ campgroundId +"' class='bookingCPground'><p class='campName'> " + campgroundName + "</p></a><br>";
					out += "      <span class='campDate bookingInfoModal' onclick='showBookingDetail(this)' id='" + bookingNum+ "'>예약번호 : " + bookingNum + "<br>";
					out += "	  결제 일 : " + bookingDate + "<br>";
					out += "      예약 일 : " + checkInDate + " ~ " + checkOutDate + "</span><br>";
					out += "   </div>";
					out += "   <div class='item_bookinglist'><br><span class='campStatus'>" + status + "</span><br> <br>";
					
					
					if( status == '이용 완료')						
						out += "	<button type='button' class='reviewBtn'"
							+ "onclick='showReview(this)' value='"+ bookingNum +"' value2='"+ campgroundId +"' data-toggle='modal' data-target='#myModal'>리뷰 보기</button>";
					else if ( status == '예약 확정')					
						out += "	<button type='button' class='bookingCancelBtn' onclick='location.href=\"bookingcancelform.wei?bookingNum=" + bookingNum + "\"'>예약 취소</button>";
						
					out += "	</div>";
					out += "</div>";
				}	
				
				$("#listDiv").html(out);
				
			}
			
			,error : function(e)
			{
				out = "<span id='noBookingList'><br>해당하는 결과가 없습니다.</span>";
				$("#listDiv").html(out);
			}
			
		}); 
	}
	
	// '리뷰보기' 버튼 클릭 시 동작하는 리뷰 확인 함수(annotation 사용x)
	function showReview(e)
	{
		//alert("함수 호출");
		var bookingNum = $(e).attr("value");
		var campgroundIdVal = $(e).attr("value2");
		
		var str = "";
		var strFooter = "";
		
		$.ajax(
		{
			type : "POST"
			, url : "ajaxbookinglistReview.wei"
			, data : "bookingNum=" + bookingNum
			, dataType : "json"
			, success : function(jsonObj)
			{
				var bookingNum = jsonObj.bookingNum;
				
				if (bookingNum=="0")
				{
					var checkMonth = jsonObj.checkMonth;
					if (checkMonth==1)
					{
						str += "등록한 리뷰가 없습니다.";
						str += "<a href='campickdetail.wei?campgroundId=" + campgroundIdVal + "'> 리뷰 등록하러 가기 </a>";
					}
					else
					{
						str += "등록한 리뷰가 없습니다. 방문일로부터 3개월 이내의 리뷰만 작성가능합니다.";
					}
					
					
					strFooter = "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">확인</button>";
				}
				else
				{
					var contentNum = jsonObj.contentNum;
					var firewood = jsonObj.firewood;
					var camperId = jsonObj.camperId;
					var campgroundId = jsonObj.campgroundId;
					var createDate = jsonObj.createDate;
					var checkInDate = jsonObj.checkInDate;
					var content = jsonObj.content;
					var memberNum = jsonObj.memberNum;
					var replyNum = jsonObj.replyNum;
					var reply = jsonObj.reply;
					var replyCreateDate = jsonObj.replyCreateDate;
					
					str += "			<div class='col-md-12 review-space'>";
					str += "				<div class='col-md-3' style='text-align: center; padding-top: 20px;'>";
					str += "					" + camperId + "<br>";
					
					for (var i=1; i <= 5; i++)			// 장작점수 만큼 장작아이콘 랜더링
					{
						if (i<=firewood)
							str+= "<img src='img/firewood_ver2_Color.png' style='width: 30px;'>";
						else
							str+= "<img src='img/firewood_ver2_BW.png' style='width: 30px;'>";
					}
					
					str += "					<br>";
					str += "					<span style='font-size: x-small;'>방문일 " + checkInDate + "</span>";
					str += "				</div>";
					str += "				<div class='col-md-9' style='padding-top: 5px;'>";
					str += "					<div class='col-md-12' style='text-align: right; font-size: x-small;'>작성일 " + createDate + "</div>";
					str += "					<textarea class='col-md-12 review-content' id='reviewCont" + contentNum +"' readonly='readonly'>" + content + "</textarea>";
					str += "				</div>";
					str += "			</div>";
					if (replyNum!=0)				// 리뷰 댓글이 있을 경우에만 랜더링함
					{
						str += "			<div class='col-md-12 reply-space'>";
						str += "				<div class='col-md-3' style='text-align: center; padding-top: 15px;''>";
						str += "					<img src='img/partnericon.png' style='width: 50px;'>";
						str += "				</div>";
						str += "				<div class='col-md-9' style='padding-top: 5px;'>";
						str += "					<div class='col-md-12' style='text-align: right; font-size: x-small;'>";
						str += "						작성일 " + replyCreateDate;
						str += "					</div>";
						str += "					<textarea class='col-md-12 reply-content' id='replyCont" + replyNum +"' readonly='readonly'>" + reply + "</textarea>";
						str += "					<div class='col-md-12' style='text-align: right; margin-top: 3px;'>";
						str += "						<button type='button' class='btn2'>";
						str += "							<span class='glyphicon glyphicon-exclamation-sign' style='font-size: 15px; color: #eb1e0f;'></span>";
						str += "						</button>";
						str += "					</div>";
						str += "				</div>";
						str += "			</div>";
					}
					
					strFooter += "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">확인</button>";
					strFooter += "<button type=\"button\" class=\"btn btn-primary\" onclick='location.href=\"campickdetail.wei?campgroundId=" + campgroundId + "\"'>수정(상세페이지로 이동)</button>";
					
				}

				$("#reviewList").html(str);
				$("#review-reply-footer").html(strFooter);
				
				//alert(campgroundId);
				
			}
			,error : function(e)
			{
				alert(e.responseText);
				
			}
			
		});		
		
	}
	
	// 
	function ajaxBookingDetailModal(bookingNum)
	{
		//alert("함수 호출");
		var bookingNum = bookingNum;
				
		var str = "";
		var strFooter = "";
		
		$.ajax(
		{
			type : "POST"
			, url : "ajaxbookingdetailmodal.wei"
			, data : "bookingNum=" + bookingNum
			, dataType : "json"
			, success : function(jsonObj)
			{
				var roomName = jsonObj.roomName;
				var campgroundId = jsonObj.campgroundId;
				var campgroundName = jsonObj.campgroundName;
				var name= jsonObj.name;
				var phone = jsonObj.phone;
				var checkInDate = jsonObj.checkInDate;
				var checkOutDate = jsonObj.checkOutDate;
				var visitNum = jsonObj.visitNum;
				var paymentAmount = jsonObj.paymentAmount;
				var request = jsonObj.request;
				var bookingDate = jsonObj.bookingDate;
				
				$("a.bookingDetailModalCampgroundName").attr("href", "campickdetail.wei?campgroundId=" + campgroundId)
				$('.bookingDetailCampgroundName').text(campgroundName);
				$('.bookingDetailBookingNum').text(bookingNum);
				$('.bookingDetailBookingDate').text(bookingDate);
				$('.bookingDetailRoomName').text(roomName);
				$('.bookingDetailName').text(name);
				$('.bookingDetailPhone').text(phone);
				$('.bookingDetailCheckInDate').text(checkInDate);
				$('.bookingDetailCheckOutDate').text(checkOutDate);
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
		
</script>
<style type="text/css">

	.nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus 
	{
    	color: #fff;
    	background-color: #45818e;
	}

	.bookingDetailSubTitle
	{
    	color: #45818E;
		display: inline-block;
		width: 120px;
		text-align: right;
		padding: 3px 2px;
	}
	
	#noBookingList
	{
		font-size: xx-large;
	}
	
</style>
</head>
<body>

<!-- 리뷰보기 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
   
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">나의 리뷰</h4>
			</div>
			<div class="" id="review-reply">
				<div class="col-md-12" id="hide" style="text-align: center;">
					<img src="img/loading_01.gif" alt="loading" style="align-items: center; width: 60px;"/>
				</div>
				<div class="col-md-12" id="reviewList">
					<!-- 리뷰 영역 -->
				</div>
			</div>
			<div class="modal-footer" id="review-reply-footer">
			</div>
     
		</div>
	</div>
</div>

<ul class="nav nav-pills">
	<li role="presentation" id="bookingListLi" class="campTab"><a>이용 내역</a></li>
	<li role="presentation" id="pickCampgroundLi" class="campTab"><a>PICk 캠핑장</a></li>
</ul>

<div class="bookingList">
	<div class="col-12">
		<div class="col-12" style="font-size: large;">
			<select name="status" id="status" class="selectpicker" style="text-align: center;">
				<option value="전체" selected="selected">-전체-</option>
				<option value="예약 확정">예약 확정</option>
				<option value="이용 완료">이용 완료</option>
				<option value="예약 취소">예약 취소</option>
			</select>
		</div>
	</div>

	<div id="listDiv">
		<!-- 이용내역 AJAX 출력 div -->
	</div>
</div>



<div class="modal fade" id="bookingModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">
					<a class="bookingDetailModalCampgroundName"><span class="bookingDetailCampgroundName campName">캠핑장 이름</span></a>
				</h4>
			</div>
			<div class="modal-body">
				<span class="bookingDetailSubTitle">예약 번호</span> : <span class="bookingDetailBookingNum"></span><br>
				<span class="bookingDetailSubTitle">예약일</span> : <span class="bookingDetailBookingDate"></span><br> 
				<span class="bookingDetailSubTitle">예약 객실이름</span> : <span class="bookingDetailRoomName"></span><br> 
				<span class="bookingDetailSubTitle">예약자</span> : <span class="bookingDetailName"></span><br>
				<span class="bookingDetailSubTitle">연락처</span> : <span class="bookingDetailPhone"></span><br> 
				<span class="bookingDetailSubTitle">체크인 ~ 체크아웃</span> : 
					<span class="bookingDetailCheckInDate"></span> ~ <span class="bookingDetailCheckOutDate"></span><br> 
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