package com.campick.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.CampgroundDTO;
import com.campick.dto.OptionDTO;
import com.campick.dto.RoomDTO;

public interface IPartnerCampgroundDAO
{
	
	// 파트너아이디를 통해 캠핑장 정보 출력
	public CampgroundDTO myCampgroundInfo(@RequestParam("partnerNum") String partnerNum); 
	
	// 캠핑장 객실 유형 정보
	public ArrayList<String> roomTypeList(@RequestParam("partnerNum") String partnerNum);
	
	// 캠핑장 옵션(편의시설) 정보
	public ArrayList<String> comfortsList(@RequestParam("partnerNum") String partnerNum);
	
	// 캠핑장 옵션(즐길거리) 정보
	public ArrayList<String> funList(@RequestParam("partnerNum") String partnerNum);
	
	// 파트너가 가지고 있는 캠핑장 아이디 검색
	public String getCampgroundId(@RequestParam("partnerNum") String partnerNum);
	
	// 캠핑장을 가지고 있는 파트너번호 출력
	public ArrayList<String> partnerCampgroundGet();
	
	// 객실 추가 
	public int roomInsert(RoomDTO room);


	// 객실 수정
	public int roomUpdate(RoomDTO room);

	//public int roomInsert(int roomTypeNum, String roomName, int weekDayPrice, int weekEndPrice, int basicNum, int maxNum, String roomInfo );
	
	
	// 캠핑장 수정 시 필요한 캠핑장 정보 가져오기(환불규정 포함)
	public CampgroundDTO getCampgroundInfoForUpdate(@RequestParam("partnerNum") String partnerNum);
	
	// 캠핑장 수정 시 필요한 옵션(편의시설) 정보(OPTIONNUM 포함)
	public ArrayList<OptionDTO> comfortsListForUpdate(@RequestParam("partnerNum") String partnerNum);
	
	// 캠핑장 수정 시 필요한 옵션(즐길거리) 정보(OPTIONNUM 포함)
	public ArrayList<OptionDTO> funListForUpdate(@RequestParam("partnerNum") String partnerNum);
	
	// 환불규정 가이드라인 조회
	public CampgroundDTO getGuidStandard();
	
	// 캠핑장 정보 수정① (옵션 제외 처리)
	public int modifyCampground(CampgroundDTO campground);
	
	// 캠핑장 정보 수정② (옵션 정보 삭제)
	public int removeOptionStatus(@RequestParam("campgroundId") String campgroundId);
	
	// 캠핑장 정보 수정③ (옵션 정보 추가)
	public int addOptionStatus(@Param("campgroundId") String campgroundId, @Param("optionNum") String optionNum);
		
}
