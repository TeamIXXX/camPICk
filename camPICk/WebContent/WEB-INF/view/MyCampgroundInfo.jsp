<%@page import="com.campick.dao.IPartnerMainDAO"%>
<%@page import="com.campick.dto.ThemeSurvResultPartnerDTO"%>
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
	String loginId = (String)session.getAttribute("loginId");
	
	ArrayList<OptionSurvResultDTO> opResult = (ArrayList)request.getAttribute("opSurvLists");
	ArrayList<ThemeSurvResultPartnerDTO> thResult = (ArrayList)request.getAttribute("themeSurvLists");
	// THEME_TYPENUM, THEMENUM, THEMENAME, NVL(TC.COUNT, 0) AS COUNT
	
	String campgroundId = (String)session.getAttribute("campgroundId");	
	
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
	// ArrayList<ThemeSurvResultPartnerDTO> thResult = (ArrayList)request.getAttribute("themeSurvLists");
	// THEME_TYPENUM, THEMENUM, THEMENAME, NVL(TC.COUNT, 0) AS COUNT
	String strThemeName21 = "";
	String strThemeCount21 = "";
	String strThemeName22 = "";
	String strThemeCount22 = "";
	String strThemeName23 = "";
	String strThemeCount23 = "";
	
	
	//String str = "";
	
	for(int i=0; i<thResult.size(); i++)
	{
		//str += thResult.get(i).getThemeTypeNum() + ",";
		if(thResult.get(i).getThemeTypeNum()==21)
		{
			strThemeName21 += "'" + thResult.get(i).getThemeName() + "', ";
			strThemeCount21 += "'" + thResult.get(i).getCount() + "', ";
		}
		else if(thResult.get(i).getThemeTypeNum()==22)
		{
			strThemeName22 += "'" + thResult.get(i).getThemeName() + "', ";
			strThemeCount22 += "'" + thResult.get(i).getCount() + "', ";
		}
		else
		{
			strThemeName23 += "'" + thResult.get(i).getThemeName() + "', ";
			strThemeCount23 += "'" + thResult.get(i).getCount() + "', ";
		}
	}
	
	
	//System.out.println(strThemeName21);
	//System.out.println(strThemeName22);
	//System.out.println(thResult.get(0).getThemeNum());
	

	strThemeName21 = strThemeName21.substring(0, strThemeName21.length()-2);
	strThemeName22 = strThemeName22.substring(0, strThemeName22.length()-2);
	strThemeName23 = strThemeName23.substring(0, strThemeName23.length()-2);
	strThemeCount21 = strThemeCount21.substring(0, strThemeCount21.length()-2);
	strThemeCount22 = strThemeCount22.substring(0, strThemeCount22.length()-2);
	strThemeCount23 = strThemeCount23.substring(0, strThemeCount23.length()-2);
	


	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyCampgroundInfo.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/RoomInsertFormModal.css">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="js/bootstrap.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/CampgroundDetail.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/RoomList.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MyCampgroundInfo2.css">

