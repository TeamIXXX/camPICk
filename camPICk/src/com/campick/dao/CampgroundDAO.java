package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.CampgroundOptionDTO;
import com.campick.dto.CampgroundThemeDTO;

public class CampgroundDAO implements ICampgroundDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	/* 혜진언니꺼 합치기 전
	 * @Override public ArrayList<CampgroundDTO> campgroundList() throws
	 * SQLException { ArrayList<CampgroundDTO> result = new
	 * ArrayList<CampgroundDTO>();
	 * 
	 * Connection conn = dataSource.getConnection();
	 * 
	 * String sql = "SELECT CAMPGROUNDID, CAMPGROUNDNAME, SIGNUPDATE" +
	 * ", ADDRESS1, ADDRESS2, ADDRESS3" + ", PICKCOUNT, REVIEWCOUNT, FIREWOOD" +
	 * " FROM CAMPGROUND_VIEW";
	 * 
	 * 
	 * PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs =
	 * pstmt.executeQuery();
	 * 
	 * while (rs.next()) { CampgroundDTO cg = new CampgroundDTO();
	 * cg.setCampgroundId(rs.getString("CAMPGROUNDID"));
	 * cg.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
	 * cg.setSignUpDate(rs.getString("SIGNUPDATE"));
	 * cg.setAddress1(rs.getString("ADDRESS1"));
	 * cg.setAddress2(rs.getString("ADDRESS2"));
	 * cg.setAddress3(rs.getString("ADDRESS3")); cg.setPick(rs.getInt("PICKCOUNT"));
	 * cg.setReview(rs.getInt("REVIEWCOUNT"));
	 * cg.setFirewood(rs.getDouble("FIREWOOD"));
	 * 
	 * result.add(cg); }
	 * 
	 * rs.close(); pstmt.close(); conn.close();
	 * 
	 * return result; }
	 */
	
	public ArrayList<CampgroundDTO> campgroundList() throws SQLException
	{
		ArrayList<CampgroundDTO> result = new ArrayList<CampgroundDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CAMPGROUNDID, CAMPGROUNDNAME, SIGNUPDATE"
				+ ", ADDRESS1, ADDRESS2, ADDRESS3"
				+ ", PICKCOUNT, REVIEWCOUNT, FIREWOOD"
				+ " FROM CAMPGROUND_VIEW"
				+ " ORDER BY SIGNUPDATE DESC";
		
	
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next())
		{
			CampgroundDTO cg = new CampgroundDTO();
			cg.setCampgroundId(rs.getString("CAMPGROUNDID"));
			cg.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
			cg.setSignUpDate(rs.getString("SIGNUPDATE"));
			cg.setAddress1(rs.getString("ADDRESS1"));
			cg.setAddress2(rs.getString("ADDRESS2"));
			cg.setAddress3(rs.getString("ADDRESS3"));
			cg.setPick(rs.getInt("PICKCOUNT"));
			cg.setReview(rs.getInt("REVIEWCOUNT"));
			cg.setFirewood(rs.getDouble("FIREWOOD"));			
			
			result.add(cg);
		}

		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}

	
	
	// 캠핑장 검색 시 선택할 계절 출력
	@Override
	public ArrayList<CampgroundThemeDTO> campgroundThemeSeason() throws SQLException
	{
		ArrayList<CampgroundThemeDTO> result = new ArrayList<CampgroundThemeDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT THEMETYPENUM, THEME_TYPENAME, THEMENUM, THEMENAME FROM SEASON_VIEW";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			CampgroundThemeDTO ct = new CampgroundThemeDTO();
			ct.setThemetypeNum(rs.getString("THEMETYPENUM"));
			ct.setThemetypeName(rs.getString("THEME_TYPENAME"));
			ct.setThemeNum(rs.getString("THEMENUM"));
			ct.setThemeName(rs.getString("THEMENAME"));
			
			result.add(ct);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 캠핑장 검색 시 선택할 구성원 출력
	@Override
	public ArrayList<CampgroundThemeDTO> campgroundThemeGroupMember() throws SQLException
	{
		ArrayList<CampgroundThemeDTO> result = new ArrayList<CampgroundThemeDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT THEMETYPENUM, THEME_TYPENAME, THEMENUM, THEMENAME FROM GROUPMEMBER_VIEW";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			CampgroundThemeDTO ct = new CampgroundThemeDTO();
			ct.setThemetypeNum(rs.getString("THEMETYPENUM"));
			ct.setThemetypeName(rs.getString("THEME_TYPENAME"));
			ct.setThemeNum(rs.getString("THEMENUM"));
			ct.setThemeName(rs.getString("THEMENAME"));
			
			result.add(ct);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 캠핑장 검색 시 선택할 분위기 출력
	@Override
	public ArrayList<CampgroundThemeDTO> campgroundThemeMood() throws SQLException
	{
		ArrayList<CampgroundThemeDTO> result = new ArrayList<CampgroundThemeDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT THEMETYPENUM, THEME_TYPENAME, THEMENUM, THEMENAME FROM MOOD_VIEW";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			CampgroundThemeDTO ct = new CampgroundThemeDTO();
			ct.setThemetypeNum(rs.getString("THEMETYPENUM"));
			ct.setThemetypeName(rs.getString("THEME_TYPENAME"));
			ct.setThemeNum(rs.getString("THEMENUM"));
			ct.setThemeName(rs.getString("THEMENAME"));
			
			result.add(ct);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 캠핑장 검색 시 선택할 편의시설 출력
	@Override
	public ArrayList<CampgroundOptionDTO> campgroundOptionConvenience() throws SQLException
	{
		ArrayList<CampgroundOptionDTO> result = new ArrayList<CampgroundOptionDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT OPTION_TYPENAME, OPTION_TYPENUM, OPTIONNUM, OPTIONNAME FROM OPTION_CONVENIENCE_VIEW";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			CampgroundOptionDTO co = new CampgroundOptionDTO();
			co.setOptionTypeName(rs.getString("OPTION_TYPENAME"));
			co.setOptionTypeNum(rs.getString("OPTION_TYPENUM"));
			co.setOptionNum(rs.getString("OPTIONNUM"));
			co.setOptionName(rs.getString("OPTIONNAME"));
			
			result.add(co);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	// 캠핑장 검색 시 선택할 즐길거리 출력
	@Override
	public ArrayList<CampgroundOptionDTO> campgroundOptionFun() throws SQLException
	{
		ArrayList<CampgroundOptionDTO> result = new ArrayList<CampgroundOptionDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT OPTION_TYPENAME, OPTION_TYPENUM, OPTIONNUM, OPTIONNAME FROM OPTION_FUN_VIEW";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			CampgroundOptionDTO co = new CampgroundOptionDTO();
			co.setOptionTypeName(rs.getString("OPTION_TYPENAME"));
			co.setOptionTypeNum(rs.getString("OPTION_TYPENUM"));
			co.setOptionNum(rs.getString("OPTIONNUM"));
			co.setOptionName(rs.getString("OPTIONNAME"));
			
			result.add(co);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public ArrayList<CampgroundDTO> campgroundSearchList(String keyword) throws SQLException
	{
		ArrayList<CampgroundDTO> result = new ArrayList<CampgroundDTO>();
		
		Connection conn = dataSource.getConnection();
		
		try
		{
			String sql = "SELECT * FROM CAMPGROUND_VIEW WHERE CAMPGROUNDNAME"
					+ " LIKE '%' || ? || '%' ORDER BY SIGNUPDATE DESC";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, keyword);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				CampgroundDTO cg = new CampgroundDTO();
				cg.setCampgroundId(rs.getString("CAMPGROUNDID"));
				cg.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				cg.setSignUpDate(rs.getString("SIGNUPDATE"));
				cg.setAddress1(rs.getString("ADDRESS1"));
				cg.setAddress2(rs.getString("ADDRESS2"));
				cg.setAddress3(rs.getString("ADDRESS3"));
				cg.setPick(rs.getInt("PICKCOUNT"));
				cg.setReview(rs.getInt("REVIEWCOUNT"));
				cg.setFirewood(rs.getDouble("FIREWOOD"));			
				
				result.add(cg);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;

	}
	
	@Override
	public CampgroundDTO campgroundListDetail(String campgroundId) throws SQLException
	{
		CampgroundDTO result = new CampgroundDTO();
				
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CAMPGROUNDID, CAMPGROUNDNAME, ADDRESS1, ADDRESS2, ADDRESS3"
				+ ", TEL, PICKCOUNT, REVIEWCOUNT, FIREWOOD"
				+ ", EXTRAINFO, CHECKINDATE, CHECKOUTDATE"
				+ ", POLICYSTANDARD1" 
				+ ", POLICYSTANDARD2" 
				+ ", POLICYSTANDARD3" 
				+ " FROM CAMPGROUND_VIEW WHERE CAMPGROUNDID=?";		
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();	

		while (rs.next())
		{
			result.setCampgroundId(rs.getString("CAMPGROUNDID"));
			result.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
			result.setAddress1(rs.getString("ADDRESS1"));
			result.setAddress2(rs.getString("ADDRESS2"));
			result.setAddress3(rs.getString("ADDRESS3"));
			result.setTel(rs.getString("TEL"));
			result.setPick(rs.getInt("PICKCOUNT"));
			result.setReview(rs.getInt("REVIEWCOUNT"));
			result.setFirewood(rs.getDouble("FIREWOOD"));	
			result.setExtraInfo(rs.getString("EXTRAINFO"));
			result.setCheckInDate(rs.getString("CHECKINDATE"));
			result.setCheckOutDate(rs.getString("CHECKOUTDATE"));
			result.setPolicyStandard1(rs.getInt("POLICYSTANDARD1"));
			result.setPolicyStandard2(rs.getInt("POLICYSTANDARD2"));
			result.setPolicyStandard3(rs.getInt("POLICYSTANDARD3"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}
	
	
	
		
	////////////////////////진령이 부분 합친 것//////////////////
	// checkinDate, checkoutDate, 리뷰 작성 여부 확인하는 메소드
	@Override
	public ArrayList<BookingDTO> bookCheckList(String campgroundId, String memberNum) throws SQLException
	{
		ArrayList<BookingDTO> result = new ArrayList<BookingDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT BOOKINGNUM, TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE, TO_CHAR(CHECKOUTDATE, 'YYYY-MM-DD') AS CHECKOUTDATE, REVIEWCHECK, MEMBERNUM FROM CANREVIEW WHERE CAMPGROUNDID=? AND MEMBERNUM=?";
		
		// 작업객체 PreparedStatement 생성
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		pstmt.setString(2, memberNum);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			// BookingDTO 객체 생성
			BookingDTO booking = new BookingDTO();
			
			booking.setBookingNum(rs.getString("BOOKINGNUM"));
			booking.setCheckInDate(rs.getString("CHECKINDATE"));
			booking.setCheckOutDate(rs.getString("CHECKOUTDATE"));
			booking.setReviewCheck(rs.getInt("REVIEWCHECK"));
			booking.setMemberNum(rs.getString("MEMBERNUM"));
				
			result.add(booking);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	// bookCheckList 오버로딩 (비회원일 시..)
	@Override
	public ArrayList<BookingDTO> bookCheckList(String campgroundId) throws SQLException
	{
		
		ArrayList<BookingDTO> result = new ArrayList<BookingDTO>();
		
		BookingDTO booking = new BookingDTO();
		
		booking.setMemberNum("0");
		result.add(booking);
		
		return result;
	}
	
	
	/////////// 진희, 유동 추가 
	//픽 하기
	@Override
	public int pickOn(String camperNum, String campgroundId) throws SQLException
	{
		int result = 0;

		Connection conn = dataSource.getConnection();
		
		String sql =  "INSERT INTO PICK (PICKNUM,CAMPERNUM,CAMPGROUNDID)" 
					+ " VALUES( 'PK' || TO_CHAR( (SELECT NVL(MAX(SUBSTR(PICKNUM, 3)), 0) FROM PICK) + 1, 'FM00000'), ?, ?)"; 
		
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try
		{
			pstmt.setString(1, camperNum);
			pstmt.setString(2, campgroundId);

			result = pstmt.executeUpdate();

		} catch (Exception e)
		{
			System.out.println(e.toString());
		} finally
		{
			pstmt.close();
			conn.close();
		}

		return result;
	}	
	
	//픽 해제
	@Override
	public int pickOff(String camperNum, String campgroundId) throws SQLException
	{
		int result = 0;

		Connection conn = dataSource.getConnection();
		
		String sql =  "DELETE" 
					+ " FROM PICK" 
					+ " WHERE CAMPERNUM=? AND CAMPGROUNDID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try
		{
			pstmt.setString(1, camperNum);
			pstmt.setString(2, campgroundId);

			result = pstmt.executeUpdate();

		} catch (Exception e)
		{
			System.out.println(e.toString());
		} finally
		{
			pstmt.close();
			conn.close();
		}

		return result;
	}
	
	//픽여부 판별
	@Override
	public String pickCheck(String camperNum, String campgroundId) throws SQLException
	{
		String result = null;

		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT PICKNUM" 
					+ " FROM PICK" 
					+ " WHERE CAMPERNUM=? AND CAMPGROUNDID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = null;

		try
		{
			pstmt.setString(1, camperNum);
			pstmt.setString(2, campgroundId);

			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				result = rs.getString("PICKNUM");	
			}

		} catch (Exception e)
		{
			System.out.println(e.toString());
		} finally
		{
			rs.close();
			pstmt.close();
			conn.close();
		}

		return result;
	}

	
}
