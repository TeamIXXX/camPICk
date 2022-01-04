<%@page import="java.util.ArrayList"%>
<%@page import="com.campick.dto.RoomDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	ArrayList<RoomDTO> roomTypeLists = (ArrayList<RoomDTO>)request.getAttribute("roomTypeList");
	
	String result = "";
	
	for(RoomDTO roomTypeList : roomTypeLists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"roomId\":\"" + roomTypeList.getRoomId() +"\"");
		sb.append(",\"roomName\":\"" + roomTypeList.getRoomName() +"\"");
		sb.append(",\"basicNum\":\"" + roomTypeList.getBasicNum() +"\"");
		sb.append(",\"maxNum\":\"" + roomTypeList.getMaxNum() +"\"");
		sb.append(",\"weekDayPrice\":\"" + roomTypeList.getWeekDayPrice() +"\"");
		sb.append(",\"weekEndPrice\":\"" + roomTypeList.getWeekEndPrice() +"\"");
		sb.append(",\"roomInfo\":\"" + roomTypeList.getRoomInfo() +"\"");
		sb.append(",\"roomTypeName\":\"" + roomTypeList.getRoomTypeName() +"\"},");
		
		result += sb.toString();
	}
	
	result = result.substring(0, result.length()-1);
	
	result = "[" + result + "]";
	
	out.println(result);
%>
