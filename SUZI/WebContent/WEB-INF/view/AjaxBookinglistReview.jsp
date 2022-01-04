<%@page import="com.campick.dto.ReviewDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// AjaxBookinglistReview.jsp
	
	
	ReviewDTO review = (ReviewDTO)request.getAttribute("review");
		
	String result = "";
	
	if(review.getBookingNum().equals("0"))
	{
		result += "{\"bookingNum\":\"" + review.getBookingNum() + "\"";
		result += ",\"checkMonth\":\"" + review.getCheckMonth() + "\"}";
	}
	else
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"contentNum\":\"" + review.getContentNum() + "\"");
		sb.append(",\"bookingNum\":\"" + review.getBookingNum() + "\"");
		sb.append(",\"campgroundId\":\"" + review.getCampgroundId() + "\"");
		sb.append(",\"firewood\":\"" + review.getFireWood() + "\"");
		sb.append(",\"camperId\":\"" + review.getCamperId() + "\"");
		sb.append(",\"createDate\":\"" + review.getCreateDate() + "\"");
		sb.append(",\"checkInDate\":\"" + review.getCheckInDate() + "\"");
		sb.append(",\"content\":\"" + review.getContent() + "\"");
		sb.append(",\"memberNum\":\"" + review.getMemberNum() + "\"");
		sb.append(",\"replyNum\":\"" + review.getReplyNum() + "\"");
		sb.append(",\"reply\":\"" + review.getReply() + "\"");
		sb.append(",\"replyCreateDate\":\"" + review.getReplyCreateDate() + "\"}");
		
		
		result += sb.toString();
	}
	
	out.println(result);

%>
