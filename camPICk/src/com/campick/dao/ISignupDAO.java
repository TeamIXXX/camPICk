/*========================
	ISignupDAO.java
==========================*/

package com.campick.dao;

import com.campick.dto.CamperDTO;
import com.campick.dto.PartnerDTO;

public interface ISignupDAO
{
	// 아이디중복체크
	public int getSameIdCheck(String id);
	
	// 캠퍼 회원가입
	public int addCamper(CamperDTO camperDTO);
	
	// 캠퍼 정보 조회
	public CamperDTO searchCamper(String camperId, String camperPw);
	
	// 캠퍼 정보 수정
	public int modifyCamper(CamperDTO camperDTO);
	
	// 파트너 회원가입1(파트너 테이블 인서트, 승인내역테이블 인서트)
	public int addPartner(PartnerDTO partner);
	
	
}
