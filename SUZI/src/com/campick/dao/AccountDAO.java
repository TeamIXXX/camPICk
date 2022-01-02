/*============================
	계정 관련 DAO
	Connectio 객체 주입
==============================*/

package com.campick.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class AccountDAO implements IAccountDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	@Override
	public String camperLogin(String id, String pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String camperNum = null;
		
		String sql = "SELECT CAMPERNUM FROM CAMPER WHERE CAMPERID=? AND CAMPERPW=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			camperNum = rs.getString("CAMPERNUM");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return camperNum;
	}

	@Override
	public String adminLogin(String id, String pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String adminNum = null;
		
		String sql = "SELECT ADMINNUM FROM ADMIN WHERE ADMINID=? AND ADMINPW=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			adminNum = rs.getString("ADMINNUM");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return adminNum;
	}

	@Override
	public String partnerLogin(String id, String pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String partnerNum = null;
		
		String sql = "SELECT PARTNERNUM FROM PARTNER WHERE PARTNERID=? AND PARTNERPW=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			partnerNum = rs.getString("PARTNERNUM");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return partnerNum;
	}
	
	
	

}


