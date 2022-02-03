<%@page import="com.campick.dto.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// AjaxPartnerBookingList.jsp
	ArrayList<BookingDTO> lists = (ArrayList<BookingDTO>) request.getAttribute("lists");
	String num = (String) session.getAttribute("num");
	
	String result = "";
	
	for(BookingDTO booking : lists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"id\":\"" + booking.getBookingNum() +"\"");
		sb.append(", \"title\":\"" + booking.getRoomName() +"\"");
		sb.append(", \"start\":\"" + booking.getCheckInDate() +"\"");
		sb.append(", \"end\":\"" + booking.getCheckOutDate() + "\"");
		
		// 예약 마감인 경우 이벤트 타이틀 색을 회색으로 표시
		if(booking.getBookingNum().substring(0, 1).equals("P"))
			sb.append(", \"color\":\"#c4c4c4\"");
		else
			sb.append(", \"color\":\"#45818e\"");
		
		sb.append(", \"allDay\":\"" + true + "\"},");
		
		result += sb.toString();
	}
	
	result = result.substring(0, result.length()-1);
	
	result = "[" + result + "]";
			
	out.println(result);
%>
