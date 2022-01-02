package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.campick.dto.CampgroundOptionDTO;

public class CampgroundOptionDAO implements ICampgroundOptionDAO
{

private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 캠핑장에 대한 편의시설
	@Override
	public ArrayList<CampgroundOptionDTO> getComforts(String campgroundId) throws SQLException
	{
		ArrayList<CampgroundOptionDTO> result = new ArrayList<CampgroundOptionDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT OPTIONNUM, OPTIONNAME FROM OPTION_VIEW1 WHERE CAMPGROUNDID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			CampgroundOptionDTO option = new CampgroundOptionDTO();
			
			option.setOptionNum(rs.getString("OPTIONNUM"));
			option.setOptionName(rs.getString("OPTIONNAME"));
			
			result.add(option);
			
		}
		
		return result;
	}

	// 캠핑장에 대한 즐길거리
	@Override
	public ArrayList<CampgroundOptionDTO> getEntertain(String campgroundId) throws SQLException
	{
		ArrayList<CampgroundOptionDTO> result = new ArrayList<CampgroundOptionDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT OPTIONNUM, OPTIONNAME FROM OPTION_VIEW2 WHERE CAMPGROUNDID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, campgroundId);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			CampgroundOptionDTO option = new CampgroundOptionDTO();
			
			option.setOptionNum(rs.getString("OPTIONNUM"));
			option.setOptionName(rs.getString("OPTIONNAME"));
			
			result.add(option);
			
		}
		
		return result;
	}
	
}
