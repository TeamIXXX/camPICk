/*========================
	ISignupDAO.java
==========================*/

package com.campick.dao;

import com.campick.dto.CamperDTO;
import com.campick.dto.PartnerDTO;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;


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

	// 이름, 휴대폰번호로 캠퍼 아이디 조회
	public String findCId(@Param("camperName")String camperName, @Param("camperPhone")String camperPhone);
	
	// 이름, 휴대폰번호로 파트너 아이디 조회
	public String findPId(@Param("partnerName")String partnerName, @Param("partnerPhone")String partnerPhone);
	
	// 아이디, 휴대폰번호로 비밀번호 조회
	public String findCPw(@Param("camperId")String camperId, @Param("camperPhone")String camperPhone);
	
	// 아이디, 휴대폰번호로 비밀번호 조회
	public String findPPw(@Param("partnerId")String partnerId, @Param("partnerPhone")String partnerPhone);
	
	// 캠퍼 비밀번호 재설정
	public int resetCPw(@Param("camperPw")String camperPw, @Param("camperId")String camperId, @Param("camperPhone")String camperPhone);
	
	// 캠퍼 비밀번호 재설정
	public int resetPPw(@Param("partnerPw")String partnerPw, @Param("partnerId")String partnerId, @Param("partnerPhone")String partnerPhone);
	
	// 파트너 회원가입(파트너 테이블 인서트, 승인내역테이블 인서트)
	public int addPartner(PartnerDTO partner);
	
	// 파트너 회원 승인1 - 파일정보가 있는 지 확인
	public int getFileExist(String partnerId);
	
	// 파트너 회원 승인2 - 마지막 승인내역 상태 확인
	public PartnerDTO getApprovalStatus(String partnerId);
	
	// 파트너 서류 첨부(회원가입 이후 업데이트)
	public int updateFile(PartnerDTO partner);
	
	// 파트너 비밀번호 확인
	public int checkPartnerPw(PartnerDTO partner);
	
	// 파트너 회원 정보 조회
	public PartnerDTO searchPartner(String partnerNum);
	
	// 파트너 회원 정보 수정
	public int modifyPartner(PartnerDTO partner);
	
}
