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
<title>MyCampgroundInfo.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/RoomInsertFormModal.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MyCampgroundInfoInsert.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script>

	function count_ck_comfort(obj)
	{
		var chkbox = document.getElementsByName("comforts");
		var chkCnt = 0;
	
		for(var i=0;i<chkbox.length; i++)
		{
			if(chkbox[i].checked)
				chkCnt++;
		}
	
		if(chkCnt>5)
		{
			alert("최대 5까지 선택가능합니다.");
			obj.checked = false;
			return false;
		}
	}
	
	function count_ck_fun(obj)
	{
		var chkbox = document.getElementsByName("fun");
		var chkCnt = 0;
	
		for(var i=0;i<chkbox.length; i++)
		{
			if(chkbox[i].checked)
				chkCnt++;
		}
	
		if(chkCnt>5)
		{
			alert("최대 5까지 선택가능합니다.");
			obj.checked = false;
			return false;
		}
	}

    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    }; 
    
    /* 사진파일올릴때보이는거,,,,  */
    function setThumbnail(event) 
    { 
    	var reader = new FileReader();
    	reader.onload = function(event){ 
    		var img = document.createElement("img");
    		img.setAttribute("src", event.target.result);
    		document.querySelector("#image_container").appendChild(img);};
    	reader.readAsDataURL(event.target.files[0]); 
    }
    
    
    function campgroundInsert()
	{
        var chkArray = new Array(); // 배열 선언
 
        $('input:checkbox[name=comforts]:checked').each(function() 	// 체크된 체크박스의 value 값을 가지고 온다.
        { 
            chkArray.push(this.value);
        });
        
        $('input:checkbox[name=fun]:checked').each(function()
		{
        	chkArray.push(this.value);
		});
        
        $('#hiddenValue').val(chkArray);
        
        //alert($('#hiddenValue').val()); 
        
        var campgroundName = $("#campgroundNameInput").val();
        var checkInDate = $("#checkInDate").val();
        var checkOutDate = $("#checkOutDate").val();
        var policyStandard1 = $("#policyStandard1").val();
        var policyStandard2 = $("#policyStandard2").val();
        var policyStandard3 = $("#policyStandard3").val();
        var option = $('#hiddenValue').val();
        var address1 = $("#sample6_address").val();
        var address2 = $("#sample6_extraAddress").val();
        var address3 = $("#sample6_detailAddress").val();
        var tel = $("#tel").val();
        var extraInfo = $("#extraInfo").val();
        
       	alert(campgroundName);
        
        
        $("#campgroundForm").submit();

	}

    
</script>

</head>
<body>

<div class="campgroundInsertTitle">
	<h1> 캠 핑 장 등 록 </h1>
</div>

