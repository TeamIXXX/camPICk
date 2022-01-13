/*==============================
	SampleController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class AjaxBookingListController implements Controller
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
		
		ArrayList<BookingDTO> lists = new ArrayList<BookingDTO>();
		
		try
		{
			String camperNum = request.getParameter("camperNum");
			String status = request.getParameter("status");
			
			if( status.equals("전체"))
				lists = bookingDao.bookingCPList(camperNum);
			if( !status.equals("전체"))
				lists = bookingDao.bookingCPList(camperNum, status);
			
			request.setAttribute("lists", lists);
			mav.setViewName("/WEB-INF/view/AjaxBookingList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
