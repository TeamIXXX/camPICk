/*========================================
	ISurveyDAO.java
	- 설문결과를 위한 인터페이스형태 DAO
=========================================*/

package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.ThemeSurvResultDTO;

public interface ISurveyResultDAO
{
	public ArrayList<OptionSurvResultDTO> getOptionResult(String campgroundId) throws SQLException;
	
	public int getThemeTypeCount(int themeTypeNum) throws SQLException;
	
	public int getThemeResultCount(String campgroundId, int themeTypeNum) throws SQLException;
	
	public ThemeSurvResultDTO getThemeResult(String campgroundId, int themeTypeNum, int typeCount) throws SQLException;

}
