/*=======================================
	CampgroundList.java
	- 검색결과 목록창에 보여질 리스트 항목
=======================================*/
package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ICampgroundDAO;
import com.campick.dao.IRoomDAO;
import com.campick.dto.CampgroundOptionDTO;
import com.campick.dto.CampgroundThemeDTO;
import com.campick.dto.RoomDTO;


public class CampgroundListController implements Controller
{
	
	private ICampgroundDAO dao;
	
	public void setDao(ICampgroundDAO dao)
	{
		this.dao = dao;
	}
	
	private IRoomDAO roomDao;
	
	public void setRoomDao(IRoomDAO roomDao)
	{
		this.roomDao = roomDao;
	}


	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<CampgroundThemeDTO> campgroundSeason = new ArrayList<CampgroundThemeDTO>();
		ArrayList<CampgroundThemeDTO> campgroundGroupMember = new ArrayList<CampgroundThemeDTO>();
		ArrayList<CampgroundThemeDTO> campgroundMood = new ArrayList<CampgroundThemeDTO>();
		ArrayList<CampgroundOptionDTO> campgroundFun = new ArrayList<CampgroundOptionDTO>();
		ArrayList<CampgroundOptionDTO> campgroundConvenience = new ArrayList<CampgroundOptionDTO>();
		
		ArrayList<RoomDTO> roomType = new ArrayList<RoomDTO>();
		
		try
		{
			campgroundSeason = dao.campgroundThemeSeason();
			campgroundGroupMember = dao.campgroundThemeGroupMember();
			campgroundMood = dao.campgroundThemeMood();
			campgroundFun = dao.campgroundOptionFun();
			campgroundConvenience = dao.campgroundOptionConvenience();
			roomType = roomDao.roomType();
			
			mav.addObject("campgroundSeason", campgroundSeason);
			mav.addObject("campgroundGroupMember", campgroundGroupMember);
			mav.addObject("campgroundMood", campgroundMood);
			mav.addObject("campgroundFun", campgroundFun);
			mav.addObject("campgroundConvenience", campgroundConvenience);
			mav.addObject("roomType", roomType);
			mav.setViewName("/WEB-INF/view/MainHomepage.jsp");
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}