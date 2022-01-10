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
import com.campick.dao.ICampgroundDAO;
import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;

public class BookingCancelFormController implements Controller
{
	private IBookingDAO bookingDao;
	private ICampgroundDAO campgroundDao;
	
	public void setBookingDao(IBookingDAO bookingDao)
	{
		this.bookingDao = bookingDao;
	}
	
	public void setCampgroundDao(ICampgroundDAO campgroundDao)
	{
		this.campgroundDao = campgroundDao;
	}	
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		BookingDTO bookingDTO = new BookingDTO();
		CampgroundDTO campgroundDTO = new CampgroundDTO();
		
		try
		{
			String bookingNum = request.getParameter("bookingNum");
			
			bookingDTO = bookingDao.searchBookingNum(bookingNum);
			int refund = bookingDao.getRefundPolicy(bookingNum);
			campgroundDTO = campgroundDao.campgroundListDetail(bookingDTO.getCampgroundId());
	        
			session.setAttribute("bookingDTO", bookingDTO);
			mav.addObject("refund", refund);
			session.setAttribute("campgroundDTO", campgroundDTO);
	        
	        mav.setViewName("/WEB-INF/view/BookingCancelForm.jsp");
	         
	         
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
