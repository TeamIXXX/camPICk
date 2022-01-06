package com.campick.dao;

import java.sql.SQLException;

import com.campick.dto.CampgroundDTO;

public interface ICampgroundInsertDAO
{
	public int addCampground(CampgroundDTO campgroundDTO) throws SQLException;
}
