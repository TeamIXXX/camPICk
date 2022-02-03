<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String arrMonth = (String) request.getAttribute("arrMonth");
	String arr91 = (String) request.getAttribute("arr91");
	String arr92 = (String) request.getAttribute("arr92");
	String arr93 = (String) request.getAttribute("arr93");
	String arr94 = (String) request.getAttribute("arr94");
	
	String result = "";
	/* 
	String[] arr91 = (String[]) request.getAttribute("arr91");
	String[] arr92 = (String[]) request.getAttribute("arr92");
	String[] arr93 = (String[]) request.getAttribute("arr93");
	String[] arr94 = (String[]) request.getAttribute("arr94");
	
	
	StringBuffer sb = new StringBuffer();
	
	sb.append("\"arr91\":[");
	for (int i=0; i<=11 ; i++)
		sb.append("\"" + arr91[i] + "\",");
	// 마지막 , 제거
	sb = sb.deleteCharAt(sb.length()-1);	 
	sb.append("],");
	
	sb.append("\"arr92\":[");
	for (int i=0; i<=11 ; i++)
		sb.append("\"" + arr92[i] + "\",");
	sb = sb.deleteCharAt(sb.length()-1);
	sb.append("],");
	
	sb.append("\"arr93\":[");
	for (int i=0; i<=11 ; i++)
		sb.append("\"" + arr93[i] + "\",");
	sb = sb.deleteCharAt(sb.length()-1);
	sb.append("],");
	
	sb.append("\"arr94\":[");
	for (int i=0; i<=11 ; i++)
		sb.append("\"" + arr94[i] + "\",");
	sb = sb.deleteCharAt(sb.length()-1);
	sb.append("]");
	
	result = "{" + sb.toString() + "}";
	*/
	
	result += "{\"arrMonth\":" + arrMonth;
	result += ",\"arr91\":" + arr91;
	result += ",\"arr92\":" + arr92;
	result += ",\"arr93\":" + arr93;
	result += ",\"arr94\":" + arr94 + "}";

%>
<%=result%>