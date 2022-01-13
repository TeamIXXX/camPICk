/*========================
	ReviewDAO.java
=========================*/

package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.ReviewDTO;


public class ReviewDAO implements IReviewDAO
{
	private DataSource dataSource; 
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

		
	// 리뷰 갯수 구하는 메소드(캠핑장 아이디)
	@Override
	public int getReviewCount(String campgroundId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM REVIEW_VIEW WHERE CAMPGROUNDID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
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

	
	// 특정 영역의 리뷰 리스트를 가져오는 메소드(시작번호, 끝번호, 캠핑장 아이디, 정렬조건(컬럼), 정렬기준(오름내림))
	@Override
	public ArrayList<ReviewDTO> getReviewLists(int start, int end, String campgroundId, String sortKey, String sortOrder)
			throws SQLException
	{
		ArrayList<ReviewDTO> reviewLists = new ArrayList<ReviewDTO>();
		
		Connection conn = dataSource.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try
		{
			sql = "SELECT CONTENTNUM, BOOKINGNUM, CAMPGROUNDID, TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE, CAMPERID " 
					+ "     , MEMBERNUM, TO_CHAR(CREATEDATE, 'YYYY-MM-DD') AS CREATEDATE, FIREWOOD, CONTENT " 
					+ "     , NVL(REPLY, 0) AS REPLY, NVL(TO_CHAR(REPLYCREATEDATE, 'YYYY-MM-DD'), 0) AS REPLYCREATEDATE, NVL(REPLYNUM, 0) AS REPLYNUM"
					+ " FROM"
					+ " ("
					+ " SELECT ROWNUM RNUM, DATA.*"
					+ " FROM"
					+ " ("
					+ " SELECT CONTENTNUM, BOOKINGNUM, CAMPGROUNDID, CHECKINDATE, CAMPERID, MEMBERNUM, CREATEDATE, FIREWOOD, CONTENT"
					+ ", REPLY, REPLYCREATEDATE, REPLYNUM"
					+ " FROM REVIEW_VIEW"
					+ " WHERE CAMPGROUNDID = ?"
					+ " ORDER BY " + sortKey + " " + sortOrder
					+ " ) DATA"
					+ " ) WHERE RNUM>=? AND RNUM<=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, campgroundId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ReviewDTO review = new ReviewDTO();
				review.setContentNum(Integer.parseInt(rs.getString("CONTENTNUM")));
				review.setBookingNum(rs.getString("BOOKINGNUM"));
				review.setCampgroundId(rs.getString("CAMPGROUNDID"));
				review.setCheckInDate(rs.getString("CHECKINDATE"));
				review.setCamperId(rs.getString("CAMPERID"));
				review.setMemberNum(rs.getString("MEMBERNUM"));
				review.setCreateDate(rs.getString("CREATEDATE"));
				review.setFireWood(rs.getInt("FIREWOOD"));
				review.setContent(rs.getString("CONTENT"));
				review.setReplyNum(rs.getInt("REPLYNUM"));
				review.setReply(rs.getString("REPLY"));
				review.setReplyCreateDate(rs.getString("REPLYCREATEDATE"));
				
				reviewLists.add(review);
			}
			rs.close();
			pstmt.close();
			conn.close();			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return reviewLists;
	}


	@Override
	public int removeReview(int contentNum) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "DELETE FROM REVIEW WHERE CONTENTNUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, contentNum);
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	@Override
	public int modifyReview(ReviewDTO review) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "UPDATE REVIEW SET CONTENT = ? WHERE CONTENTNUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, review.getContent());
		pstmt.setInt(2, review.getContentNum());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	
	//--------------------------------- 추가 코드 --------------------------------
	// 내캠핑장 > 예약 내역 확인 > 리뷰 보기 에서 리뷰 확인을 위한 코드 추가

	@Override
	public int getReviewCountForBookingNum(String bookingNum) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT NVL(COUNT(*), 0) AS COUNT FROM REVIEW_VIEW WHERE BOOKINGNUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bookingNum);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}


	@Override
	public ReviewDTO getSpecificReview(String bookingNum) throws SQLException
	{
		ReviewDTO dto = new ReviewDTO();
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT CONTENTNUM, BOOKINGNUM, CAMPGROUNDID, TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE "
				+ ", CAMPERID, MEMBERNUM, TO_CHAR(CREATEDATE, 'YYYY-MM-DD') AS CREATEDATE, FIREWOOD, CONTENT AS CONTENT "
				+ ",  NVL(REPLY, 0) AS REPLY, NVL(TO_CHAR(REPLYCREATEDATE, 'YYYY-MM-DD'), 0) AS REPLYCREATEDATE"
				+ ", NVL(REPLYNUM, 0) AS REPLYNUM"
				+ " FROM REVIEW_VIEW"
				+ " WHERE BOOKINGNUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bookingNum);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			dto.setContentNum(rs.getInt("CONTENTNUM"));
			dto.setBookingNum(rs.getString("BOOKINGNUM"));
			dto.setCampgroundId(rs.getString("CAMPGROUNDID"));
			dto.setCheckInDate(rs.getString("CHECKINDATE"));
			dto.setCamperId(rs.getString("CAMPERID"));
			dto.setMemberNum(rs.getString("MEMBERNUM"));
			dto.setCreateDate(rs.getString("CREATEDATE"));
			dto.setFireWood(rs.getInt("FIREWOOD"));
			dto.setContent(rs.getString("CONTENT"));
			dto.setReply(rs.getString("REPLY"));
			dto.setReplyCreateDate(rs.getString("REPLYCREATEDATE"));
			dto.setReplyNum(rs.getInt("REPLYNUM"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return dto;
	}


	@Override
	public int getReviewCheckMonth(String bookingNum) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT CASE WHEN MONTHS_BETWEEN(SYSDATE, CHECKOUTDATE)<=3"
				+ " AND CHECKOUTDATE < SYSDATE"
				+ " THEN 1 ELSE 0"
				+ " END AS CHECKMONTH"
				+ " FROM BOOKING"
				+ " WHERE BOOKINGNUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bookingNum);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
		{
			result = rs.getInt("CHECKMONTH");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
	
	

	
}



