package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.OptionDTO;
import com.campick.dto.SurveyDTO;

public interface ISurveyDAO
{
	// 편의시설 갯수 메소드
	public int conCount(String campgroundId) throws SQLException;
	
	// 즐길거리 갯수 메소드
	public int funCount(String campgroundId) throws SQLException;
	
	// 옵션 리스트 조회 메소드
	public ArrayList<OptionDTO> optionlist(String campgroundId) throws SQLException;

	// 옵션 설문 결과 입력 메소드
	public int optionAdd(SurveyDTO survey) throws SQLException;
	
	// 테마 설문 결과 입력 메소드
	public int themeAdd(SurveyDTO survey) throws SQLException;
	
	// 캠핑장 리뷰 입력 메소드
	public int reviewAdd(SurveyDTO survey) throws SQLException;

	// bookingNum으로 checkinDate, checkoutDate 구하는 메소드 필요해

	
	

	
}
