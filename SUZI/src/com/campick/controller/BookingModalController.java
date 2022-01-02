/*==============================
	SampleController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dto.BookingDTO;

public class BookingModalController implements Controller
{
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		// PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		try
		{
			BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");
			
			String name = request.getParameter("name");
			String visitNum = request.getParameter("visitNum");
			String phone = request.getParameter("phone");
			String paramRequest = request.getParameter("request");
			
			bookingDTO.setName(name);
			bookingDTO.setVisitNum(Integer.parseInt(visitNum));
			bookingDTO.setPhone(phone); 
			bookingDTO.setRequest(paramRequest);
			 
			if ( session.getAttribute("num") == null) // BookingForm 이외의 경로로 접근 시 
			{
				mav.setViewName("redirect:loginrequest.wei");				
				return mav;
			} 
			
			mav.addObject("bookingDTO", bookingDTO);
			mav.setViewName("/WEB-INF/view/BookingModal.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;
	}

}
