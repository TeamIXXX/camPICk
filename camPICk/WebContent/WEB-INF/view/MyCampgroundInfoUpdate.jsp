<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.campick.dto.OptionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	ArrayList<OptionDTO> comfortsList = (ArrayList)request.getAttribute("comfortsList");
	ArrayList<OptionDTO> funList = (ArrayList)request.getAttribute("funList");
	
	StringBuffer comfortsNumList = new StringBuffer();
	for(int i=0; i<comfortsList.size(); i++)
	{
		comfortsNumList.append("'" + comfortsList.get(i).getOptionNum() + "', ");
	}
	comfortsNumList.delete(comfortsNumList.lastIndexOf(","), comfortsNumList.length());
	
	StringBuffer funNumList = new StringBuffer();
	for(int i=0; i<funList.size(); i++)
	{
		funNumList.append("'" + funList.get(i).getOptionNum() + "', ");
	}
	funNumList.delete(funNumList.lastIndexOf(","), funNumList.length());
	
	
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
	
	$(function()
	{
		//debugger;
		// 페이지가 로드될 때, 해당 캠핑장이 가지고 있는 옵션항목에 checked 속성 추가
		var comfortsNumList = [<%=comfortsNumList%>];
		var funNumList = [<%=funNumList%>];
		
		for (var i = 0; i < comfortsNumList.length; i++)
			$('input:checkbox[value="'+comfortsNumList[i]+'"]').attr("checked", true);
		
		for (var i = 0; i < funNumList.length; i++)
			$('input:checkbox[value="'+funNumList[i]+'"]').attr("checked", true);
		
		
		// 대표 번호 대쉬(-) 자동삽입
		$("#tel").keyup(function()
		{
			$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-"));
		});
		
		
		$("#submitBtn").click(function()
		{
			var comfortsStr = "";
			var funStr = "";
			$("input:checkbox[name=comforts]:checked").each(function()
			{
				comfortsStr += $(this).val() + ",";
			});
			
			$("input:checkbox[name=fun]:checked").each(function()
			{
				funStr += $(this).val() + ",";
			});
			
			comfortsStr = comfortsStr.replace(/,$/, '');
			funStr = funStr.replace(/,$/, '');
			//alert(comfortsStr + " / " + funStr);
			
			$("#comfortsList").val(comfortsStr);
			$("#funList").val(funStr);
			//alert($("#comfortsList").val() + " / " + $("#funList").val());
			
			if (confirm("캠핑장을 수정하시겠습니까?"))
			{
				$("#campgroundForm").submit();
			};
		});
		
	});
	
	
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
    

    /*
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
        
       	//alert(typeof option);
                
        $("#campgroundForm").attr("action","mycampgroundinsert.wei?name="+campgroundName+"&checkin="+checkInDate+"&checkout="+checkOutDate
        							+"&ps1="+policyStandard1+"&ps2="+policyStandard2+"&ps3="+policyStandard3+"&option="+option
        							+"&ad1="+address1+"&ad2="+address2+"&ad3="+address3+"&tel="+tel+"&extra="+extraInfo); 
        							
       	//$("#campgroundForm").attr("action","mycampgroundinsert.wei");
	}
    */
    
  
</script>

</head>
<body>

<div class="campgroundInsertTitle">
	<h1> 캠 핑 장 수 정 </h1>
</div>

