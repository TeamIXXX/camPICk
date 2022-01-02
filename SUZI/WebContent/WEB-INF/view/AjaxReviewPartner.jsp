<%@page import="com.campick.dto.ReviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// 리뷰리스트, 페이징인덱스 수신한 ajaxReviewPartner.jsp
	
%>
<%

	//ArrayList<ReviewDTO> lists = new ArrayList<ReviewDTO>();

	String pageIndexList = (String)request.getAttribute("pageIndexList");
	
	ArrayList<ReviewDTO> lists = (ArrayList)request.getAttribute("lists");
	
	String result = "";
	
	// [{"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
	//, {"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
	//, {"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
	//, {pageIndexList:""}]
	
	for(ReviewDTO review : lists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"contentNum\":\"" + review.getContentNum() + "\"");
		sb.append(",\"bookingNum\":\"" + review.getBookingNum() + "\"");
		sb.append(",\"firewood\":\"" + review.getFireWood() + "\"");
		sb.append(",\"camperId\":\"" + review.getCamperId() + "\"");
		sb.append(",\"createDate\":\"" + review.getCreateDate() + "\"");
		sb.append(",\"checkInDate\":\"" + review.getCheckInDate() + "\"");
		sb.append(",\"content\":\"" + review.getContent() + "\"");
		sb.append(",\"memberNum\":\"" + review.getMemberNum() + "\"");
		sb.append(",\"replyNum\":\"" + review.getReplyNum() + "\"");
		sb.append(",\"reply\":\"" + review.getReply() + "\"");
		sb.append(",\"replyCreateDate\":\"" + review.getReplyCreateDate() + "\"},");
		
		
		result += sb.toString();
	}
	
	result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>