/*======================================
	CamperDTO.java
	캠퍼 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class CamperDTO
{
	private String camperId, camperNum, camperPw, camperName, phone, email, signupDate;

	// getter / setter
	public String getCamperId()
	{
		return camperId;
	}

	public void setCamperId(String camperId)
	{
		this.camperId = camperId;
	}

	public String getCamperNum()
	{
		return camperNum;
	}

	public void setCamperNum(String camperNum)
	{
		this.camperNum = camperNum;
	}

	public String getCamperPw()
	{
		return camperPw;
	}

	public void setCamperPw(String camperPw)
	{
		this.camperPw = camperPw;
	}

	public String getCamperName()
	{
		return camperName;
	}

	public void setCamperName(String camperName)
	{
		this.camperName = camperName;
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
