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
			 
			String bookingNum =  bookingdto.getBookingNum();
			
			// refund를 30으로 고정
			int refund = 100;   //나중에 환불% 값을 받아올것
			 
			bookingDao.removeBooking(bookingNum, refund);         
			
			mav.setViewName("redirect:bookinglist.wei"); 
		} 
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}
	

}