<script type="text/javascript">
	
	$(document).ready(function()
	{
		ajaxReviewRequest(1);						// 페이지가 로드될 때 리뷰 ajax 함수 호출
		
		ajaxRoomList(90);
		
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
		
	});
	
	

	// 리뷰 데이터 가져오기, 페이징 처리 ajax 함수
	// 요청주소, 전송데이터, 응답액션처리
	function ajaxReviewRequest(pageNum)
	{
		var params = "campgroundId=${campgroundId}" + "&sortKey=" + $("#sort option:selected").attr("value")
					+ "&sortOrder=" + $("#sort option:selected").attr("value2") + "&pageNum=" + pageNum; 
		
		$.ajax(
		{
			type : "GET"
			, url : "ajaxreviewpartner.wei"
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
					
					for (var i=1; i <= 5; i++)
					{
						if (i<=firewood)
						{
							str+= "<img src='img/firewood_ver2_Color.png' style='width: 30px;'>";
						}
						else
						{
							str+= "<img src='img/firewood_ver2_BW.png' style='width: 30px;'>";
						}
					}
					
					str += "					<br>";
					str += "					<span style='font-size: x-small;'>방문일 " + checkInDate + "</span>";
					str += "				</div>";
					str += "				<div class='col-md-9' style='padding-top: 5px;'>";
					str += "					<div class='col-md-12' style='text-align: right; font-size: x-small;'>작성일 " + createDate + "</div>";
					str += "					<textarea class='col-md-12 review-content' id='reviewCont" + contentNum +"' readonly='readonly'>" + content + "</textarea>";
					str += "					<div class='col-md-12' style='text-align: right; margin-top: 3px;'>";
					str += "						<button type='button' class='btn2'>";
					str += "							<span class='glyphicon glyphicon-exclamation-sign' style='font-size: 15px; color: #eb1e0f;'></span>";
					str += "						</button>";
					str += "					</div>";
					str += "				</div>";
					str += "			</div>";
					if (replyNum!=0)
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
						//str += "						<button type='button' class='btn2'>";
						// 파트너페이지에서는 사장님 댓글에 신고버튼 그리지 않음. 대신 모든 사장님 댓글에 수정, 삭제 버튼 추가
						str += "						<button type='button' class='btn2' onclick='modalOpen(this)' value='" + replyNum + "' data-toggle='modal' data-target='#myModal'>수정</button>";
						str += "						<button type='button' class='btn2' onclick='deleteReviewReply(this)' value='" + replyNum + "'>삭제</button>";
						//str += "						</button>";
						str += "					</div>";
						str += "				</div>";
						str += "			</div>";
					}
					else if(replyNum==0)
					{
						str += "			<div class='col-md-12 reply-space'>";
						str += "				<div class='col-md-3' style='text-align: center; padding-top: 15px;''>";
						str += "					<button type='button' class='roomlistBtn' style='height: 25px;' id='btnForm"+ contentNum +"' onclick='replyInsertFormShow(" + contentNum + ")'>댓글 등록</button>";
						str += "				</div>";
						str += "				<div class='col-md-9 replyForm"+ contentNum +"' style='padding-top: 5px; display: none;'>";
						str += "					<textarea class='col-md-10 reply-content' id='" + bookingNum +"'  maxlength='200' placeholder='200자 이내 입력 가능'></textarea>";
						str += "					<div class='col-md-2' style='text-align: right; margin-top: 3px;'>";
						str += "						<button type='button' class='roomlistBtn' style='height: 25px; width: 55px;' onclick='replyInsert(this)' value='" + bookingNum + "' value2='" + contentNum + "'>등록</button>";
						str += "						<button type='button' class='roomlistBtn' style='height: 25px; width: 55px;' onclick='ajaxReviewRequest(1)' value='" + bookingNum + "' value2='" + contentNum + "'>취소</button>";
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
	
	
	// 모달 창에 데이터 넘기기
	function modalOpen(e)
	{
		var content = document.getElementById("replyCont" + $(e).val());
		$("#modalReply").val($(content).val());
		$("#modalReplyNum").val($(e).val());
		
	}
	
	// 리뷰댓글 등록폼 보이기 함수
	function replyInsertFormShow(contentNum)
	{
		var temp = ".replyForm" + contentNum;
		var temp2 = "#btnForm" + contentNum;
		$(temp).show();
		$(temp2).hide();
	}
	

	// 리뷰댓글 입력 후 등록 버튼 클릭 시 리뷰 댓글 등록 ajax 함수
	function replyInsert(e)
	{
		var bookingNum = $(e).attr("value");
		var contentNum = $(e).attr("value2");
		var replyTextarea = document.getElementById($(e).attr("value"));
		var reply = $(replyTextarea).val();
		
		var formAreaClass = ".replyForm" + contentNum;
		
		if( !$(replyTextarea).val())
		{
			alert("내용을 입력해주세요");
			return;
		}
		
 		$.ajax(
		{
			type : "GET"
			, url : "ajaxreviewreplyinsert.wei"
			, data : {
						"contentNum" : contentNum
					 	, "bookingNum" : bookingNum
					 	, "reply" : reply
					 }
			, dataType : "text"
			, success : function(result)
			{
				/* $(formAreaClass).hide(); */
				alert("리뷰 댓글이 등록되었습니다.");
				ajaxReviewRequest(1);
				
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
			
		});
		
	}


	// 리뷰댓글 수정 함수
	function modifyReviewReply()
	{
		if ($("#modalReply").val()=="")
		{
			return;
		}
		
		var params = "reply=" + $("#modalReply").val() + "&replyNum=" + $("#modalReplyNum").val()
		
		$.ajax(
		{
			type : "GET"
			, url : "ajaxreviewreplyupdate.wei"
			, data : params	
			, dataType : "text"
			, success : function()
			{
				$('#myModal').modal('hide');
				alert("리뷰 댓글이 수정되었습니다.");
				ajaxReviewRequest(1);				// 리뷰 수정 후 리뷰 ajax 다시 호출
			}
			, error : function(e)
			{
				alert(e.responseText);
			} 
		});
	}


	// 리뷰 삭제 함수
	function deleteReviewReply(e)
	{
		if (!confirm("이 댓글을 정말 삭제하시겠습니까?"))
		{
			return;
		}
		else
		{
			var params = "replyNum=" + $(e).val();
			
			$.ajax(
			{
				type : "GET"
				, url : "ajaxreviewreplydel.wei"
				, data : params	
				, dataType : "text"
				, success : function(result)
				{
					alert("리뷰 댓글이 삭제되었습니다.");
					ajaxReviewRequest(1);				// 리뷰 삭제 후 리뷰 ajax 다시 호출
					
				}
				, error : function(e)
				{
					alert(e.responseText);
				} 
			});
		}
	}
	

	// 객실 ajax
	function ajaxRoomList(num)
	{
		var params = "campgroundId=${campgroundId}" +"&roomTypeNum="+$.trim(num);// 넘어오는 campgroundId값 넘기기
		
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
					var roomTypeName = jsonObj[idx].roomTypeName;
					
					
						out += "<hr>"
						out += "<div class='container_roomlist' id='"+ roomId +"'>";
						out += "		<div class='item_roomlist'>";
						out += "				<img src='img/campground.jpg' class='image-room'>";
						out += "		</div>";
						out += "		<div class='item_roomlist'>";
						out += "						<span class='bangname' style='color:#45818E;'> [" + roomname + "]</span><span style='font-size : 15px;'>" + roomTypeName + "</span><br>";
						out += "						기준 인원 : " + basicnum + "명 | 최대 인원 : " + maxnum + "명<br>";
						out += "						가격 정보 : 평일 1박 기준 " + weekdayprice +"원 | ";
						out += "									 주말 1박 기준 " + weekendprice +"원<br> 설명 : "+info;
						out += "		</div>";
						out += "		<div class='item_roomlist' id='button'>";
						out += " 			<input type=hidden id=roomname value="+roomname+">"
						out += "			<button type='button' class='roomlistBtn' onclick='roomIdSend(this)' id="
						out += roomId 
						out += ">수정</button>";
						out += " 			<input type=hidden roomTypeName="+roomTypeName+" roomname=" +roomname+ " basicnum="+basicnum+" maxnum="+maxnum +" weekdayprice="+weekdayprice+" weekendprice="+weekendprice+" info="+info+">"
						out += "			<button type='button' class='roomlistBtn' id='deleteBtn' onclick=''>삭제</button>";
						out += "		</div>";
						out += "</div>";
				
				}	
				
				$("#roomInsertSpace").html(out);
				
			}
			,error : function(e)
			{
				alert("객실을 등록해주세요.");
			}
			
		});
	}

	
	// 객실 수정창 띄우기
	function roomIdSend(obj)
	{
		//roomUpdate(obj.id)
		$('#roomIdSend').val(obj.id);
		
		
		var roomTypeName = $(obj).next('input').attr('roomTypeName')
		var roomname = $(obj).next('input').attr('roomname')
		var basicnum = $(obj).next('input').attr('basicnum')
		var maxnum = $(obj).next('input').attr('maxnum')
		var weekdayprice = $(obj).next('input').attr('weekdayprice')
		var weekendprice = $(obj).next('input').attr('weekendprice')
		var info = $(obj).next('input').attr('info')
		
		
		if(roomTypeName=="오토캠핑")
			$('#91').attr('checked', true); 
		else if(roomTypeName=="글램핑")
			$('#92').attr('checked', true);
		else if(roomTypeName=="카라반")
			$('#93').attr('checked', true);
		else if(roomTypeName=="차박")
			$('#94').attr('checked', true); 

			
		$('#roomNameUpdate').val(roomname)
		$('#basicNumUpdate').val(basicnum)
		$('#maxNumUpdate').val(maxnum)
		$('#weekDayPriceUpdate').val(weekdayprice)
		$('#weekEndPriceUpdate').val(weekendprice)
		$('#roomInfoUpdate').val(info)
		
		
		$('#roomUpdateModal').modal('show');
		
		
	}
	

	/* function roomInsertInfo()
	{
		var roomType = $(".roomType").val();
		var roomName = $("#roomNameValue").val();
		var basicNum = $("#basicNumValue").val();
		var maxNum = $("#maxNumValue").val();
		var weekDayPrice = $("#weekDayPriceValue").val();
		var weekEndPrice = $("#weekEndPriceValue").val();
		var roomInfo = $("#roomInfo").val();
		
		//alert(roomInfo);
		
		$("#roomInsertForm").attr("action","roominsert.wei?roomName="+roomName+"&roomTypeNum="+roomType+"&basicNum="+basicNum
				+"&maxNum="+maxNum+"&weekDayPrice="+weekDayPrice+"&weekEndPrice="+weekEndPrice+"&roomInfo="+roomInfo); 
				
	} */

