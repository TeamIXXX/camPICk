package com.campick.dao;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.CampgroundDTO;

public interface IPartnerCampgroundDAO
{
	// 파트너가 캠핑장 등록
	public int campgroundAdd(CampgroundDTO cg); 
	
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
}
