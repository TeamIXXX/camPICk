<%@page import="com.campick.dto.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// AjaxPartnerDailyBookingList.jsp
	ArrayList<BookingDTO> lists = (ArrayList<BookingDTO>) request.getAttribute("lists");
	
	String result = "";
	
	for(BookingDTO booking : lists)
	{
		StringBuffer sb = new StringBuffer();
		sb.append("{\"bookingNum\":\"" + booking.getBookingNum() +"\"");
		sb.append(", \"roomId\":\"" + booking.getRoomId() +"\"");
		sb.append(", \"roomName\":\"" + booking.getRoomName() +"\"");
		sb.append(", \"name\":\"" + booking.getName() +"\"");
		sb.append(", \"phone\":\"" + booking.getPhone() +"\"");
		sb.append(", \"visitNum\":\"" + booking.getVisitNum() + "\"");
		sb.append(", \"checkInDate\":\"" + booking.getCheckInDate() +"\"");
		sb.append(", \"checkOutDate\":\"" + booking.getCheckOutDate() + "\"},");
		
		result += sb.toString();
	}
	
	result = result.substring(0, result.length()-1);
	
	result = "[" + result + "]";
			
	out.println(result);
%>
