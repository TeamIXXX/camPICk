/*======================================
	CamperDTO.java
	캠퍼 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class CampaDTO
{
	private String id, memberNum, pw, name, phone, email, signupDate;


	// getter / setter
	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getMemberNum()
	{
		return memberNum;
	}

	public void setMemberNum(String memberNum)
	{
		this.memberNum = memberNum;
	}

	public String getPw()
	{
		return pw;
	}

	public void setPw(String pw)
	{
		this.pw = pw;
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

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getSignupDate()
	{
		return signupDate;
	}

	public void setSignupDate(String signupDate)
	{
		this.signupDate = signupDate;
	}
	
}
