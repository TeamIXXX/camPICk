<%@page import="com.campick.dto.BookingDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	BookingDTO bookingDTO = (BookingDTO) request.getAttribute("bookingDTO");
	
	String result = "";
	StringBuffer sb = new StringBuffer();
	
	sb.append("{\"bookingNum\":\"" + bookingDTO.getBookingNum() + "\"");
	sb.append(",\"roomName\":\"" + bookingDTO.getRoomName() + "\"");
	sb.append(",\"campgroundName\":\"" + bookingDTO.getCampgroundName() + "\"");
	sb.append(",\"name\":\"" + bookingDTO.getName() + "\"");
	sb.append(",\"phone\":\"" + bookingDTO.getPhone() + "\"");
	sb.append(",\"checkInDate\":\"" + bookingDTO.getCheckInDate() + "\"");
	sb.append(",\"checkOutDate\":\"" + bookingDTO.getCheckOutDate() + "\"");
	sb.append(",\"visitNum\":\"" + bookingDTO.getVisitNum() + "\"");
	sb.append(",\"paymentAmount\":\"" + bookingDTO.getPaymentAmount()+ "\"");
	sb.append(",\"request\":\"" + bookingDTO.getRequest()+ "\"");
	sb.append(",\"bookingDate\":\"" + bookingDTO.getBookingDate() + "\"}");
	
	result += sb.toString();

%>
<%=result%>