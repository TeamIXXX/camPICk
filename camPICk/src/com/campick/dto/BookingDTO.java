/*======================================
	BookingDTO.java
	예약 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class BookingDTO
{
	private String bookingNum, roomId, roomName, campgroundId, campgroundName;
	private String memberNum, name, phone;
	private String checkInDate, checkOutDate;	
	private int visitNum, paymentAmount;				
	private String request, bookingDate, status;
	private int reviewCheck;
	
	// 김진령 getter / setter 구성
	public int getReviewCheck()
	{
		return reviewCheck;
	}
	public void setReviewCheck(int reviewCheck)
	{
		this.reviewCheck = reviewCheck;
	}
	
	// getter / setter 구성
	public String getBookingNum()
	{
		return bookingNum;
	}
	public void setBookingNum(String bookingNum)
	{
		this.bookingNum = bookingNum;
	}
	public String getRoomId()
	{
		return roomId;
	}
	public void setRoomId(String roomId)
	{
		this.roomId = roomId;
	}
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	public String getRoomName()
	{
		return roomName;
	}
	public void setRoomName(String roomName)
	{
		this.roomName = roomName;
	}
	public String getCampgroundName()
	{
		return campgroundName;
	}
	public void setCampgroundName(String campgroundName)
	{
		this.campgroundName = campgroundName;
	}
	public String getMemberNum()
	{
		return memberNum;
	}
	public void setMemberNum(String memberNum)
	{
		this.memberNum = memberNum;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setPhone(String phone)
	{
		this.phone = phone;
	}
	public String getCheckInDate()
	{
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate)
	{
		this.checkInDate = checkInDate;
	}
	public String getCheckOutDate()
	{
		return checkOutDate;
	}
	public void setCheckOutDate(String checkOutDate)
	{
		this.checkOutDate = checkOutDate;
	}
	public int getVisitNum()
	{
		return visitNum;
	}
	public void setVisitNum(int visitNum)
	{
		this.visitNum = visitNum;
	}
	public int getPaymentAmount()
	{
		return paymentAmount;
	}
	public void setPaymentAmount(int paymentAmount)
	{
		this.paymentAmount = paymentAmount;
	}
	public String getRequest()
	{
		return request;
	}
	public void setRequest(String request)
	{
		this.request = request;
	}
	public String getBookingDate()
	{
		return bookingDate;
	}
	public void setBookingDate(String bookingDate)
	{
		this.bookingDate = bookingDate;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
}
