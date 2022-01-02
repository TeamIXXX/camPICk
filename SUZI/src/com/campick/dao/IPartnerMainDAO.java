/*===============================================
	IPartnerMainDAO.java
	- 인터페이스
	- 파트너 메인에서 캠핑장 소유 유무 등 
	  조건에 따라 분기해서 페이지 이동을 위한 dao
==================================================*/

package com.campick.dao;

import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.CampgroundDTO;
import com.campick.dto.PartnerDTO;

public interface IPartnerMainDAO
{
	// 캠핑장 유무 확인
	public int checkMyCampground(@RequestParam("partnerNum") String partnerNum);
		
	// 파트너가 가지고 있는 캠핑장 아이디 검색
	public String getCampgroundId(@RequestParam("partnerNum") String partnerNum);

}
