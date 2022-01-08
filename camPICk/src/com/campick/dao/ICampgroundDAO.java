package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.CampgroundOptionDTO;
import com.campick.dto.CampgroundThemeDTO;

public interface ICampgroundDAO
{
	public ArrayList<CampgroundDTO> campgroundList() throws SQLException;
	
	public CampgroundDTO campgroundListDetail(String campgroundId) throws SQLException;
	
	public ArrayList<CampgroundThemeDTO> campgroundThemeSeason() throws SQLException;
	public ArrayList<CampgroundThemeDTO> campgroundThemeGroupMember() throws SQLException;
	public ArrayList<CampgroundThemeDTO> campgroundThemeMood() throws SQLException;
	public ArrayList<CampgroundOptionDTO> campgroundOptionConvenience() throws SQLException;
	public ArrayList<CampgroundOptionDTO> campgroundOptionFun() throws SQLException;
	public ArrayList<CampgroundDTO> campgroundSearchList(String keyword) throws SQLException;
	
	
	//////////////////////////진령이 부분 합친 것//////////////////
	public ArrayList<BookingDTO> bookCheckList(String campgroundId, String memberNum) throws SQLException;
	public ArrayList<BookingDTO> bookCheckList(String campgroundId) throws SQLException;
	
	//픽 추가
	public int onPick(String camperNum, String campgroundId) throws SQLException;
	
	//픽 해제
	public int offPick(String camperNum, String campgroundId)throws SQLException;
	
	//pick여부판별
	public String checkPick(String camperNum, String campground) throws SQLException;
}