</script>


</head>
<body>
<!-- 모달(리뷰댓글수정)을 위한 div -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
   
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">리뷰 수정</h4>
      </div>
      <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
      	<textarea rows="10" cols="60" id="modalReply" maxlength="200" style="resize: none;" placeholder="200자 이내 입력 가능"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="modifyReviewReply()">저장</button>
      </div>
     
    </div>
  </div>
</div>
<!-- 모달 div end -->


<!-- 모달(통계차트)을 위한 div -->

<div class="modal fade" id="chartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
   
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">설문 통계</h4>
      </div>
      
	  <!-- 통계 차트 영역 시작 -->
      <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
		<div class="item chart-content">
		  <canvas id="myChart1"></canvas>
		</div>
	  </div>
		
	  <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
        <div class="item chart-content">
	      <canvas id="myChart2"></canvas>
	    </div>
      </div>
      
      <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
        <div class="item chart-content" style="margin: 25px;">
		  <canvas id="myChart3" width="500px" height="500px"></canvas>
		</div>
	  </div>
      
      <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
        <div class="item chart-content" style="margin: 25px;">
	      <canvas id="myChart4" width="500px" height="500px"></canvas>
	    </div>
      </div>
      
      <div class="modal-body">
      	<input type="hidden" id="modalReplyNum" />
	    <div class="item chart-content" style="margin: 25px;">
	      <canvas id="myChart5" width="500px" height="500px"></canvas>
	    </div>
      </div>   
         
         
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
     
    </div>
  </div>
