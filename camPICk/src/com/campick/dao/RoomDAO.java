package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.RoomDTO;

public class RoomDAO implements IRoomDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	@Override
	public ArrayList<RoomDTO> roomType() throws SQLException
	{
		ArrayList<RoomDTO> result = new ArrayList<RoomDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ROOMTYPENUM, ROOMTYPENAME FROM ROOMTYPE";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			RoomDTO room = new RoomDTO();
			
			room.setRoomTypeNum(rs.getInt("ROOMTYPENUM"));
			room.setRoomTypeName(rs.getString("ROOMTYPENAME"));
			
			result.add(room);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	@Override
	public RoomDTO roomList(String campgroundId, String roomId) throws SQLException
	{
		//System.out.println("RoomDAO roomList start ==========================");
		
		//System.out.println("campgroundId: " + campgroundId + " & roomId:" + roomId);
		
		RoomDTO result = new RoomDTO();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ROOMID, ROOMNAME"
				+ ", BASICNUM, MAXNUM, WEEKDAYPRICE, WEEKENDPRICE, ROOMINFO, ROOMTYPENAME"
				+ " FROM ROOMVIEW"
				+ " WHERE CAMPGROUNDID=? AND ROOMID=?";
		
		//System.out.println(sql);
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		pstmt.setString(2, roomId);
		ResultSet rs = pstmt.executeQuery();
		
		//System.out.println(rs.next());
		
		while(rs.next())
		{
			result.setRoomId(rs.getString("ROOMID"));
			result.setRoomName(rs.getString("ROOMNAME"));
			result.setBasicNum(rs.getInt("BASICNUM"));
			result.setMaxNum(rs.getInt("MAXNUM"));
			result.setWeekDayPrice(rs.getInt("WEEKDAYPRICE"));
			result.setWeekEndPrice(rs.getInt("WEEKENDPRICE"));
			result.setRoomInfo(rs.getString("ROOMINFO"));
			result.setRoomTypeName(rs.getString("ROOMTYPENAME"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		//System.out.println("==========================RoomDAO roomList end ");
		
		return result;
	}

	@Override
	public RoomDTO roomTypeList(String campgroundId, int roomTypeNum, String roomId) throws SQLException
	{
		RoomDTO result = new RoomDTO();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ROOMID, ROOMNAME, BASICNUM, MAXNUM"
				+ ", WEEKDAYPRICE, WEEKENDPRICE, ROOMINFO"
				+ " FROM ROOMVIEW"
				+ " WHERE ROOMTYPENUM=? AND CAMPGROUNDID=? AND ROOMID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, roomTypeNum);
		pstmt.setString(2, campgroundId);
		pstmt.setString(3, roomId);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result.setRoomId(rs.getString("ROOMID"));
			result.setRoomName(rs.getString("ROOMNAME"));
			result.setBasicNum(rs.getInt("BASICNUM"));
			result.setMaxNum(rs.getInt("MAXNUM"));
			result.setWeekDayPrice(rs.getInt("WEEKDAYPRICE"));
			result.setWeekEndPrice(rs.getInt("WEEKENDPRICE"));
			result.setRoomInfo(rs.getString("ROOMINFO"));
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 선택한 날짜들 사이 날짜 출력
	@Override
	public ArrayList<String> getSelectDate(String checkInDate, String checkOutDate) throws SQLException
	{
		ArrayList<String> dateList = new ArrayList<String>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT TO_CHAR(TO_DATE( ?, 'YYYY-MM-DD' ) + LEVEL-1, 'YYYY-MM-DD' ) AS DAY" + 
				" FROM DUAL " + 
				" CONNECT BY LEVEL <=( (TO_DATE( ?, 'YYYY-MM-DD' )-1) - TO_DATE( ?, 'YYYY-MM-DD' ) +1 )";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, checkInDate);
		pstmt.setString(2, checkOutDate);
		pstmt.setString(3, checkInDate);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			String date  = rs.getString("DAY");
			dateList.add(date);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return dateList;
	}

	
	// 선택한 날짜 중 가능한 객실 출력
	@Override
	public ArrayList<String> getPossibleRoom(ArrayList<String> datelist) throws SQLException
	{
		//System.out.println("getPossibelRoom start ===========================");
		
		//System.out.println("datelist : " + datelist.toString());
		
		ArrayList<String> roomList = new ArrayList<String>();
		
		Connection conn = dataSource.getConnection();
		String sql = "";
		sql += "SELECT ROOMID FROM ROOMVIEW MINUS SELECT DISTINCT ROOMID FROM BOOKINGVIEW WHERE ";
		for (int i = 0; i < datelist.size(); i++)
		{
			if (i<(datelist.size()-1))
			{
				sql += "(TO_DATE(?, 'YYYY-MM-DD') BETWEEN CHECKINDATE AND (CHECKOUTDATE-1)) OR ";
			}
			else
			{
				sql += "(TO_DATE(?, 'YYYY-MM-DD') BETWEEN CHECKINDATE AND (CHECKOUTDATE-1))";
			}
		}
		
		//System.out.println(sql);
		
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		for (int i = 1; i <= datelist.size(); i++)
		{
			pstmt.setString(i, datelist.get(i-1));
		}
		
		ResultSet rs = pstmt.executeQuery();
		
		//System.out.println(rs.next());
		
		while (rs.next())
		{
			roomList.add(rs.getString("ROOMID"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		//System.out.println(" ===========================getPossibelRoom end");

		return roomList;
	}

	@Override
	public ArrayList<String> getRoomType(String campgroundId) throws SQLException
	{
		//System.out.println("roomdao start ===============================");

		//System.out.println(campgroundId);
		
		ArrayList<String> result = new ArrayList<String>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT DISTINCT ROOMTYPENAME FROM ROOMVIEW WHERE CAMPGROUNDID=?";
		
		//System.out.println(sql);
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();

		while(rs.next())
		{
			result.add(rs.getString("ROOMTYPENAME"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		//System.out.println(result.get(0));

		//System.out.println("=============================== roomdao end ");
				
		return result;
	}
	
	
	
	
	//----------------------- 유동언니 ------------------------------------------
	
	@Override
	public RoomDTO searchRoomId(String roomId) throws SQLException
	{
		RoomDTO result = new RoomDTO();

		Connection conn = dataSource.getConnection();

		String sql = "SELECT CAMPGROUNDID, CAMPGROUNDNAME" 
					+ " , ROOMID, ROOMNAME, ROOMINFO, ROOMTYPENUM"
					+ " , WEEKDAYPRICE, WEEKENDPRICE" 
					+ " , BASICNUM, MAXNUM"
					+ " FROM ROOMVIEW" 
					+ " WHERE ROOMID = ?";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomId);
			rs = pstmt.executeQuery();

			if (rs.next())
			{
				result.setCampgroundId(rs.getString("CAMPGROUNDID"));
				result.setCampgroundName(rs.getString("CAMPGROUNDNAME"));
				result.setRoomId(rs.getString("ROOMID"));
				result.setRoomName(rs.getString("ROOMNAME"));
				result.setRoomInfo(rs.getString("ROOMINFO"));
				result.setRoomTypeNum(rs.getInt("ROOMTYPENUM"));
				result.setWeekDayPrice(rs.getInt("WEEKDAYPRICE"));
				result.setWeekEndPrice(rs.getInt("WEEKENDPRICE"));
				result.setBasicNum(rs.getInt("BASICNUM"));
				result.setMaxNum(rs.getInt("MAXNUM"));

			}
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
	   

	
	
	
	
	
}
