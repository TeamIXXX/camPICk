/*==============================
	SampleController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class AjaxBookingDetailModalController implements Controller
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
		BookingDTO bookingDTO = new BookingDTO();
		try
		{
			String bookingNum = request.getParameter("bookingNum");
			
			bookingDTO = bookingDao.searchBookingNum(bookingNum);
	
			mav.addObject("bookingDTO", bookingDTO);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("/WEB-INF/view/AjaxBookingDetailModal.jsp");
		return mav;
	}
	

}
