/*==============================
	BookingCancelFormController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class BookingCancelFormController implements Controller
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
		
		BookingDTO bookingDTO = new BookingDTO();
		String bookingNum = null;
		try
		{
			bookingNum = request.getParameter("bookingNum");
			
			bookingDTO = bookingDao.searchBookingNum(bookingNum);
	        
	        session.setAttribute("bookingDTO", bookingDTO);
	         
	        mav.setViewName("/WEB-INF/view/BookingCancelForm.jsp");
	         
	         
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
