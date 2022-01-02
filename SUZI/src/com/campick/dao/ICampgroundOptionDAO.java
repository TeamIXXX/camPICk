package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.CampgroundOptionDTO;

public interface ICampgroundOptionDAO
{
	// 편의시설 번호, 이름
	public ArrayList<CampgroundOptionDTO> getComforts(String campgroundId) throws SQLException;
	
	// 즐길거리 번호, 이름
	public ArrayList<CampgroundOptionDTO> getEntertain(String campgroundId) throws SQLException;
}
