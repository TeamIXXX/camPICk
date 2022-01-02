/*==============================
	BookingController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class BookingController implements Controller
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
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		int bookCheck = 0; 
		
		try
		{
			
			BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");
			
			if ( bookingDTO == null)	// BookingModal 이외의 경로로 접근 시 
			{
				mav.setViewName("redirect:limit.wei");
				return mav;			
			}
			
			bookCheck = bookingDao.addBooking(bookingDTO);
			
			if(bookCheck > 0)
			{
				mav.setViewName("redirect:payment.wei");
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
