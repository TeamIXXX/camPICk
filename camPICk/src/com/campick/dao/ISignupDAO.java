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
	public CamperDTO searchCamperId(String camperNum);
	
	// 캠퍼 정보 수정
	public int modifyCamper(CamperDTO camperDTO);

	// 캠퍼 이름, 휴대폰번호로 id 검사
	public String findCamperId(String camperName, String phone);
	
	// 파트너 이름, 휴대폰번호로 id 검사
	public String findPartnerId(String partnerName, String partnerPhone);
	
	// 캠퍼 이름, 휴대폰번호로 pw 검사
	
	// 파트너 회원가입(파트너 테이블 인서트, 승인내역테이블 인서트)
	public int addPartner(PartnerDTO partner);
	
	// 파트너 회원 승인1 - 파일정보가 있는 지 확인
	public int getFileExist(String partnerId);
	
	// 파트너 회원 승인2 - 마지막 승인내역 상태 확인
	public PartnerDTO getApprovalStatus(String partnerId);
	
}
