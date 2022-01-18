<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// AjaxCheckPartnerPw.jsp

	int result = (int)request.getAttribute("result");
	//System.out.println(result);
	
	out.println("{\"result\":\"" + result + "\"}");
%>
