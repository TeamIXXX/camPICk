<%@page import="com.campick.dto.CampgroundDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	int listCount = (int)request.getAttribute("listCount");
	//System.out.println(listCount);
	
	if(listCount != 0)
	{
		ArrayList<CampgroundDTO> campgroundList = (ArrayList<CampgroundDTO>)request.getAttribute("campgroundList");
		
		String result = "";
		
		for(CampgroundDTO campground : campgroundList)
		{
			StringBuffer sb = new StringBuffer();
			
			sb.append("{\"campgroundName\":\"" + campground.getCampgroundName() + "\"");
			sb.append(",\"campgroundId\":\"" + campground.getCampgroundId() + "\"");
			sb.append(",\"address1\":\"" + campground.getAddress1() + "\"");
			sb.append(",\"address2\":\"" + campground.getAddress2() + "\"");
			sb.append(",\"address3\":\"" + campground.getAddress3() + "\"");
			sb.append(",\"extrainfo\":\"" + campground.getExtraInfo()+ "\"");
			sb.append(",\"firewood\":\"" + campground.getFirewood() + "\"");
			sb.append(",\"roomtypelist\":\"" + campground.getRoomtypelist() + "\"");
			sb.append(",\"optionlist\":\"" + campground.getOptionlist() + "\"");
			sb.append(",\"themelist\":\"" + campground.getThemelist() + "\"");
			sb.append(",\"pick\":\"" + campground.getPick() + "\"");
			sb.append(",\"review\":\"" + campground.getReview() + "\"},");
			
			result += sb.toString();
		}
	
		
		
		result = result.substring(0, result.length()-1);
		
		result = "[" + result + "]";
		
		out.println(result);
	}
	else
	{
		out.println(listCount);
	}
%>