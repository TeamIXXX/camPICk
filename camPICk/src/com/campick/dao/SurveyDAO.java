package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.OptionDTO;
import com.campick.dto.SurveyDTO;

public class SurveyDAO implements ISurveyDAO
{
	// Connection 객체에 대한 의존성 주입을 위한 준비
	// ① 인터페이스 형태의 데이터타입을 취하는 속성
	private DataSource dataSource;
	
	// ② setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	
	// 편의시설 갯수 메소드
	@Override
	public int conCount(String campgroundId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS CONCOUNT FROM SELECTCON_VIEW WHERE CAMPGROUNDID=?";
		
		// 작업객체 PreparedStatement 생성
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
			result = rs.getInt("COUNT");
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 즐길거리 갯수 메소드
	@Override
	public int funCount(String campgroundId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS FUNCOUNT FROM SELECTFUN_VIEW WHERE CAMPGROUNDID=?";
		
		// 작업객체 PreparedStatement 생성
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
			result = rs.getInt("COUNT");
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	// 옵션 설문조사 결과 입력 메소드
	@Override
	public int optionAdd(SurveyDTO survey) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO CAMP_OPTIONSURVEY(SURVEYNUM, BOOKINGNUM, OPTIONNUM, SURVEYSCORE, SURVEYDATE)"
				+ " VALUES(OPNSURVEYSEQ.NEXTVAL, ?, ?, ?, SYSDATE)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, survey.getBookingNum());
		pstmt.setInt(2, survey.getOptionNum());
		pstmt.setInt(3, survey.getSurveyScore());
		//pstmt.setString(4, survey.getSurveyDate());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	// 테마 설문조사 결과 입력 메소드
	@Override
	public int themeAdd(SurveyDTO survey) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO THEMESURVEY (SURVEYNUM, BOOKINGNUM, THEMENUM, SURVEYDATE)"
				+ " VALUES(THMSURVEYSEQ.NEXTVAL, ?, ?, SYSDATE)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, survey.getBookingNum());
		pstmt.setInt(2, survey.getThemeNum());
		//pstmt.setString(3, survey.getSurveyDate());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	// 리뷰 설문조사 결과 입력 메소드
	@Override
	public int reviewAdd(SurveyDTO survey) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO REVIEW(CONTENTNUM, BOOKINGNUM, CREATEDATE, CONTENT, FIREWOOD)"
				+ " VALUES(REVIEWSEQ.NEXTVAL, ?, SYSDATE, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, survey.getBookingNum());
		//pstmt.setString(2, survey.getSurveyDate());
		pstmt.setString(2, survey.getContent());
		pstmt.setInt(3, survey.getFirewood());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 옵션 리스트 조회 메소드
	@Override
	public ArrayList<OptionDTO> optionlist(String campgroundId) throws SQLException
	{
		ArrayList<OptionDTO> result = new ArrayList<OptionDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CAMPGROUNDID, OPTION_TYPENUM, OPTION_TYPENAME, OPTIONNUM, OPTIONNAME FROM SELECTOPTION_VIEW WHERE CAMPGROUNDID=?";
		
		// 작업객체 PreparedStatement 생성
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			// Employee 객체 생성
			OptionDTO option = new OptionDTO();
			
			option.setCampgroundId(rs.getString("CAMPGROUNDID"));
			option.setOptionTypeNum(rs.getInt("OPTION_TYPENUM"));
			option.setOptionTypeName(rs.getString("OPTION_TYPENAME"));
			option.setOptionNum(rs.getInt("OPTIONNUM"));
			option.setOptionName(rs.getString("OPTIONNAME"));
			
			result.add(option);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
	// bookingNum으로 checkinDate, checkoutDate 구하는 메소드 필요해
	
	// bookingNum으로 리뷰 작성 가능한 회원인지 확인하는 메소드 필요해



}
