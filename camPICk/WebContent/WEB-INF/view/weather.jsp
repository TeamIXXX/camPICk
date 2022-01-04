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
<title>날씨 테스트중</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">

	
	$(function()
	{
		
		//날씨!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="
				+"seoul"+"&appid="+"d0229fd449ffc2cc60c7d6ca7e70ce0d";
        
		$.ajax({
            url: apiURI
            , dataType: "json"
            , type: "GET"
            , async: "false"
            , success: function(resp) {
            	var out = "";
                console.log(resp);
                console.log("현재온도 : "+ (resp.main.temp- 273.15) );
                console.log("현재습도 : "+ resp.main.humidity);
                console.log("날씨 : "+ resp.weather[0].main );
                console.log("상세날씨설명 : "+ resp.weather[0].description );
                console.log("날씨 이미지 : "+ resp.weather[0].icon );
                console.log("바람   : "+ resp.wind.speed );
                console.log("나라   : "+ resp.sys.country );
                console.log("도시이름  : "+ resp.name );
                console.log("구름  : "+ (resp.clouds.all) +"%" );  
                
                out += "<div class = 'weather'>";
                out += "	<div>온도 : "+ (resp.main.temp- 273.15) +"</div>";
                out += "	<div>날씨 : "+ resp.weather[0].main +"</div>";
                out += "	<div>지역 : "+ resp.name +"</div>";
                out += "	<div>이미지 : "+ resp.weather[0].icon +"</div>";
                out += "</div>	";
                
                $(".mainContentItem").html(out);
            }
			, errer : function(e)
			{
				alert(e.responseText);
			}
			
        });
								
	});

</script>

</head>
<body>

<div class='mainContentContainer'>
	
	
	
	<div class="mainContentItem">
		 <div class = "weather">
		 	<div>온도 : </div>
		 	<div>날씨 : </div>
		 	<div>지역 : </div>
		 	<div>이미지 : </div>
		 </div>	
		 
		 <img src="http://openweathermap.org/img/wn/resp.weather[0].icon"/>
	</div>
	
	                                                         


</div><!-- end mainContentContainer -->


</body>
</html>