/*=======================================
	검색창에 기본적으로 보여질 캠핑장 리스트 출력
=======================================*/
package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ICampgroundDAO;
import com.campick.dto.CampgroundDTO;




public class CampgroundListAjaxController implements Controller
{
	
	private ICampgroundDAO dao;
	

	public void setDao(ICampgroundDAO dao)
	{
		this.dao = dao;
	}


	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<CampgroundDTO> campgroundList = new ArrayList<CampgroundDTO>();
		
		try
		{
			campgroundList = dao.campgroundList();
			mav.addObject("campgroundList", campgroundList);
			mav.setViewName("/WEB-INF/view/CampgroundListAjax.jsp");
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}