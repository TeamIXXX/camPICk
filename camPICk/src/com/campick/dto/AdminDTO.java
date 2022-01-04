/*======================================
	AdminDTO.java
	관리자 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class AdminDTO
{
	private String adminId, adminNum, adminPw;
	
	// getter / setter
	public String getAdminId()
	{
		return adminId;
	}

	public void setAdminId(String adminId)
	{
		this.adminId = adminId;
	}

	public String getAdminNum()
	{
		return adminNum;
	}

	public void setAdminNum(String adminNum)
	{
		this.adminNum = adminNum;
	}

	public String getAdminPw()
	{
		return adminPw;
	}

	public void setAdminPw(String adminPw)
	{
		this.adminPw = adminPw;
	}
	
}
