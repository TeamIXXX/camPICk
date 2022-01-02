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
<title>loginNeed.jsp</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
 
 <script type="text/javascript">

$(function()
{
	$('#limitModal').modal('show');

	$('#limitModal').on('hidden.bs.modal', function()
	{
		//alert("확인");
		window.history.back();	
	}); 
	 
	
	
});

 
</script>
    <style>
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 30%; /* Could be more or less, depending on screen size */                          
        }
 
</style>
 
 
 
    <!-- The Modal -->
    <div id="limitModal" class="modal" >
      <!-- Modal content -->
      <div class="modal-content">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">경고</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><br /></p>
                <p style="text-align: center; line-height: 1.5;"><b><span style="color: black; font-size: 14pt;">접근할 수 없는 메뉴입니다.</span></b></p>
                <p><br /></p>
          
          <div class="modal-footer" style="align-content: center;">
					<button type="button" id="Btn_limit" class="btn btn-default" data-dismiss="modal">닫기</button>
		  </div>
          
      </div>
 
    </div>
        <!--End Modal-->
 
 
 
 


