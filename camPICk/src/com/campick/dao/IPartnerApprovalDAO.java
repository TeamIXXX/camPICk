package com.campick.dao;

import java.util.ArrayList;

import com.campick.dto.PartnerApprovalDTO;

public interface IPartnerApprovalDAO
{
	public ArrayList<PartnerApprovalDTO> partnerApprovalList();
	public int getPartnerApprovalCount();
}
