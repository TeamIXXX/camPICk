/*====================================
	SurveyResultDAO.java
	- 인터페이스를 임플리먼트한 DAO
	- 커넥션 객체 주입
=====================================*/

package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.ThemeSurvResultDTO;

import oracle.net.aso.a;

public class SurveyResultDAO implements ISurveyResultDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	// 특정 캠핑장의 현재 설정되어있는 옵션에 대한 설문결과 리스트를 구하는 메소드 
	// (캠핑장id → 옵션번호, 옵션이름, 타입번호, 타입이름, 평균, 누적합, 답변수(참여인원))
	@Override
	public ArrayList<OptionSurvResultDTO> getOptionResult(String campgroundId) throws SQLException
	{
		ArrayList<OptionSurvResultDTO> lists = new ArrayList<OptionSurvResultDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CH.OPTIONNUM AS OPTIONNUM, OP.OPTIONNAME AS OPTIONNAME, OP.OPTION_TYPENUM AS OPTIONTYPENUM"
				+ ", OP.OPTION_TYPENAME AS OPTIONTYPENAME , CH.SUM AS SUM, CH.COUNT AS COUNT, CH.AVG AS AVG"
				+ " FROM"
				+ " ("
				+ "		 SELECT OPTIONNUM, SUM(SURVEYSCORE) AS SUM, COUNT(*) AS COUNT, ROUND(AVG(SURVEYSCORE), 1) AS AVG"
				+ "		 FROM OPTIONSURVEY_VIEW"
				+ "		 WHERE CAMPGROUNDID=? "
				+ "		 GROUP BY OPTIONNUM"
				+ " ) CH"
				+ ","
				+ " ("
				+ "		 SELECT OPTIONNUM, OPTIONNAME, OPTION_TYPENUM"
				+ "			, ( SELECT OPTION_TYPENAME"
				+ "				FROM CAMP_OPTIONTYPE"
				+ "				WHERE OPTION_TYPENUM = CO.OPTION_TYPENUM) AS OPTION_TYPENAME"
				+ "		 FROM CAMP_OPTION CO"
				+ " ) OP"
				+ " WHERE CH.OPTIONNUM = OP.OPTIONNUM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			OptionSurvResultDTO opResult = new OptionSurvResultDTO();
			opResult.setOptionNum(rs.getInt("OPTIONNUM"));
			opResult.setOptionName(rs.getString("OPTIONNAME"));
			opResult.setOptionTypeNum(rs.getInt("OPTIONTYPENUM"));
			opResult.setOptionTypeName(rs.getString("OPTIONTYPENAME"));
			opResult.setSum(rs.getInt("SUM"));
			opResult.setCount(rs.getInt("COUNT"));
			opResult.setAvg(rs.getDouble("AVG"));
			
			lists.add(opResult);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return lists;
	}
	

	
	// 특정 테마의 테마종류 개수
	@Override
	public int getThemeTypeCount(int themeTypeNum) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT COUNT(*) AS COUNT FROM THEME WHERE THEME_TYPENUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, themeTypeNum);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 특정 캠핑장의 특정 테마의 총 설문 답변 개수
	@Override
	public int getThemeResultCount(String campgroundId, int themeTypeNum) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNTALL FROM THEMESURVEY_VIEW WHERE THEME_TYPENUM=? AND CAMPGROUNDID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, themeTypeNum);
		pstmt.setString(2, campgroundId);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
		{
			result = rs.getInt("COUNTALL");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	// 특정 캠핑장의 특정 테마의 항목별 개수
	// 캠핑장id, 테마타입번호, 타입별 테마종류의 개수를 매개변수로 받음
	@Override
	public ThemeSurvResultDTO getThemeResult(String campgroundId, int themeTypeNum, int typeCount) throws SQLException
	{
		ThemeSurvResultDTO dto = new ThemeSurvResultDTO();
		
		String[] themeName = new String[typeCount];
		int[] themeNum = new int[typeCount];
		int[] count = new int[typeCount];
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT T.THEMENUM AS THEMENUM, T.THEMENAME AS THEMENAME, NVL(TC.COUNT, 0) AS COUNT"
				+ " FROM"
				+ " ("
				+ "		 SELECT THEMENUM, COUNT"
				+ "		 FROM"
				+ "		 ("
				+ "			 SELECT THEMENUM, COUNT(*) AS COUNT"
				+ "			 FROM THEMESURVEY_VIEW"
				+ "			 WHERE THEME_TYPENUM=" + themeTypeNum + " AND CAMPGROUNDID=?"
				+ "			 GROUP BY THEMENUM"
				+ "		 )"
				+ " ) TC,"
				+ " ("
				+ "		 SELECT THEME_TYPENUM, THEMENUM, THEMENAME"
				+ "		 FROM THEME"
				+ "		 WHERE THEME_TYPENUM=" + themeTypeNum
				+ " ) T"
				+ " WHERE TC.THEMENUM(+) = T.THEMENUM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();
		
		int i = 0;
		while (rs.next())
		{
			themeName[i] = rs.getString("THEMENAME");
			themeNum[i] = rs.getInt("THEMENUM");
			count[i] = rs.getInt("COUNT");
			i++;
		}
		dto.setThemeName(themeName);
		dto.setThemeNum(themeNum);
		dto.setCount(count);
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return dto;
	}
	
	
	
	

}
