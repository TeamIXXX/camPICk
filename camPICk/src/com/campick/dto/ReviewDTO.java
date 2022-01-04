/*=======================
	ReviewDTO.java
========================*/

package com.campick.dto;

public class ReviewDTO
{
	// 주요 속성 구성
	private String campgroundId, checkInDate, memberNum, createDate, content, camperId;
	private int contentNum, fireWood, replyNum, checkMonth;
	private String reply, replyCreateDate, bookingNum;
	
	// getter / setter 
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	public String getCheckInDate()
	{
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate)
	{
		this.checkInDate = checkInDate;
	}
	public String getMemberNum()
	{
		return memberNum;
	}
	public void setMemberNum(String memberNum)
	{
		this.memberNum = memberNum;
	}
	public String getCreateDate()
	{
		return createDate;
	}
	public void setCreateDate(String createDate)
	{
		this.createDate = createDate;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getCamperId()
	{
		return camperId;
	}
	public void setCamperId(String camperId)
	{
		this.camperId = camperId;
	}
	public int getContentNum()
	{
		return contentNum;
	}
	public void setContentNum(int contentNum)
	{
		this.contentNum = contentNum;
	}
	public int getFireWood()
	{
		return fireWood;
	}
	public void setFireWood(int fireWood)
	{
		this.fireWood = fireWood;
	}
	public String getReply()
	{
		return reply;
	}
	public void setReply(String reply)
	{
		this.reply = reply;
	}
	public String getReplyCreateDate()
	{
		return replyCreateDate;
	}
	public void setReplyCreateDate(String replyCreateDate)
	{
		this.replyCreateDate = replyCreateDate;
	}
	public int getReplyNum()
	{
		return replyNum;
	}
	public void setReplyNum(int replyNum)
	{
		this.replyNum = replyNum;
	}
	public String getBookingNum()
	{
		return bookingNum;
	}
	public void setBookingNum(String bookingNum)
	{
		this.bookingNum = bookingNum;
	}
	public int getCheckMonth()
	{
		return checkMonth;
	}
	public void setCheckMonth(int checkMonth)
	{
		this.checkMonth = checkMonth;
	}
	
	
	
}
