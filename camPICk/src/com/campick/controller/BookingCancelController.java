/*=================================
 * BookingCancelController.java
=================================*/
package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class BookingCancelController implements Controller
{
	private IBookingDAO bookingDao;
	
	public void setbookingDao(IBookingDAO bookingDao)
	{
		this.bookingDao = bookingDao;
	}


	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		try
		{
			BookingDTO  bookingdto = new BookingDTO();
			 
			bookingdto = (BookingDTO)session.getAttribute("bookingDTO");
			int refund = (int)session.getAttribute("refund");   
			
			String bookingNum =  bookingdto.getBookingNum();
						 
			bookingDao.removeBooking(bookingNum, refund);         
			
			// 취소 프로세스에서 썼던 속성 제거.
			session.removeAttribute("bookingDTO");
			session.removeAttribute("refund");
			session.removeAttribute("campgroundDTO");

			mav.setViewName("redirect:bookinglist.wei"); 
		} 
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}
	

}