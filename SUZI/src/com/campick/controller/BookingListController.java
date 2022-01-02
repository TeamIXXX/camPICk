/*==============================
	SampleController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dto.BookingDTO;

public class BookingListController implements Controller
{
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		
		String num = (String)session.getAttribute("num");

		try
		{ 
			if (num == null) 
			{
				mav.setViewName("redirect:loginrequest.wei");
				return mav;
			} 
			else if (!session.getAttribute("account").equals("camper"))
			{
				mav.setViewName("redirect:limit.wei");
				return mav;
			}
			
			// 연결 전이라서 고정으로 줌
			//mav.addObject("num", num);
			
			mav.setViewName("/WEB-INF/view/BookingList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
