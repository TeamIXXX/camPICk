/*======================================
	CamperDTO.java
	캠퍼 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class CamperDTO
{
	private String camperId, camperNum, camperPw, camperName, camperPhone, camperEmail, signUpDate;

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

	public String getCamperPhone()
	{
		return camperPhone;
	}

	public void setCamperPhone(String camperPhone)
	{
		this.camperPhone = camperPhone;
	}

	public String getCamperEmail()
	{
		return camperEmail;
	}

	public void setCamperEmail(String camperEmail)
	{
		this.camperEmail = camperEmail;
	}

	public String getSignUpDate()
	{
		return signUpDate;
	}

	public void setSignUpDate(String signupDate)
	{
		this.signUpDate = signupDate;
	}
	
}
