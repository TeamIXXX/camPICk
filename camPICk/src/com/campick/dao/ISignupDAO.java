/*========================
	ISignupDAO.java
==========================*/

package com.campick.dao;

import com.campick.dto.CamperDTO;

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
	public String findId(String name, String phone);
	
	// 캠퍼 이름, 휴대폰번호로 pw 검사
	
	
	// 파트너 회원가입
	
}
