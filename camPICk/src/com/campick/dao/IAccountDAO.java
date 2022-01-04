/*
	인터페이스 형태의 계정 관련 DAO
*/

package com.campick.dao;

import java.sql.SQLException;

public interface IAccountDAO
{
	public String camperLogin(String id, String pw) throws SQLException;
	public String adminLogin(String id, String pw) throws SQLException;
	public String partnerLogin(String id, String pw) throws SQLException;

}