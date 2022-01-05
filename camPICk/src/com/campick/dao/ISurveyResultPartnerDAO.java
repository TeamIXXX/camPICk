/*========================================
	ISurveyResultPartnerDAO.java
	- 설문결과를 위한 인터페이스형태 DAO
=========================================*/

package com.campick.dao;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.ThemeSurvResultDTO;
import com.campick.dto.ThemeSurvResultPartnerDTO;

public interface ISurveyResultPartnerDAO
{
	public ArrayList<OptionSurvResultDTO> getOptionResult(@RequestParam("campgroundId") String campgroundId);
	
	public int getThemeTypeCount(@RequestParam("themeTypeNum") int themeTypeNum);
	
	public ArrayList<ThemeSurvResultPartnerDTO> getThemeResultCount(@RequestParam("cmapgroundId") String campgroundId);
	
	// 캠퍼와 다르게 특정 테마 유형이 아니라 모든 테마유형, 테마 종류의 리스트를 가져옴
	public ArrayList<ThemeSurvResultPartnerDTO> getThemeResult(@RequestParam("campgroundId") String campgroundId);

}
