package com.campick.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;

import oracle.jdbc.OracleTypes;

public class BookingDAO implements IBookingDAO
{
	private DataSource dataSource;

	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	//예약 추가 
	@Override
	public int addBooking(BookingDTO booking) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "{call PRC_BOOK_PAY_INSERT( ?, ?, ?, ?, ?, ?, ?, ?)}";
		
		CallableStatement cstmt = null;
		
		try
		{
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, booking.getRoomId());
			cstmt.setString(2, booking.getMemberNum());
			cstmt.setString(3, booking.getName());
			cstmt.setString(4, booking.getPhone());
			cstmt.setString(5, booking.getCheckInDate());
			cstmt.setString(6, booking.getCheckOutDate());
			cstmt.setInt(7, booking.getVisitNum());
			cstmt.setString(8, booking.getRequest());
			
			result = cstmt.executeUpdate();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			cstmt.close();
			conn.close();
		}

		return result;
	}

	// 캠퍼 예약 내역 조회 (→ my캠핑장 이용내역)
	@Override
	public ArrayList<BookingDTO> bookingCPList(String memberNum) throws SQLException
	{
		ArrayList<BookingDTO> result = new ArrayList<BookingDTO>();
		
		Connection conn = dataSource.getConnection();
				
		String sql =  "SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME" 
					+ ", MEMBERNUM, NAME, PHONE" 
					+ ", TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE" 
					+ ", TO_CHAR(CHECKOUTDATE, 'YYYY-MM-DD') AS CHECKOUTDATE" 
					+ ", VISITNUM, PAYMENTAMOUNT" 
					+ ", NVL(REQUEST, ' ') AS REQUEST"
					+ ", TO_CHAR(BOOKINGDATE, 'YYYY-MM-DD') AS BOOKINGDATE" 
					+ ", STATUS" 
					+ " FROM" 
					+ " (" 
					+ " SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME" 
					+ "      , MEMBERNUM, NAME, PHONE" 
					+ "      , CHECKINDATE , CHECKOUTDATE" 
					+ "      , VISITNUM, PAYMENTAMOUNT" 
					+ "      , REQUEST, BOOKINGDATE" 
					+ "      , CASE WHEN BOOKINGNUM IN ( SELECT BOOKINGNUM FROM BOOKING_CANCEL ) THEN '예약 취소' " 
					+ "             WHEN (SYSDATE - CHECKINDATE) >= 0 THEN '이용 완료'" 
					+ "             WHEN (SYSDATE - CHECKINDATE) < 0 THEN '예약 확정'" 
					+ "             ELSE '예약 상태 확인'" 
					+ "        END AS STATUS" 
					+ " FROM BOOKINGVIEW_TOTAL" 
					+ " )" 
					+ " WHERE MEMBERNUM = ? "
		            + " ORDER BY BOOKINGNUM DESC";  
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberNum);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				BookingDTO booking = new BookingDTO();
				booking.setBookingNum(rs.getString("BOOKINGNUM"));
				booking.setRoomId(rs.getString("ROOMID"));
				booking.setRoomName(rs.getString("ROOMNAME"));
				booking.setCampgroundId(rs.getString("CAMPGROUNDID"));
				booking.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				booking.setMemberNum(rs.getNString("MEMBERNUM"));
				booking.setName(rs.getString("NAME"));
				booking.setPhone(rs.getString("PHONE"));
				booking.setCheckInDate(rs.getString("CHECKINDATE"));
				booking.setCheckOutDate(rs.getString("CHECKOUTDATE"));
				booking.setVisitNum(rs.getInt("VISITNUM"));
				booking.setPaymentAmount(rs.getInt("PAYMENTAMOUNT"));
				booking.setRequest(rs.getString("REQUEST"));
				booking.setBookingDate(rs.getString("BOOKINGDATE"));
				booking.setStatus(rs.getString("STATUS"));
				
				result.add(booking);
		
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}
	
	// 캠퍼 예약 내역 상태별 조회 (→ my캠핑장 이용내역)
	@Override
	public ArrayList<BookingDTO> bookingCPList(String memberNum, String status) throws SQLException
	{
		ArrayList<BookingDTO> result = new ArrayList<BookingDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql =  "SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME" 
				+ ", MEMBERNUM, NAME, PHONE" 
				+ ", TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE" 
				+ ", TO_CHAR(CHECKOUTDATE, 'YYYY-MM-DD') AS CHECKOUTDATE" 
				+ ", VISITNUM, PAYMENTAMOUNT" 
				+ ", NVL(REQUEST, ' ') AS REQUEST"
				+ ", TO_CHAR(BOOKINGDATE, 'YYYY-MM-DD') AS BOOKINGDATE" 
				+ ", STATUS" 
				+ " FROM" 
				+ " (" 
				+ " SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME" 
				+ "      , MEMBERNUM, NAME, PHONE" 
				+ "      , CHECKINDATE , CHECKOUTDATE" 
				+ "      , VISITNUM, PAYMENTAMOUNT" 
				+ "      , REQUEST, BOOKINGDATE" 
				+ "      , CASE WHEN BOOKINGNUM IN ( SELECT BOOKINGNUM FROM BOOKING_CANCEL ) THEN '예약 취소' " 
				+ "             WHEN (SYSDATE - CHECKINDATE) >= 0 THEN '이용 완료'" 
				+ "             WHEN (SYSDATE - CHECKINDATE) < 0 THEN '예약 확정'" 
				+ "             ELSE '예약 상태 확인'" 
				+ "        END AS STATUS" 
				+ " FROM BOOKINGVIEW_TOTAL" 
				+ " )" 
				+ " WHERE MEMBERNUM = ? "
	            + " AND STATUS = ? "
	            + " ORDER BY BOOKINGNUM DESC";
		
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberNum);
			pstmt.setString(2, status);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				BookingDTO booking = new BookingDTO();
				booking.setBookingNum(rs.getString("BOOKINGNUM"));
				booking.setRoomId(rs.getString("ROOMID"));
				booking.setRoomName(rs.getString("ROOMNAME"));
				booking.setCampgroundId(rs.getString("CAMPGROUNDID"));
				booking.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				booking.setMemberNum(rs.getNString("MEMBERNUM"));
				booking.setName(rs.getString("NAME"));
				booking.setPhone(rs.getString("PHONE"));
				booking.setCheckInDate(rs.getString("CHECKINDATE"));
				booking.setCheckOutDate(rs.getString("CHECKOUTDATE"));
				booking.setVisitNum(rs.getInt("VISITNUM"));
				booking.setPaymentAmount(rs.getInt("PAYMENTAMOUNT"));
				booking.setRequest(rs.getString("REQUEST"));
				booking.setBookingDate(rs.getString("BOOKINGDATE"));
				booking.setStatus(rs.getString("STATUS"));
				
				result.add(booking);
				
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}

	// 파트너 예약 내역 조회 (파트너 예약 관리)
	@Override
	public ArrayList<BookingDTO> bookingPTList(String campgroundId) throws SQLException
	{
		ArrayList<BookingDTO> result = new ArrayList<BookingDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME"
					+ ", MEMBERNUM, NAME, PHONE" 
					+ ", TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE"
					+ ", TO_CHAR(CHECKOUTDATE, 'YYYY-MM-DD') AS CHECKOUTDATE"
					+ ", VISITNUM, PAYMENTAMOUNT" 
					+ ", NVL(REQUEST, ' ') AS REQUEST"
					+ ", TO_CHAR(BOOKINGDATE, 'YYYY-MM-DD') AS BOOKINGDATE" 
					+ " FROM BOOKINGVIEW" 
					+ " WHERE CAMPGROUNDID = ?"
					+ " ORDER BY BOOKINGDATE DESC";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, campgroundId);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				BookingDTO booking = new BookingDTO();
				booking.setBookingNum(rs.getString("BOOKINGNUM"));
				booking.setRoomId(rs.getString("ROOMID"));
				booking.setRoomName(rs.getString("ROOMNAME"));
				booking.setCampgroundId(rs.getString("CAMPGROUNDID"));
				booking.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				booking.setMemberNum(rs.getNString("MEMBERNUM"));
				booking.setName(rs.getString("NAME"));
				booking.setPhone(rs.getString("PHONE"));
				booking.setCheckInDate(rs.getString("CHECKINDATE"));
				booking.setCheckOutDate(rs.getString("CHECKOUTDATE"));
				booking.setVisitNum(rs.getInt("VISITNUM"));
				booking.setPaymentAmount(rs.getInt("PAYAMOUNT"));
				booking.setRequest(rs.getString("REQUEST"));
				booking.setBookingDate(rs.getString("BOOKINGDATE"));
				
				result.add(booking);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}

	// 예약 취소
	@Override
	public int removeBooking(String bookingNum, int refund) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO BOOKING_CANCEL (CANCELNUM, BOOKINGNUM, MEMBERNUM, CANCELDATE, REFUND)" 
					+ " VALUES( 'BC' || TO_CHAR( SEQBOOK_CAN.NEXTVAL, 'FM0000')" 
				+ ", ?" 
				+ ", ( SELECT MEMBERNUM" 
				+ " FROM BOOKINGVIEW"
				+ " WHERE BOOKINGNUM = ?)"
				+ ", SYSDATE, ?)";
		
		PreparedStatement pstmt = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookingNum);
			pstmt.setString(2, bookingNum);
			pstmt.setInt(3, refund);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			pstmt.close();
			conn.close();
		}
		
		return result;
		
	}

	// 예약 → 결제 진행 후 예약번호를 띄워주기 위해. 
	@Override
	public String getBookingNum(BookingDTO booking) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT BOOKINGNUM" 
				   + " FROM BOOKINGVIEW" 
				   + " WHERE MEMBERNUM = ?" 
				   + " AND ROOMID = ?" 
				   + " AND CHECKINDATE = TO_DATE(?, 'YYYY-MM-DD')";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, booking.getMemberNum());
			pstmt.setString(2, booking.getRoomId());
			pstmt.setString(3, booking.getCheckInDate());
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				result = rs.getString("BOOKINGNUM");
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}

	// 예약번호로 예약 정보 조회
	@Override
	public BookingDTO searchBookingNum(String bookingNum) throws SQLException
	{
		BookingDTO result = new BookingDTO();
			
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT BOOKINGNUM, ROOMID, ROOMNAME, CAMPGROUNDID, CAMPGROUNDNAME"
				   + ", NAME, PHONE"
				   + ", TO_CHAR(CHECKINDATE, 'YYYY-MM-DD') AS CHECKINDATE"
				   + ", TO_CHAR(CHECKOUTDATE, 'YYYY-MM-DD') AS CHECKOUTDATE"
				   + ", VISITNUM, PAYMENTAMOUNT"
				   + ", NVL(REQUEST, ' ') AS REQUEST"
				   + ", TO_CHAR(BOOKINGDATE, 'YYYY-MM-DD') AS BOOKINGDATE"
				   + " FROM BOOKINGVIEW_TOTAL"
				   + " WHERE BOOKINGNUM = ?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookingNum);
		
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				result.setBookingNum(rs.getString("BOOKINGNUM"));
				result.setRoomId(rs.getString("ROOMID"));
				result.setRoomName(rs.getString("ROOMNAME"));
				result.setCampgroundId(rs.getString("CAMPGROUNDID"));
				result.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				result.setName(rs.getString("NAME"));
				result.setPhone(rs.getString("PHONE"));
				result.setCheckInDate(rs.getString("CHECKINDATE"));
				result.setCheckOutDate(rs.getString("CHECKOUTDATE"));
				result.setVisitNum(rs.getInt("VISITNUM"));
				result.setPaymentAmount(rs.getInt("PAYMENTAMOUNT"));
				result.setRequest(rs.getString("REQUEST"));
				result.setBookingDate(rs.getString("BOOKINGDATE"));
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}	
		
		return result;
		
	}

	// 결제 금액 계산
	@Override
	public int getAmount(String roomId, String checkInDate, String checkOutDate) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT FN_GETAMOUNT"
				   + "( ? , TO_DATE( ?, 'YYYY-MM-DD'), TO_DATE( ? , 'YYYY-MM-DD')) AS PAYMENTAMOUNT"
				   + " FROM DUAL";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomId);
			pstmt.setString(2, checkInDate);
			pstmt.setString(3, checkOutDate);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt("PAYMENTAMOUNT");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result; 
	}

	// 예약 취소 해당 환불 구정 구하기
	@Override
	public int getRefundPolicy(String bookingNum) throws SQLException
	{
		int result = -1;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CASE WHEN (FLOOR((SELECT CHECKINDATE FROM BOOKINGVIEW WHERE BOOKINGNUM = ?) - SYSDATE)) >= 10 THEN POLICYSTANDARD3"
				   + "            WHEN (FLOOR((SELECT CHECKINDATE FROM BOOKINGVIEW WHERE BOOKINGNUM = ?) - SYSDATE)) >=4 THEN POLICYSTANDARD2"
				   + "            WHEN (FLOOR((SELECT CHECKINDATE FROM BOOKINGVIEW WHERE BOOKINGNUM = ?) - SYSDATE)) >=0 THEN POLICYSTANDARD1"
				   + "            END AS REFUND"
				   + " FROM REFUNDPOLICY"
				   + " WHERE CAMPGROUNDID = (SELECT CAMPGROUNDID FROM BOOKINGVIEW WHERE BOOKINGNUM = ?)";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookingNum);
			pstmt.setString(2, bookingNum);
			pstmt.setString(3, bookingNum);
			pstmt.setString(4, bookingNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt("REFUND");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}
	
	// 픽한 캠핑장 조회
	public ArrayList<CampgroundDTO> pickList(String memberNum) throws SQLException
	{
		ArrayList<CampgroundDTO> result = new ArrayList<CampgroundDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CGV.CAMPGROUNDID, CAMPGROUNDNAME, ADDRESS1, ADDRESS2, ADDRESS3"
				   + ", EXTRAINFO"
				   + ", PICKCOUNT AS PICK"
				   + ", FIREWOOD"
				   + ", REVIEWCOUNT AS REVIEW"
				   + " FROM CAMPGROUND_VIEW CGV"
				   + " LEFT JOIN PICK P"
				   + " ON CGV.CAMPGROUNDID = P.CAMPGROUNDID"
				   + " WHERE CAMPERNUM = ?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberNum);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				CampgroundDTO dto = new CampgroundDTO();
				
				dto.setCampgroundId(rs.getString("CAMPGROUNDID"));
				dto.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				dto.setAddress1(rs.getString("ADDRESS1"));
				dto.setAddress2(rs.getString("ADDRESS2"));
				dto.setAddress3(rs.getString("ADDRESS3"));
				dto.setExtraInfo(rs.getString("EXTRAINFO"));
				dto.setPick(rs.getInt("PICK"));
				dto.setFirewood(rs.getDouble("FIREWOOD"));
				dto.setReview(rs.getInt("REVIEW"));
				
				result.add(dto);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return result;
	}

}
