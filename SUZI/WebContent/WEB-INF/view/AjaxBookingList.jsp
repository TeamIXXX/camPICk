<%@page import="com.campick.dto.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	ArrayList<BookingDTO> lists = (ArrayList<BookingDTO>) request.getAttribute("lists");
	
	String result = "";
	
	for(BookingDTO booking : lists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"campgroundName\":\"" + booking.getCampgroundName() +"\"");
		sb.append(", \"campgroundId\":\"" + booking.getCampgroundId() +"\"");
		sb.append(", \"bookingDate\":\"" + booking.getBookingDate() + "\"");
		sb.append(", \"checkInDate\":\"" + booking.getCheckInDate() + "\"");
		sb.append(", \"checkOutDate\":\"" + booking.getCheckOutDate() + "\"");
		sb.append(", \"bookingNum\":\"" + booking.getBookingNum() + "\"");
		sb.append(", \"status\":\"" + booking.getStatus() + "\"},");
		
		result += sb.toString();
	}
	
	result = result.substring(0, result.length()-1);
	
	result = "[" + result + "]";
			
	out.println(result);
	
%>