<div class="campgroundInsertMain">
	<form action="mycampgroundinsert.wei" method="post" id="campgroundForm">
		<div class="campgroundInsertItem" id="campgroundName">캠핑장명(*)</div>            
		<div class="campgroundInsertItem" id="campgroundNameValue">	
			<input type="text" class="textValue" required="required" id="campgroundNameInput" name="campgroundNameInput">
		</div>
		
		<div class="campgroundInsertItem" id="checkIn-Out">입퇴실 시간 설정(*)</div>
		<div class="campgroundInsertItem" id="checkIn-OutValue"> 
			입실시간 <input type="number" class="intInsert" min="0" max="23" step="1" required="required" id="checkInDate" name="checkInDate">시 <br>
			퇴실시간 <input type="number" class="intInsert" min="0" max="23" step="1" required="required" id="checkOutDate" name="checkOutDate">시 <br>
			<span class="notice">※ 시간단위로 입력가능합니다.</span>
		</div>
		
		<div class="campgroundInsertItem" id="refund">환불규정(*)</div>
		<div class="campgroundInsertItem" id="refundValue">
			<div class="item-refund">
				<div class="refund">예약일 기준으로부터</div>
				<div class="refund">예약 당일 ~ 3일 전</div>
				<div class="refund">결제금액의 
					<input type="number" class="intInsert" min="0" max="50" step="5" placeholder="0~50" required="required" id="policyStandard1"> 
					 % 공제 후 환불</div>
				<div class="refund">4일 전 ~ 9일 전</div>
				<div class="refund">결제금액의 
					 <input type="number" class="intInsert" min="0" max="20" step="5" placeholder="0~20" required="required" id="policyStandard2"> 
					 % 공제 후 환불</div>
				<div class="refund">10일 이후</div>
				<div class="refund">결제금액의 
					<input type=text class="intInsert"  value="0" readonly="readonly" id="policyStandard3">
					 % 공제 후 환불</div>
				<div class="refund notice">※ 가이드라인을 벗어난 공제율은 작성이 불가합니다.</div>
			</div>
		</div>
		
		
		<!-- <div class="campgroundInsertItem" id="roomInsert">객실추가(*)</div>
		<div class="campgroundInsertItem" id="roomInsertValue">
			<div class="item-room">
				<div class="room">
					<button type="button" id="roomInsertBtn" data-toggle="modal" data-target="#roomInsertModal">객실추가</button>
				</div>
				
				여기 Ajax로 받아야될거같다용~!~!~!~!
				<div class="room">
					<div class="roomInsertSuccess">객실사진</div>
					<div class="roomInsertSuccess">객실이름</div>
					<div class="roomInsertSuccess">
						<button type="button" class="roomInsertSuccessBtn">수정</button>
						<button type="button" class="roomInsertSuccessBtn">삭제</button>
					</div>
				</div>
			</div>
		</div> -->
		
		<div class="campgroundInsertItem" id="comforts">
			<div style="display: block;">
				<span>편의시설 선택</span><br>
				(최대 5개 선택 가능)
			</div>
		</div>
		<div class="campgroundInsertItem" id="comfortsValue" >
			<label><input type="checkbox" name="comforts" id="shower" onclick="count_ck_comfort(this)" value="1">샤워시설</label>
			<label><input type="checkbox" name="comforts" id="sink" onclick="count_ck_comfort(this)" value="2">개수대</label>
			<label><input type="checkbox" name="comforts" id="store" onclick="count_ck_comfort(this)" value="3">매점</label>
			<label><input type="checkbox" name="comforts" id="wifi" onclick="count_ck_comfort(this)" value="4">와이파이</label>
			<label><input type="checkbox" name="comforts" id="electricity" onclick="count_ck_comfort(this)" value="5">전기</label>
			<label><input type="checkbox" name="comforts" id="parking-lot" onclick="count_ck_comfort(this)" value="6">주차장</label>
			<label><input type="checkbox" name="comforts" id="animal-companion" onclick="count_ck_comfort(this)" value="7">반려동물 동반</label>
			<label><input type="checkbox" name="comforts" id="cafe" onclick="count_ck_comfort(this)" value="8">카페</label>
			<label><input type="checkbox" name="comforts" id="firewood" onclick="count_ck_comfort(this)" value="9">장작판매</label><br>
			<label><input type="checkbox" name="comforts" id="equipment-rental" onclick="count_ck_comfort(this)" value="10">캠핑용품 대여</label>
			<label><input type="checkbox" name="comforts" id="toilet" onclick="count_ck_comfort(this)" value="11">수세식 화장실</label>
			<label><input type="checkbox" name="comforts" id="outhouse" onclick="count_ck_comfort(this)" value="12">재래식 화장실</label>
			<label><input type="checkbox" name="comforts" id="disabled-facilities" onclick="count_ck_comfort(this)" value="13">장애인 편의시설</label>
			<label><input type="checkbox" name="comforts" id="hotwater" onclick="count_ck_comfort(this)" value="14">온수제공</label>
			<label><input type="checkbox" name="comforts" id="children-playground" onclick="count_ck_comfort(this)" value="15">어린이 놀이터</label>
			
		</div>
		
		<div class="campgroundInsertItem" id="entertain">
			<div style="display: block;">
				<span>즐길거리 선택</span><br>
				(최대 5개 선택 가능)
			</div>
		</div>
		<div class="campgroundInsertItem" id="entertainValue">
			<label><input type="checkbox" name="fun" id="pool" onclick="count_ck_fun(this)" value="16">물놀이</label><br>
			<label><input type="checkbox" name="fun" id="sports facilities" onclick="count_ck_fun(this)" value="17">체육시설</label><br>
			<label><input type="checkbox" name="fun" id="lawnplaza" onclick="count_ck_fun(this)" value="18">잔디광장</label><br>
			<label><input type="checkbox" name="fun" id="stars" onclick="count_ck_fun(this)" value="19">별</label><br>
			<label><input type="checkbox" name="fun" id="fishing" onclick="count_ck_fun(this)" value="20">낚시</label><br>
			<label><input type="checkbox" name="fun" id="program" onclick="count_ck_fun(this)" value="21">체험프로그램</label><br>
			<label><input type="checkbox" name="fun" id="atv" onclick="count_ck_fun(this)" value="22">ATV</label><br>
			<label><input type="checkbox" name="fun" id="zip-line" onclick="count_ck_fun(this)" value="23">짚라인</label><br>
			<label><input type="checkbox" name="fun" id="bike" onclick="count_ck_fun(this)" value="24">자전거대여</label><br>
			<input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>

		</div>
		
		<div class="campgroundInsertItem" id="campgroundAddr">캠핑장 주소(*)</div>		
		<div class="campgroundInsertItem">
			<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기" required="required">
			<input type="hidden" id="sample6_postcode" placeholder="우편번호"><br>
			<input type="text" id="sample6_address" placeholder="주소" style="width: 200px;" readonly="readonly">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly="readonly"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소">
		</div>
			
		<div class="campgroundInsertItem" id="phone">대표번호(*)</div>
		<div class="campgroundInsertItem" id="phoneValue">	
			<input type="tel" class="textValue" required="required" id="tel">	
		</div>
		
		<div class="campgroundInsertItem" id="campgroundPhoto">캠핑장 대표 사진</div>
			
		<div class="campgroundInsertItem" id="campgroundPhotoValue">
			<input type="file" id="image" accept="image/*" onchange="setThumbnail(event);">
			<div id="image_container"> </div>
		</div>
		
		<div class="campgroundInsertItem" id="campgroundExtraInfo">캠핑장 추가 정보</div>
		
		<div class="campgroundInsertItem" id="campgroundExtraInfoValue"> 
			<textarea rows="5" cols="90" class="textValue" style="resize: none;" id="extraInfo"></textarea>
		</div>
		
		<div class="campgroundInsertItem" id="campgroundEvent">캠핑장 이벤트</div>
		
		<div class="campgroundInsertItem" id="campgroundEventValue"> 
			<textarea rows="5" cols="90" class="textValue" style="resize: none;" id="event"></textarea>
		</div>
		
		<div class="campgroundInsertItem">
			<button type="reset" class="btn">초기화</button>
			<button type=button class="btn" onclick="campgroundInsert()">등록</button>
		</div>
	</form>
