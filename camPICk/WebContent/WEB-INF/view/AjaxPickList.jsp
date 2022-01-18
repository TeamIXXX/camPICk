<%@page import="com.campick.dto.CampgroundDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	ArrayList<CampgroundDTO> lists = (ArrayList<CampgroundDTO>) request.getAttribute("lists");
	
	String result = "";
	
	for(CampgroundDTO dto : lists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"campgroundName\":\"" + dto.getCampgroundName() +"\"");
		sb.append(", \"campgroundId\":\"" + dto.getCampgroundId() + "\"");
		sb.append(", \"address\":\"" + dto.getAddress1() + " " + dto.getAddress2() + " " + dto.getAddress3() + "\"");
		sb.append(", \"extraInfo\":\"" + dto.getExtraInfo() + "\"");
		sb.append(", \"pick\":\"" + dto.getPick() + "\"");
		sb.append(", \"firewood\":\"" + dto.getFirewood() + "\"");
		sb.append(", \"review\":\"" + dto.getReview() + "\"},");
		
		result += sb.toString();
	}
	
	result = result.substring(0, result.length()-1);
	
	result = "[" + result + "]";
			
	out.println(result);
%>