<div class="campgroundInsertMain">
	<form action="mycampgroundupdate.wei" method="post" id="campgroundForm" enctype="multipart/form-data">
		<div class="campgroundInsertItem" id="campgroundNameInput">캠핑장명(*)</div>            
		<div class="campgroundInsertItem" id="campgroundNameValue">	
			<input type="hidden" name="campgroundId" value="${myCampgroundInfo.campgroundId }">
			<input type="text" class="textValue" required="required" id="campgroundNameInput" name="campgroundName" value="${myCampgroundInfo.campgroundName }">
		</div>
		
		<div class="campgroundInsertItem" id="checkIn-Out">입퇴실 시간 설정(*)</div>
		<div class="campgroundInsertItem" id="checkIn-OutValue"> 
			입실시간 <input type="number" class="intInsert" min="0" max="23" step="1" required="required" id="checkInDate" name="checkInDate" value="${myCampgroundInfo.checkInDate }">시 <br>
			퇴실시간 <input type="number" class="intInsert" min="0" max="23" step="1" required="required" id="checkOutDate" name="checkOutDate" value="${myCampgroundInfo.checkOutDate }">시 <br>
			<span class="notice">※ 시간단위로 입력가능합니다.</span>
		</div>
		
		<div class="campgroundInsertItem" id="refund">환불규정(*)</div>
		<div class="campgroundInsertItem" id="refundValue">
			<div class="item-refund">
				<div class="refund">예약일 기준으로부터</div>
				<div class="refund">예약 당일 ~ 3일 전</div>
				<div class="refund">결제금액의 
					<input type="number" class="intInsert" name="policyStandard1" min="0" max="${guidStandardInfo.guideStandard1 }" step="5" placeholder="0~${guidStandardInfo.guideStandard1 }" required="required" id="policyStandard1" value="${myCampgroundInfo.policyStandard1 }"> 
					 % 공제 후 환불</div>
				<div class="refund">4일 전 ~ 9일 전</div>
				<div class="refund">결제금액의 
					 <input type="number" class="intInsert" name="policyStandard2" min="0" max="${guidStandardInfo.guideStandard2 }" step="5" placeholder="0~${guidStandardInfo.guideStandard2 }" required="required" id="policyStandard2" value="${myCampgroundInfo.policyStandard2 }"> 
					 % 공제 후 환불</div>
				<div class="refund">10일 이후</div>
				<div class="refund">결제금액의 
					<input type="number" class="intInsert" name="policyStandard3" min="0" max="${guidStandardInfo.guideStandard3 }" step="5" placeholder="0~${guidStandardInfo.guideStandard3 }" required="required" id="policyStandard3" value="${myCampgroundInfo.policyStandard3 }">
					 % 공제 후 환불</div>
				<div class="refund notice">※ 가이드라인을 벗어난 공제율은 작성이 불가합니다.</div>
			</div>
		</div>
		
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
			<input type="hidden" name="comfortsList" id="comfortsList" value=""/>
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
			<input type="hidden" name="funList" id="funList" value=""/>
		</div>
		
		<div class="campgroundInsertItem" id="campgroundAddr">캠핑장 주소(*)</div>		
		<div class="campgroundInsertItem">
			<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기" required="required">
			<input type="hidden" id="sample6_postcode" placeholder="우편번호"><br>
			<input type="text" id="sample6_address" placeholder="주소" style="width: 200px;" name="address1" value="${myCampgroundInfo.address1 }">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="address2" value="${myCampgroundInfo.address2 }"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address3" value="${myCampgroundInfo.address3 }">
		</div>
			
		<div class="campgroundInsertItem" id="phone">대표번호(*)</div>
		<div class="campgroundInsertItem" id="phoneValue">	
			<input type="tel" class="textValue" required="required" id="tel" name="tel" value="${myCampgroundInfo.tel }">	
		</div>
		
		<div class="campgroundInsertItem" id="campgroundPhoto">캠핑장 대표 사진</div>
			
		<div class="campgroundInsertItem" id="campgroundPhotoValue">
			<input type="file" id="image">
			<div id="image_container"> </div>
		</div>
		
		<div class="campgroundInsertItem" id="campgroundExtraInfo">캠핑장 추가 정보</div>
		
		<div class="campgroundInsertItem" id="campgroundExtraInfoValue"> 
			<textarea rows="5" cols="90" class="textValue" style="resize: none;" name="extraInfo" id="extraInfo">${myCampgroundInfo.extraInfo }</textarea>
		</div>
		<!-- 
		<div class="campgroundInsertItem" id="campgroundEvent">캠핑장 이벤트</div>
		
		<div class="campgroundInsertItem" id="campgroundEventValue"> 
			<textarea rows="5" cols="90" class="textValue" style="resize: none;" id="event"></textarea>
		</div>
		-->
		<div class="campgroundInsertItem">
			<button type="reset" class="btn">초기화</button>
			<button type="button" class="btn" id="submitBtn">수정</button>
		</div>
	</form>
</div>                



</body>
</html>