</div>                


<!-- 여기서부터 모달 -->
<div class="modal fade" id="roomInsertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
						<div class="roomInsertItem">
							<label><input type="radio" name="roomType" value="91">오토캠핑 </label>
      						<label><input type="radio" name="roomType" value="92">글램핑 </label>
      						<label><input type="radio" name="roomType" value="93">카라반 </label>
      						<label><input type="radio" name="roomType" value="94">차박 </label>
						</div>
						
						<div class="roomInsertItem">객실이름</div>
						<div class="roomInsertItem"><input type="text" id="roomNameValue"></div>
						
						<div class="roomInsertItem">인원 설정</div>
						<div class="roomInsertItem">
							기준인원 <input type="number" class="intInsert" id="basicNumValue" min="0" step="1" required="required" >명 / 
							최대인원 <input type="number" class="intInsert" min="0" step="1" required="required" id="maxNumValue">명
						</div>
						<div class="roomInsertItem">사진</div>
						<div class="roomInsertItem">
							<input type="file">
						</div>
						<div class="roomInsertItem">가격정보</div>
						<div class="roomInsertItem">
							주중 가격  <input type="text" placeholder="일~목" class="weekPrice" id="weekDayPriceValue">원 / 
							주말 가격  <input type="text" placeholder="금/토" class="weekPrice" id="weekEndPriceValue">원
						</div>
						<div class="roomInsertItem">추가설명</div>
						<div class="roomInsertItem"><textarea rows="5" cols="50" style="resize: none" id="roomInfo"></textarea> </div>
				</div>
			</div>

			<div class="modal-footer" style="align-content: center;">
				<button type="button" class="btn btn-primary" id="roomInsertConfirmBtn" onclick="roomInsertInfo()">확인</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
			
			
		</div>
	</div>
</div>


</body>
</html>