/*======================================
	CampgroundDTO.java
	캠핑장 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class CampgroundDTO
{
	private String campgroundId, parterNum, campgroundName, signUpDate;
	private String address1, address2, address3, tel;
	private String extraInfo, checkInDate, checkOutDate;
	private String roomtypelist, optionlist, themelist;
	private int pick, share, review;
	private int policyStandard1, policyStandard2, policyStandard3;
	private double firewood;
	
	// getter / setter 구성
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	public String getParterNum()
	{
		return parterNum;
	}
	public void setParterNum(String parterNum)
	{
		this.parterNum = parterNum;
	}
	public String getCampgroundName()
	{
		return campgroundName;
	}
	public void setCampgroundName(String campgroundName)
	{
		this.campgroundName = campgroundName;
	}
	public String getSignUpDate()
	{
		return signUpDate;
	}
	public void setSignUpDate(String signUpDate)
	{
		this.signUpDate = signUpDate;
	}
	public String getAddress1()
	{
		return address1;
	}
	public void setAddress1(String address1)
	{
		this.address1 = address1;
	}
	public String getAddress2()
	{
		return address2;
	}
	public void setAddress2(String address2)
	{
		this.address2 = address2;
	}
	public String getAddress3()
	{
		return address3;
	}
	public void setAddress3(String address3)
	{
		this.address3 = address3;
	}
	public String getTel()
	{
		return tel;
	}
	public void setTel(String tel)
	{
		this.tel = tel;
	}
	public String getExtraInfo()
	{
		return extraInfo;
	}
	public void setExtraInfo(String extraInfo)
	{
		this.extraInfo = extraInfo;
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
	public int getPick()
	{
		return pick;
	}
	public void setPick(int pick)
	{
		this.pick = pick;
	}
	public int getShare()
	{
		return share;
	}
	public void setShare(int share)
	{
		this.share = share;
	}
	public int getPolicyStandard1()
	{
		return policyStandard1;
	}
	public void setPolicyStandard1(int policyStandard1)
	{
		this.policyStandard1 = policyStandard1;
	}
	public int getPolicyStandard2()
	{
		return policyStandard2;
	}
	public void setPolicyStandard2(int policyStandard2)
	{
		this.policyStandard2 = policyStandard2;
	}
	public int getPolicyStandard3()
	{
		return policyStandard3;
	}
	public void setPolicyStandard3(int policyStandard3)
	{
		this.policyStandard3 = policyStandard3;
	}
	public int getReview()
	{
		return review;
	}
	public void setReview(int review)
	{
		this.review = review;
	}
	public double getFirewood()
	{
		return firewood;
	}
	public void setFirewood(double firewood)
	{
		this.firewood = firewood;
	}
	public String getRoomtypelist()
	{
		return roomtypelist;
	}
	public void setRoomtypelist(String roomtypelist)
	{
		this.roomtypelist = roomtypelist;
	}
	public String getOptionlist()
	{
		return optionlist;
	}
	public void setOptionlist(String optionlist)
	{
		this.optionlist = optionlist;
	}
	public String getThemelist()
	{
		return themelist;
	}
	public void setThemelist(String themelist)
	{
		this.themelist = themelist;
	}
	
	
}