</div>

<!-- 모달 div end -->


<div class="container-cgd">
      <div class="item-cgd">
			<div class="top col-md-12">
				<table class="col-md-8">
					<tr >
						<td style=" width: 200px;"><span style="font-size: 30px;">${myCampgroundInfo.campgroundName }</span></td>
						<td style=" width: 90px;"><span style="margin-left: 10px; font-size: 16px;">PICK<span class='badge'>${myCampgroundInfo.pick }</span></span></td>
						<td><span style="font-size: 16px;">REVIEW<span class='badge'>${myCampgroundInfo.review }</span></span></td>
					</tr>
				</table>
				<div class="col-md-4" style="text-align: right;"><button type="button" id="myCampgroundUpdate" class="btn0" onclick="location.href='mycampgroundupdatetemplate.wei'">캠핑장 수정</button></div>
				<%-- <span style="font-size: 30px;">${myCampgroundInfo.campgroundName }</span>
				<span style="margin-left: 10px; font-size: 16px;">PICK<span class='badge'>${myCampgroundInfo.pick }</span></span>
				<span style="font-size: 16px;">REVIEW<span class='badge'>${myCampgroundInfo.review }</span></span>
				<button type="button" id="myCampgroundUpdate">캠핑장 수정</button>	 --%>		
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
					<td colspan="3" class="campgroundInfoValue">${myCampgroundInfo.address1 } ${myCampgroundInfo.address2 } ${myCampgroundInfo.address3 }</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">대표번호</td>
					<td class="campgroundInfoValue">${myCampgroundInfo.tel }</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">객실유형</td>
					<td class="campgroundInfoValue">
						<c:forEach var="roomTypeList" items="${roomTypeList }">
							◈ ${roomTypeList }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">편의시설</td>
					<td class="campgroundInfoValue">
						<c:forEach var="comforts" items="${comfortsList }">
							◈ ${comforts }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">즐길거리</td>
					<td class="campgroundInfoValue">
						<c:forEach var="funList" items="${funList }">
							◈ ${funList }
						</c:forEach>
					</td>
				</tr>
				<tr><td colspan="4" style="height: 15px;"></td></tr>
				<tr>
					<td class="campgroundInfoTitle">체크인 / 체크아웃</td>
					<td class="campgroundInfoValue">${myCampgroundInfo.checkInDate }시 / ${myCampgroundInfo.checkOutDate }시</td>
				</tr>
				
				<tr><td colspan="4" style="height: 30px;"></td></tr>
				
				<tr>
					<td colspan="4" class="campgroundInfoValue">"${myCampgroundInfo.extraInfo }"</td>
				</tr>
				
				<tr><td colspan="4" style="height: 30px;"></td></tr>
				 
			</table>
		</div>
		
		<div class="item-cgd" id="roomInsertMain" >
			<div class="roomInsertInfo">
				<button type="button" id="roomInsertBtn" class="btn0" data-toggle="modal" data-target="#roomInsertModal">객실추가</button>
			</div>
			
			<!-- 객실리스트 뜨는 공간 -->
			<div id="roomInsertSpace"></div>
		</div>
      
      <div class="item-cgd" style="text-align: right; margin-right: 10px; margin-bottom: 10px;">
         <button type="button" id="chartBtn" class="btn0" data-toggle="modal" data-target="#chartModal">사용자 통계</button>
      </div>
   	
	
		
		<!-- 리뷰영역 시작 -->
		<div class="col-md-12">
			<div class="col-md-12" style="font-size: large;">내 캠핑장 리뷰</div>
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
				<!-- 페이징 영역 -->
			</div>
		</div>
