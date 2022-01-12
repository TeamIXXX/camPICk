/*==============================
	BookingCancelModalController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dto.BookingDTO;

public class BookingCancelModalController implements Controller
{
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		BookingDTO bookingDTO = new BookingDTO();

		try
		{
			bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");
			
	        mav.addObject("bookingDTO" , bookingDTO);
	        
	        mav.setViewName("/WEB-INF/view/BookingCancelModal.jsp");
	         
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
		

}

