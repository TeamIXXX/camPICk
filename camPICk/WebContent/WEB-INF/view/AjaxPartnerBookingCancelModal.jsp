<%@page import="com.campick.dto.BookingDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// AjaxPartnerBookingCancelModal.jsp
	BookingDTO booking = (BookingDTO) request.getAttribute("booking");
	
	String result = "";
	
	result += "{\"bookingNum\":\"" + booking.getBookingNum() +"\"";
	result += ", \"roomId\":\"" + booking.getRoomId() +"\"";
	result += ", \"roomName\":\"" + booking.getRoomName() +"\"";
	result += ", \"name\":\"" + booking.getName() +"\"";
	result += ", \"phone\":\"" + booking.getPhone() +"\"";
	result += ", \"visitNum\":\"" + booking.getVisitNum() + "\"";
	result += ", \"paymentAmount\":\"" + booking.getPaymentAmount() + "\"";
	result += ", \"bookingDate\":\"" + booking.getBookingDate() +"\"";
	result += ", \"checkInDate\":\"" + booking.getCheckInDate() +"\"";
	result += ", \"checkOutDate\":\"" + booking.getCheckOutDate() + "\"";
	result += ", \"request\":\"" + booking.getRequest() + "\"";
	result += ", \"refund\":\"" + booking.getRefund() + "\"}";
		
	out.println(result);
%>