</div>


<!-- 객실 추가 모달 -->

<div class="modal fade" id="roomInsertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form action="roominsert.wei" method="get" id="roomInsertForm">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h3 class="modal-title" id="myModalLabel" style="text-align: center">객실 추가</h3>
         </div>
      
         <div class="modal-body">
            <!-- 객실추가 폼 -->
            
            <div class="roomInsertMain">
                  <div class="roomInsertItem">유형선택</div>
                  <input type="hidden" id="campgroundId" value="<%=campgroundId%>">
                  <div class="roomInsertItem">
                     	<label><input type="radio" name="roomTypeNum" value="91" class="roomTypeNum">오토캠핑 </label>
                        <label><input type="radio" name="roomTypeNum" value="92" class="roomTypeNum">글램핑 </label>
                        <label><input type="radio" name="roomTypeNum" value="93" class="roomTypeNum">카라반 </label>
                        <label><input type="radio" name="roomTypeNum" value="94" class="roomTypeNum">차박 </label>
                  </div>
                  
                  <div class="roomInsertItem">객실이름</div>
                  <div class="roomInsertItem"><input type="text" id="roomName" name="roomName"></div>
                  
                  <div class="roomInsertItem">인원 설정</div>
                  <div class="roomInsertItem">
                     기준인원 <input type="number" class="intInsert" id="basicNum" min="0" step="1" required="required" name="basicNum">명 / 
                     최대인원 <input type="number" class="intInsert" min="0" step="1" required="required"  id="maxNum" name="maxNum">명
                  </div>
                  <div class="roomInsertItem">사진</div>
                  <div class="roomInsertItem">
                     <input type="file">
                  </div>
                  <div class="roomInsertItem">가격정보</div>
                  <div class="roomInsertItem">
                     주중 가격  <input type="text" placeholder="일~목" class="weekPrice" id="weekDayPrice" name="weekDayPrice">원 / 
                     주말 가격  <input type="text" placeholder="금/토" class="weekPrice" id="weekEndPrice" name="weekEndPrice">원
                  </div>
                  <div class="roomInsertItem">추가설명</div>
                  <div class="roomInsertItem"><textarea rows="5" cols="50" style="resize: none" id="roomInfo" name="roomInfo"></textarea> </div>
            </div>
            
         </div>

         <div class="modal-footer" style="align-content: center;">
            <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            <button type="submit" class="btn btn-primary" id="roomInsertConfirmBtn">확인</button>
         </div>
         
         
      </div>
   </div>
   </form>
</div><!-- 객실 추가 모달 끝 -->


<!-- 객실 수정 정보 넘기기 -->
<div>
<form action="roomidforupdate.wei" method="get" id="roomIdForm">
	<input type="hidden" id="roomIdSend" name="roomId">
