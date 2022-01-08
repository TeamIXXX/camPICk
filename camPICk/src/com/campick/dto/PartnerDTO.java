/*======================================
	PartnerDTO.java
	파트너 정보 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class PartnerDTO
{
	private String partnerId, partnerNum, partnerPw, partnerName, partnerPhone;
	private String businesslicense, partnerEmail, signUpDate;
	private String fileRoute, fileName, fileUploadDate;
	private String approvalStatusName;
	private int approvalStatusNum;
	
	// getter / setter 
	public String getPartnerId()
	{
		return partnerId;
	}
	public void setPartnerId(String partnerId)
	{
		this.partnerId = partnerId;
	}
	public String getPartnerNum()
	{
		return partnerNum;
	}
	public void setPartnerNum(String partnerNum)
	{
		this.partnerNum = partnerNum;
	}
	public String getPartnerPw()
	{
		return partnerPw;
	}
	public void setPartnerPw(String partnerPw)
	{
		this.partnerPw = partnerPw;
	}
	public String getPartnerName()
	{
		return partnerName;
	}
	public void setPartnerName(String partnerName)
	{
		this.partnerName = partnerName;
	}
	public String getPartnerPhone()
	{
		return partnerPhone;
	}
	public void setPartnerPhone(String partnerPhone)
	{
		this.partnerPhone = partnerPhone;
	}
	public String getBusinesslicense()
	{
		return businesslicense;
	}
	public void setBusinesslicense(String businesslicense)
	{
		this.businesslicense = businesslicense;
	}
	public String getPartnerEmail()
	{
		return partnerEmail;
	}
	public void setPartnerEmail(String email)
	{
		this.partnerEmail = email;
	}
	public String getSignUpDate()
	{
		return signUpDate;
	}
	public void setSignUpDate(String signUpDate)
	{
		this.signUpDate = signUpDate;
	}
	public String getFileRoute()
	{
		return fileRoute;
	}
	public void setFileRoute(String fileRoute)
	{
		this.fileRoute = fileRoute;
	}
	public String getFileName()
	{
		return fileName;
	}
	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}
	public String getFileUploadDate()
	{
		return fileUploadDate;
	}
	public void setFileUploadDate(String fileUploadDate)
	{
		this.fileUploadDate = fileUploadDate;
	}
	public String getApprovalStatusName()
	{
		return approvalStatusName;
	}
	public void setApprovalStatusName(String approvalStatusName)
	{
		this.approvalStatusName = approvalStatusName;
	}
	public int getApprovalStatusNum()
	{
		return approvalStatusNum;
	}
	public void setApprovalStatusNum(int approvalStatusNum)
	{
		this.approvalStatusNum = approvalStatusNum;
	}
	
	
	
	
}
