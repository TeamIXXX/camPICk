package com.campick.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.campick.dto.CampgroundDTO;

public class CampgroundInsertDAO implements ICampgroundInsertDAO
{
	private DataSource dataSource;

	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 캠핑장 등록
	@Override
	public int addCampground(CampgroundDTO campgroundDTO) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "{call PRC_CAMPGROUND_INSERT(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		
		CallableStatement cstmt = null;
		
		try
		{
			cstmt = conn.prepareCall(sql);
			
			cstmt.setString(1, campgroundDTO.getParterNum());
			cstmt.setString(2, campgroundDTO.getCampgroundName());
			cstmt.setString(3, campgroundDTO.getAddress1());
			cstmt.setString(4, campgroundDTO.getAddress2());
			cstmt.setString(5, campgroundDTO.getAddress3());
			cstmt.setString(6, campgroundDTO.getTel());
			cstmt.setString(7, campgroundDTO.getExtraInfo());
			cstmt.setString(8, campgroundDTO.getCheckInDate());
			cstmt.setString(9, campgroundDTO.getCheckOutDate());
			cstmt.setInt(10, campgroundDTO.getPolicyStandard1());
			cstmt.setInt(11, campgroundDTO.getPolicyStandard2());
			cstmt.setInt(12, campgroundDTO.getPolicyStandard3());
			cstmt.setString(13, campgroundDTO.getOptionSelect());
			
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
	
	
}
