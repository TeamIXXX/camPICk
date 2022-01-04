/*=======================================
	캠핑장 옵션 체크 후 검색결과
=======================================*/
package com.campick.controller;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ICampgroundDAO;
import com.campick.dao.IRoomDAO;
import com.campick.dto.CampgroundDTO;


public class CampgroundSearchAjaxController implements Controller
{
	
	private ICampgroundDAO dao;
	
	public void setDao(ICampgroundDAO dao)
	{
		this.dao = dao;
	}

	@Override
	@RequestMapping(value = "/campgroundsearchajax.wei")
	@ResponseBody
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<CampgroundDTO> campgroundSearchList = new ArrayList<CampgroundDTO>();
		
		try
		{
			String keyword = request.getParameter("keyword");
			campgroundSearchList = dao.campgroundSearchList(keyword);
			
			mav.addObject("campgroundList", campgroundSearchList);
			mav.setViewName("/WEB-INF/view/CampgroundListAjax.jsp");
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}