</form>
</div>

<!-- 객실 수정 모달  -->
<div class="modal fade" id="roomUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
<form action="roomupdate.wei" method="get" id="roomUpdateForm">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
            <h3 class="modal-title" id="myModalLabel" style="text-align: center">객실 수정</h3>
         </div>
      
         <div class="modal-body">
            <!-- 객실수정 폼 -->
            <div class="roomInsertMain">
                  <div class="roomInsertItem">유형선택</div>
                  <input type="hidden" id="roomIdUpdate" name="roomIdUpdate">
                  <div class="roomInsertItem">
                     	<label><input type="radio" name="roomTypeNum" value="91" class="roomTypeNum" id="91">오토캠핑 </label>
                        <label><input type="radio" name="roomTypeNum" value="92" class="roomTypeNum" id="92">글램핑 </label>
                        <label><input type="radio" name="roomTypeNum" value="93" class="roomTypeNum" id="93">카라반 </label>
                        <label><input type="radio" name="roomTypeNum" value="94" class="roomTypeNum" id="94">차박 </label>
                  </div>
                  
                  <div class="roomInsertItem">객실이름</div>
                  <div class="roomInsertItem"><input type="text" id="roomNameUpdate" name="roomNameUpdate"></div>
                  
                  <div class="roomInsertItem">인원 설정</div>
                  <div class="roomInsertItem">
                     기준인원 <input type="number" class="intInsert" id="basicNumUpdate" min="0" step="1" required="required" name="basicNumUpdate">명 / 
                     최대인원 <input type="number" class="intInsert" min="0" step="1" required="required"  id="maxNumUpdate" name="maxNumUpdate">명
                  </div>
                  <div class="roomInsertItem">사진</div>
                  <div class="roomInsertItem">
                     <input type="file">
                  </div>
                  <div class="roomInsertItem">가격정보</div>
                  <div class="roomInsertItem">
                     주중 가격  <input type="text" placeholder="일~목" class="weekPrice" id="weekDayPriceUpdate" name="weekDayPriceUpdate">원 / 
                     주말 가격  <input type="text" placeholder="금/토" class="weekPrice" id="weekEndPriceUpdate" name="weekEndPriceUpdate">원
                  </div>
                  <div class="roomInsertItem">추가설명</div>
                  <div class="roomInsertItem"><textarea rows="5" cols="50" style="resize: none" id="roomInfoUpdate" name="roomInfoUpdate"></textarea> </div>
            </div>
            
         </div>

         <div class="modal-footer" style="align-content: center;">
            <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            <button type="submit" class="btn btn-primary" id="roomInsertConfirmBtn">확인</button>
         </div>
         
         
      </div>
   </div>
   </form>
</div><!-- 객실 수정 모달 끝 -->


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
	
	
	//차트 그리기 옵션1
	var context = document
	    .getElementById('myChart1')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'horizontalBar', // 차트의 형태
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
	    	//responsive: false,
	        scales: {
	        	xAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true,
	                        min: 0,
	                        //suggestedMin: 0,
							max: 5,
							stepSize : 0.5
	                    }
	                }
	            ],
	            yAxes: [
	                {
	                    ticks: {
	                    	beginAtZero: true,
	                    	//min: 0,
	                    	//suggestedMin: 0,
							//max: 5,
							//stepSize : 0.1,
							barPercentage: 0.3
	                    }
	                }
	            ]
	        }
	    	, title: {
	            display: true,
	            text: '편의시설',
	        }
	    	, legend: {
	    	      display: false
	    	}
	    	, layout: {
	            padding: 20
	        }
	    }
	});
	
	
	// 차트 그리기 옵션2
	var context = document
	    .getElementById('myChart2')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'horizontalBar', 	// 차트의 형태
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
	    	//responsive: false,
	        scales: {
	        	xAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true,
	                        min: 0,
	                        //suggestedMin: 0,
							max: 5,
							stepSize : 0.5
	                    }
	                }
	            ],
	            yAxes: [
	                {
	                    ticks: {
	                        beginAtZero: true,
	                        //min: 0,
	                        //suggestedMin: 0,
							//max: 5,
							//stepSize : 0.1
	                        barPercentage: 0.3
	                    }
	                }
	            ]
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
	    	responsive: false,
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
	    	responsive: false,
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
	    	responsive: false,
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