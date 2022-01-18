/*==============================
	AjaxPickListController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.CampgroundDTO;

public class AjaxPickListController implements Controller
{
	private IBookingDAO bookingDao;
	
	public void setBookingDao(IBookingDAO bookingDao)
	{
		this.bookingDao = bookingDao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<CampgroundDTO> lists = new ArrayList<CampgroundDTO>();
	
		try
		{
			String camperNum = request.getParameter("camperNum");
			
			try
			{
				lists = bookingDao.pickList(camperNum);
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
			
			request.setAttribute("lists", lists);
			mav.setViewName("/WEB-INF/view/AjaxPickList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
