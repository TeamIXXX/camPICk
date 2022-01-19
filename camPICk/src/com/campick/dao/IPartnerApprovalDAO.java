package com.campick.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.campick.dto.PartnerApprovalDTO;

public interface IPartnerApprovalDAO
{
	public ArrayList<PartnerApprovalDTO> partnerApprovalList(int start, int end);
	public ArrayList<PartnerApprovalDTO> partnerNotApprovedList(int start, int end);
	public int getPartnerApprovalCount();
	public int getPartnerApprovedCount();
	public int getPartnerNotApprovedCount();
	public int PartnerApprovalInsert(@Param("pi") String pi, @Param("approvalnum") int approvalnum);
}
