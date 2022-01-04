/*==============================
	PaymentController.java
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

public class PaymentController implements Controller
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
		
		String bookingNum = null;
		try
		{
			BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");
			
			bookingNum = bookingDao.getBookingNum(bookingDTO);
			
			/*
			if (bookingNum != null)	// 예약이 정상적으로 진행, 예약번호 존재. 
			{
				mav.addObject("bookingNum", bookingNum);
				mav.setViewName("/WEB-INF/view/Payment.jsp");
			}
			else // 정상적이 아닌 경로로 접근  
			{
				
				return mav;		
			}
			*/
			session.removeAttribute("bookingDTO");
			mav.addObject("bookingNum", bookingNum);
			mav.setViewName("/WEB-INF/view/Payment.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
