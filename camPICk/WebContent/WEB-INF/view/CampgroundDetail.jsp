<%@page import="com.campick.dto.BookingDTO"%>
<%@page import="com.campick.dto.CampgroundDTO"%>
<%@page import="com.campick.dto.ThemeSurvResultDTO"%>
<%@page import="com.campick.dto.OptionSurvResultDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String num = (String)session.getAttribute("num");
	String account = (String)session.getAttribute("account");
	
	String campgroundId = request.getParameter("campgroundId");
	
	// 설문 결과 데이터 수신
	ArrayList<OptionSurvResultDTO> opResult = (ArrayList)request.getAttribute("opSurvLists");
	ArrayList<ThemeSurvResultDTO> thResult = (ArrayList)request.getAttribute("themeSurvLists");
	
	// 차트 라벨 자바스크립트 배열에 담기위한 문자열 구성(옵션)
	int n1=0;
	int n2=0;
	for(int i=0; i<opResult.size(); i++)
	{
		if(opResult.get(i).getOptionTypeNum()==11)
			n1++;
		else
			n2++;
	}
	
	String[] optionName1 = new String[n1];			// 편의시설(11)
	String[] optionName2 = new String[n2];			// 즐길거리(12)
	double[] optionAvg1 = new double[n1];
	double[] optionAvg2 = new double[n2];
	
	int a=0, b=0;
	for(int i=0; i<opResult.size(); i++)
	{
		if(opResult.get(i).getOptionTypeNum()==11)
		{
			optionName1[a] = opResult.get(i).getOptionName();
			optionAvg1[a] = opResult.get(i).getAvg();
			a++;
		}
		else
		{
			optionName2[b] = opResult.get(i).getOptionName();
			optionAvg2[b] = opResult.get(i).getAvg();
			b++;
		}
	}
	
	String strOptionName1 = "";
	String strOptionName2 = "";
	String strOptionAvg1 = "";
	String strOptionAvg2 = "";
	
	for(int i=0; i<optionName1.length; i++)
	{
		if(i==0)
		{
			strOptionName1 += "'"+optionName1[i]+"'";
			strOptionAvg1 += "'"+optionAvg1[i]+"'";
		}
		else
		{
			strOptionName1 += ",'"+optionName1[i]+"'";
			strOptionAvg1 += ",'"+optionAvg1[i]+"'";
		}
	}
	for(int i=0; i<optionName2.length; i++)
	{
		if(i==0)
		{
			strOptionName2 += "'"+optionName2[i]+"'";
			strOptionAvg2 += "'"+optionAvg2[i]+"'";
		}
		else
		{
			strOptionName2 += ",'"+optionName2[i]+"'";
			strOptionAvg2 += ",'"+optionAvg2[i]+"'";
		}
	}
	
	
	// 차트 라벨 자바스크립트 배열에 담기위한 문자열 구성(테마)
	String strThemeName21 = "";
	String strThemeCount21 = "";
	for(int i=0; i<thResult.get(0).getThemeName().length; i++)
	{
		if(i==0)
		{
			strThemeName21 += "'" + thResult.get(0).getThemeName()[i] + "'";
			strThemeCount21 += "'" + thResult.get(0).getCount()[i] + "'";
		}
		else
		{
			strThemeName21 += ",'" + thResult.get(0).getThemeName()[i] + "'";
			strThemeCount21 += ",'" + thResult.get(0).getCount()[i] + "'";
		}
	}
	
	String strThemeName22 = "";
	String strThemeCount22 = "";
	for(int i=0; i<thResult.get(1).getThemeName().length; i++)
	{
		if(i==0)
		{
			strThemeName22 += "'" + thResult.get(1).getThemeName()[i] + "'";
			strThemeCount22 += "'" + thResult.get(1).getCount()[i] + "'";
		}
		else
		{
			strThemeName22 += ",'" + thResult.get(1).getThemeName()[i] + "'";
			strThemeCount22 += ",'" + thResult.get(1).getCount()[i] + "'";
		}
	}
	
	String strThemeName23 = "";
	String strThemeCount23 = "";
	for(int i=0; i<thResult.get(2).getThemeName().length; i++)
	{
		if(i==0)
		{
			strThemeName23 += "'" + thResult.get(2).getThemeName()[i] + "'";
			strThemeCount23 += "'" + thResult.get(2).getCount()[i] + "'";
		}
		else
		{
			strThemeName23 += ",'" + thResult.get(2).getThemeName()[i] + "'";
			strThemeCount23 += ",'" + thResult.get(2).getCount()[i] + "'";
		}
	}
	

	// 리뷰 분기를 위한 처리 (작성할 리뷰(예약내역)가 있는지, 없는지)
	ArrayList<BookingDTO> bookingCheckList = (ArrayList)request.getAttribute("bookingCheckList");
	int br = 0;
	int bcSize = bookingCheckList.size();
	for(BookingDTO dto : bookingCheckList)
	{
		if(dto.getReviewCheck()==1 || dto.getMemberNum().equals("0"))
		{
			br++;
		}
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CampgroundDetail.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/RoomList.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/CampgroundDetail.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

<script type="text/javascript">
	

	$.datepicker.setDefaults(
	{
		dateFormat : 'yy-mm-dd'
		, prevText : '이전 달'
		,nextText : '다음 달'
		,monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월'
					 , '7월', '8월', '9월','10월', '11월', '12월']
		,monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월'
						  , '7월', '8월','9월', '10월', '11월', '12월']
		,dayNames : [ '일', '월', '화', '수', '목', '금', '토' ]
		,dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ]
		,dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ]
		,showMonthAfterYear : true
		,yearSuffix : '년'
	});
	
	
	$(document).ready(function() 
	{
		$("#dialog-confirm").hide();      // #dialog-confirm 숨기기
		
		ajaxReviewRequest(1);						// 페이지가 로드될 때 리뷰 ajax 함수 호출
		
		$("#sort").change(function()
		{
			ajaxReviewRequest(1);					// 정렬조건이 바뀌면 리뷰 ajax 함수 호출
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
		
		
		/* 예약 시 체크인 날짜는 내일부터 체크아웃 날짜는 체크인날짜부터 */
		$("#datepicker1").datepicker({
			minDate:0,
			onSelect: function(selected) 
			{
				$("#datepicker2").datepicker("option","minDate", selected);
			}
		});
			
		$("#datepicker2").datepicker({
			maxDate : "+3M",
			onSelect: function(selected) 
			{
				$("#datepicker1").datepicker("option","maxDate", selected);
				
				// 체크 아웃 날짜 선택 시 전체 객실 리스트 출력
				ajaxRoomList($("#tab1").val());
			}
		});
		
		/* 객실 유형 변경 시 Ajax() 호출 처리 */
		/* 전체 */
		$("#tab1").click(function()
		{
			ajaxRoomList($("#tab1").val());	//90
		});
		
		/* 오토캠핑 */
		$("#tab2").click(function()
		{
			ajaxRoomList($("#tab2").val());	//91
		});
		
		/* 글램핑 */
		$("#tab3").click(function()
		{
			ajaxRoomList($("#tab3").val());	//92
		});
		
		/* 카라반 */
		$("#tab4").click(function()
		{
			ajaxRoomList($("#tab4").val());	//93
		}); 
		
		/* 차박 */
		$("#tab5").click(function()
		{
			ajaxRoomList($("#tab5").val());	//94
		});
		
		
	    // 설문리뷰 등록 버튼 클릭
	    $("#reviewBtn").click(function()
	    {
	         
	       // 컨펌창에서 1. yyyy-mm-dd 리뷰를 작성할래? > 리뷰 폼
	       $(function()
	       {
	            $( "#dialog-confirm" ).dialog({
	                  resizable: false,
	                  height: "auto",
	                  width: 450,
	                  modal: true,
	                  buttons:
	                  {
	                       "리뷰 작성하기": function()
	                       {
	                         $(location).attr("href", "surveyinsertform.wei?campgroundId=${campgroundId}"
	                           + "&memberNum=" + <%=num%>
	                           + "&bookingNum=" + $("input[name='book']:checked").val());
	                       },
	                         "닫기": function()
	                         {
	                          $( this ).dialog( "close" );
	                       }
	                     }
	                });
	         });
	                  
	      });
		
		//픽하기 탭 클릭시 css처리
		$("#pickBtn").on("click",function()
		{
			$("#pickBtn").toggleClass("active");
			
			//if(this.classList=="active")
				//alert("픽 상태 + ${campgroundId}");
			//else
				//alert("픽 해제 상태 + ${campgroundId}");
			
		});

	    
	
	});

	
	// 객실 ajax
	function ajaxRoomList(roomType)
	{
		var params = "campgroundId=${campgroundId}" + "&roomTypeNum=" + $.trim(roomType)
			+"&checkInDate="+$.trim($("#datepicker1").val())+"&checkOutDate="+$.trim($("#datepicker2").val());	// 넘어오는 campgroundId값 넘기기
		
		var num = Number(roomType)-89; //content넘어오는 값을 변경하기 위한 계산식
		var content = "#content"+num;
		
		$.ajax(
		{
			type : "POST"
			, url : "roomlist.wei"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var out = "";
				 
				for(var idx=0; idx<jsonObj.length; idx++)
				{
					var roomId = jsonObj[idx].roomId;
					var roomname = jsonObj[idx].roomName;
					var basicnum = jsonObj[idx].basicNum;
					var maxnum = jsonObj[idx].maxNum;
					var weekdayprice = jsonObj[idx].weekDayPrice;
					var weekendprice = jsonObj[idx].weekEndPrice;
					var info = jsonObj[idx].roomInfo;
					
						out += "<hr>"
						out += "<div class='container_roomlist' id='"+ roomId +"'>";
						out += "		<div class='item_roomlist'>";
						out += "				<img src='img/campground.jpg' class='image-room'>";
						out += "		</div>";
						out += "		<div class='item_roomlist'>";
						out += "						<span class='bangname' style='color:#45818E;'> [" + roomname + "]</span><br>";
						out += "						기준 인원 : " + basicnum + "명 | 최대 인원 : " + maxnum + "명<br>";
						out += "						가격 정보 : 평일 1박 기준 " + weekdayprice +"원 | ";
						out += "									 주말 1박 기준 " + weekendprice +"원<br> 설명 : "+info;
						out += "		</div>";
						out += "		<div class='item_roomlist'>";
						out += "<a href='bookingform.wei?roomId="+roomId+"&checkInDate="+ $("#datepicker1").val() +"&checkOutDate="+$("#datepicker2").val()+"'><button type='button' class='reserveBtn' id='reservation_btn'>예약</button></a>"
						out += "		</div>";
						out += "</div>";
				
				}	
				
				$(content).html(out);
				
			}
			,error : function(e)
			{
				alert("해당 유형 객실은 존재하지않습니다.");
			}
			
		});
	}
	
	
	// 리뷰 데이터 가져오기, 페이징 처리 ajax 
	function ajaxReviewRequest(pageNum)
	{
		var params = "campgroundId=${campgroundId}" + "&sortKey=" + $("#sort option:selected").attr("value")
					+ "&sortOrder=" + $("#sort option:selected").attr("value2") + "&pageNum=" + pageNum;
		
		$.ajax(
		{
			type : "POST"
			, url : "ajaxreview.wei"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var str = "";
				
				for(var idx=0; idx<(jsonObj.length)-1; idx++)		// 배열방 만큼 반복문 순환
				{
					var contentNum = jsonObj[idx].contentNum;
					var bookingNum = jsonObj[idx].bookingNum;
					var firewood = jsonObj[idx].firewood;
					var camperId = jsonObj[idx].camperId;
					var createDate = jsonObj[idx].createDate;
					var checkInDate = jsonObj[idx].checkInDate;
					var content = jsonObj[idx].content;
					var memberNum = jsonObj[idx].memberNum;
					var replyNum = jsonObj[idx].replyNum;
					var reply = jsonObj[idx].reply;
					var replyCreateDate = jsonObj[idx].replyCreateDate;
					
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
					str += "					<div class='col-md-12' style='text-align: right; margin-top: 3px;'>";
					if (memberNum != <%=num%>)		// 리뷰작성자 멤버번호와 캠퍼 로그인 세션에 저장되어있는 멤버번호가 다를 경우 신고버튼 랜더링
					{
						str += "						<button type='button' class='btn2'>";
						str += "							<span class='glyphicon glyphicon-exclamation-sign' style='font-size: 15px; color: #eb1e0f;'></span>";
						str += "						</button>";
					}
					if(memberNum == <%=num%>)		// 리뷰작성자 멤버번호와 캠퍼 로그인 세션에 저장되어있는 멤버번호가 같을 경우 수정/삭제 버튼 랜더링
					{
						str += "						<button type='button' class='btn2' onclick='modalOpen(this)' value='" + contentNum + "' data-toggle='modal' data-target='#myModal'>수정</button>";
						//str += "						<button type='button' class='btn2' onclick='deleteReview(this)' value='" + contentNum + "'>삭제</button>";
					}
					str += "					</div>";
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
					str += "			<hr style='width: 88%; border-color: gray;'/>";
				}
				$("#reviewList").html(str);
				
				var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
				$("#pageIndexList").html(pageIndexList);
				
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
	}	
	
	
	// 모달 창 띄우기
	function modalOpen(e)
	{
		var content = document.getElementById("reviewCont" + $(e).val());
		$("#modalContent").val($(content).val());
		$("#modalCotentNum").val($(e).val());
		
	}

	// 리뷰 수정 함수
	function modifyReview()
	{
		if ($("#modalContent").val()=="")
			return;
		
		var params = "content=" + $("#modalContent").val() + "&contentNum=" + $("#modalCotentNum").val()
		
		$.ajax(
		{
			type : "POST"
			, url : "ajaxreviewupdate.wei"
			, data : params	
			, dataType : "text"
			, success : function(result)
			{
				$('#myModal').modal('hide');
				alert("리뷰가 수정되었습니다.");
				ajaxReviewRequest(1);				// 리뷰 수정 후 리뷰 ajax 다시 호출
			}
			, error : function(e)
			{
				alert(e.responseText);
			} 
		});
	}
	
	
	// 리뷰 삭제 함수
	/* 
	function deleteReview(e)
	{
		if (!confirm("이 리뷰를 정말 삭제하시겠습니까?"))
		{
			return;
		}
		else
		{
			var params = "contentNum=" + $(e).val();
			
			$.ajax(
			{
				type : "POST"
				, url : "ajaxreviewdel.wei"
				, data : params	
				, dataType : "text"
				, success : function(result)
				{
					alert("리뷰가 삭제되었습니다.");
					ajaxReviewRequest(1);				// 리뷰 삭제 후 리뷰 ajax 다시 호출
					
				}
				, error : function(e)
				{
					alert(e.responseText);
				} 
			});
		}
	}
	*/
	
	/* 예약버튼 클릭 시 객실리스트로 이동 */
	function fnMove()
	{
		var offset = $("#main").offset();
		$('html, body').animate({scrollTop : offset.top}, 400);
	}
	
	/* 예약 기능과 연결 */
	function reservation()
	{
		$(location).attr("href", "bookingform.wei?roomId=" + $('#reservation_btn').val() 
	                        + "&checkInDate=" + $('#datepicker1').val()
	                        + "&checkOutDate=" + $('#datepicker2').val());
	}



</script>
<style type="text/css">

	#pickBtn.active { background-color: #FFD032;}

</style>

</head>
<body>

<!-- 리뷰할 예약번호 선택 모달 div -->
<div id="dialog-confirm" title="리뷰를 남길 예약번호를 선택하세요.">
	<c:forEach var="bookcheck" items="${bookingCheckList }">
		<c:if test="${bookcheck.reviewCheck eq 0 }">
			<label>
			<input type="radio" name="book" value="${bookcheck.bookingNum }">
			${bookcheck.bookingNum } (${bookcheck.checkInDate } ~ ${bookcheck.checkOutDate })
			</label>
		</c:if>
	</c:forEach>
</div>

<!-- 모달(리뷰수정)을 위한 div -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">리뷰 수정</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="modalCotentNum" />
				<textarea rows="10" cols="60" id="modalContent" maxlength="250" style="resize: none;"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" onclick="modifyReview()">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 div end -->

<div class="container-cgd">
		<div class="item-cgd">
			<div class="top">
				<span style="font-size: 30px;">${campgroundListDetail.campgroundName }</span>
				<span style="margin-left: 10px; font-size: 16px;">PICK<span class='badge'>${campgroundListDetail.pick }</span></span>
				<span style="font-size: 16px;">REVIEW<span class='badge'>${campgroundListDetail.review }</span></span>
				
				<button type="button" class="btn1" id="shareBtn">공유하기</button>
				<button type="button" class="btn1" id="pickBtn">픽하기</button>
			</div>
		</div>
		
		<div class="item-cgd">
			<div class="image-cgd">
				<div class="image-box">
					<img class="image-thumbnail" src="<%=cp %>/img/campMain.jpg">
					<%-- 
					<img class="image-thumbnail" src="<%=cp %>/img/campground2.jpg">
					<img class="image-thumbnail" src="<%=cp %>/img/campground3.jpg">
					<img class="image-thumbnail" src="<%=cp %>/img/campground4.jpg">
					<img class="image-thumbnail" src="<%=cp %>/img/campground5.jpg">
					--%>
				</div>
			</div>
		</div>

		<div class="item-cgd">
			<table class="item-table">				
				<tr>
					<td colspan="1" class="campgroundInfoTitle">주소</td>
					<td colspan="3" class="campgroundInfoValue">${campgroundListDetail.address1 } ${campgroundListDetail.address2 } ${campgroundListDetail.address3 }</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">대표번호</td>
					<td class="campgroundInfoValue">${campgroundListDetail.tel }</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">객실유형</td>
					<td class="campgroundInfoValue">
						<c:forEach var="roomTypeName" items="${roomTypeName }">
							◈ ${roomTypeName }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">편의시설</td>
					<td class="campgroundInfoValue">
						<c:forEach var="comforts" items="${comforts }">
							◈ ${comforts.optionName }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">즐길거리</td>
					<td class="campgroundInfoValue">
						<c:forEach var="entertain" items="${entertain }">
							◈ ${entertain.optionName }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">체크인 / 체크아웃</td>
					<td class="campgroundInfoValue">${campgroundListDetail.checkInDate }시 / ${campgroundListDetail.checkOutDate }시</td>
				</tr>
				
				<tr><td colspan="4" style="height: 30px;"></td></tr>
				
				<tr>
					<td colspan="4" class="campgroundInfoValue">"${campgroundListDetail.extraInfo }"</td>
				</tr>
				
				<tr><td colspan="4" style="height: 30px;"></td></tr>
				 
			</table>
			
			<table class="item-table">
			<tr>
					<td class="btnTable">
						<button type="button" onclick="fnMove()" class="btn0">예약</button>
					</td>
					<td class="btnTable">
						<%
						if(br!=bcSize)
						{
						%>
							<button type="button" onclick="" class="btn0" id="reviewBtn" >설문리뷰 등록</button>
						<%
						}
						%>
					</td>
					
				</tr>
			</table>
		</div>
		
		<br><br>
		
		<!-- 통계 차트 영역 시작 -->
		<div class="col-md-12" style="font-size: large;">캠퍼 통계</div>
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false" 
		style="padding: 10%; padding-top: 2px; ">
			<!-- Indicators -->
			<ol class="carousel-indicators">
			  <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			  <li data-target="#carousel-example-generic" data-slide-to="1"></li>
			  <li data-target="#carousel-example-generic" data-slide-to="2"></li>
			  <li data-target="#carousel-example-generic" data-slide-to="3"></li>
			  <li data-target="#carousel-example-generic" data-slide-to="4"></li>
			</ol>
			
			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox" >
			  <div class="item active chart-content">
			    <canvas id="myChart1"></canvas>
			  </div>
			  <div class="item chart-content">
			    <canvas id="myChart2"></canvas>
			  </div>
			  <div class="item chart-content">
			    <canvas id="myChart3"></canvas>
			  </div>
			  <div class="item chart-content">
			    <canvas id="myChart4"></canvas>
			  </div>
			  <div class="item chart-content">
			    <canvas id="myChart5"></canvas>
			  </div>
			</div>
			
			<!-- Controls -->
			  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
		</div>


		<!-- 리뷰영역 시작 -->
		<div class="col-md-12">
			<div class="col-md-12" style="font-size: large;">캠퍼 리뷰</div>
			<div class="col-md-12" style="text-align: right;">
				<select name="sort" id="sort" style="font-size: small;">
					<option value="createDate" value2="asc" selected="selected">리뷰작성일 오름차순</option>
					<option value="createDate" value2="desc">리뷰작성일 내림차순</option>
					<option value="fireWood" value2="asc">평점 적은 순</option>
					<option value="fireWood" value2="desc">평점 많은 순</option>
				</select>
			</div>
		</div>
		
		<div class="col-md-12" id="hide" style="text-align: center;">
			<img src="img/loading_01.gif" alt="loading" style="align-items: center; width: 60px;"/>
		</div>
		<div class="col-md-12" id="reviewList">
			<!-- 리뷰 영역 -->
		</div>
			
		<div class="col-md-12">
			<div style="text-align: center; margin: 30px auto;" id="pageIndexList">
				<!-- 리뷰 페이징 영역 -->
			</div>
		</div>
		

		
		
		<div class="item-cgd">
		         <span class="errMsg">날짜를 선택하세요.</span><br>
		         <input type="text" id="datepicker1" class="textbox" style="width: 100px; text-align: center;"> 
		          ~ <input type="text" id="datepicker2" class="textbox" style="width: 100px; text-align: center;">
		    </div>
		    
		    
		    <div class="item-cgd" id="main">
		     
				<input class="tab" id="tab1" type="radio" name="tabs" checked="checked" value="90">  
				<label for="tab1">전체</label>
				
				<input class="tab" id="tab2" type="radio" name="tabs" value="91">
				<label for="tab2">오토캠핑</label>
				
				<input class="tab" id="tab3" type="radio" name="tabs" value="92">
				<label for="tab3">글램핑</label>
				
				<input class="tab" id="tab4" type="radio" name="tabs" value="93">
				<label for="tab4">카라반</label>
				
				<input class="tab" id="tab5" type="radio" name="tabs" value="94">
				<label for="tab5">차박</label>
				
				<section id="content1" style="margin-bottom:20px; height: 100%;">
					<!--  전체 객실 리스트 출력 -->
				</section>
				
				<section id="content2" style="margin-bottom:20px;">
					<!--  전체 오토캠핑 리스트 출력 -->
				</section>
				
				<section id="content3" style="margin-bottom:20px;">
					<!--  전체 글램핑 리스트 출력 -->
				</section>
				
				<section id="content4" style="margin-bottom:20px;">
					<!--  전체 카라반 리스트 출력 -->
				</section>
				
				<section id="content5" style="margin-bottom:20px;">
					<!--  전체 차박 리스트 출력 -->
				</section>
		  
		  </div>
		
		
		
</div>


<script type="text/javascript">
	
	// 차트 그리기 옵션 준비
	var strOptionName1 = [<%=strOptionName1%>];
	var strOptionAvg1 = [<%=strOptionAvg1%>];
	
	var strOptionName2 = [<%=strOptionName2%>];
	var strOptionAvg2 = [<%=strOptionAvg2%>];
	
	// 차트 그리기 테마 준비
	var strThemeName21 = [<%=strThemeName21%>];
	var strThemeCount21 = [<%=strThemeCount21%>];
	
	var strThemeName22 = [<%=strThemeName22%>];
	var strThemeCount22 = [<%=strThemeCount22%>];
	
	var strThemeName23 = [<%=strThemeName23%>];
	var strThemeCount23 = [<%=strThemeCount23%>];
	
	// 차트 그리기 옵션1
	var context = document
	    .getElementById('myChart1')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'bar', // 차트의 형태
	    data: { // 차트에 들어갈 데이터
	        labels: 
	            //x 축
	           strOptionName1
	        ,
	        datasets: [
	            { //데이터
	                //label: '편의시설', //차트 제목
	                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                data: 
	                	strOptionAvg1 //x축 label에 대응되는 데이터 값
	                ,
	                backgroundColor: [
	                    //색상
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)',
	                    'rgba(75, 192, 192, 0.2)',
	                    'rgba(153, 102, 255, 0.2)',
	                    'rgba(255, 159, 64, 0.2)'
	                ],
	                borderColor: [
	                    //경계선 색상
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)',
	                    'rgba(75, 192, 192, 1)',
	                    'rgba(153, 102, 255, 1)',
	                    'rgba(255, 159, 64, 1)'
	                ],
	                borderWidth: 1 //경계선 굵기
	            }/* ,
	            {
	                label: 'test2',
	                fill: false,
	                data: [
	                    8, 34, 12, 24
	                ],
	                backgroundColor: 'rgb(157, 109, 12)',
	                borderColor: 'rgb(157, 109, 12)'
	            } */
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [
	                {
	                    ticks: {
	                    	min: 0,
	                        //suggestedMin: 0,
							max: 5,
							stepSize : 0.5
	                    }
	                }
	            ],
	            xAxes: [{
	                // Change here
	            	barPercentage: 0.2
	            }]
	        }
	    	, title: {
	            display: true,
	            text: '편의시설',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    }
	});
	
	
	// 차트 그리기 옵션2
	var context = document
	    .getElementById('myChart2')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'bar', 	// 차트의 형태
	    data: { // 차트에 들어갈 데이터
	        labels: strOptionName2,
	        datasets: [
	            { //데이터
	                //label: '즐길거리',		 	//차트 제목
	                fill: false, 			// line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                data: strOptionAvg2, 	//x축 label에 대응되는 데이터 값
	                backgroundColor: [
	                    //색상
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)',
	                    'rgba(75, 192, 192, 0.2)',
	                    'rgba(153, 102, 255, 0.2)',
	                    'rgba(255, 159, 64, 0.2)'
	                ],
	                borderColor: [
	                    //경계선 색상
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)',
	                    'rgba(75, 192, 192, 1)',
	                    'rgba(153, 102, 255, 1)',
	                    'rgba(255, 159, 64, 1)'
	                ],
	                borderWidth: 1 //경계선 굵기
	            }
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [
	                {
	                    ticks: {
	                    	min: 0,
	                        //suggestedMin: 0,
							max: 5,
							stepSize : 0.5
	                    }
	                }
	            ],
	            xAxes: [{
	                // Change here
	            	barPercentage: 0.2
	            }]
	        }
	    	, title: {
	            display: true,
	            text: '즐길거리',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    	, layout: {
	            padding: 20
	        }
	    }
	});
	
	
	// 차트 그리기 테마1
	var context = document
	    .getElementById('myChart3')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'pie', 	// 차트의 형태
	    data: { // 차트에 들어갈 데이터
	        labels: strThemeName21,
	        datasets: [
	            { //데이터
	            	//type : 'pie',
	            	//label: strThemeName21, //차트 제목
	                fill: false, 			// line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                data: strThemeCount21, 	//x축 label에 대응되는 데이터 값
	                backgroundColor: [
	                    //색상
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)',
	                    'rgba(75, 192, 192, 0.2)',
	                    'rgba(153, 102, 255, 0.2)',
	                    'rgba(255, 159, 64, 0.2)'
	                ],
	                borderColor: [
	                    //경계선 색상
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)',
	                    'rgba(75, 192, 192, 1)',
	                    'rgba(153, 102, 255, 1)',
	                    'rgba(255, 159, 64, 1)'
	                ],
	                borderWidth: 1 //경계선 굵기
	            }
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true
	                    }
	                }
	            ]
	        }
	    	, title: {
	            display: true,
	            text: '계절',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    	, layout: {
	            padding: 70
	        }
	    }
	});
	
	// 차트 그리기 테마2
	var context = document
	    .getElementById('myChart4')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'pie', 	// 차트의 형태
	    data: { // 차트에 들어갈 데이터
	        labels: strThemeName22,
	        datasets: [
	            { //데이터
	            	//type : 'pie',
	            	//label: strThemeName21, //차트 제목
	                fill: false, 			// line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                data: strThemeCount22, 	//x축 label에 대응되는 데이터 값
	                backgroundColor: [
	                    //색상
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)',
	                    'rgba(75, 192, 192, 0.2)',
	                    'rgba(153, 102, 255, 0.2)',
	                    'rgba(255, 159, 64, 0.2)'
	                ],
	                borderColor: [
	                    //경계선 색상
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)',
	                    'rgba(75, 192, 192, 1)',
	                    'rgba(153, 102, 255, 1)',
	                    'rgba(255, 159, 64, 1)'
	                ],
	                borderWidth: 1 //경계선 굵기
	            }
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true
	                    }
	                }
	            ]
	        }
	    	, title: {
	            display: true,
	            text: '어울리는 구성원',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    	, layout: {
	            padding: 70
	        }
	    }
	});
	
	// 차트 그리기 테마2
	var context = document
	    .getElementById('myChart5')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'pie', 	// 차트의 형태
	    data: { // 차트에 들어갈 데이터
	        labels: strThemeName23,
	        datasets: [
	            { //데이터
	            	//type : 'pie',
	            	//label: strThemeName21, //차트 제목
	                fill: false, 			// line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                data: strThemeCount23, 	//x축 label에 대응되는 데이터 값
	                backgroundColor: [
	                    //색상
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)',
	                    'rgba(75, 192, 192, 0.2)',
	                    'rgba(153, 102, 255, 0.2)',
	                    'rgba(255, 159, 64, 0.2)'
	                ],
	                borderColor: [
	                    //경계선 색상
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)',
	                    'rgba(75, 192, 192, 1)',
	                    'rgba(153, 102, 255, 1)',
	                    'rgba(255, 159, 64, 1)'
	                ],
	                borderWidth: 1 //경계선 굵기
	            }
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true
	                    }
	                }
	            ]
	        }
	    	, title: {
	            display: true,
	            text: '분위기',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    	, layout: {
	            padding: 70
	        }
	    }
	});
 
	
</script>



</body>
</html>