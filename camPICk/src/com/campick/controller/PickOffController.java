/*==============================
	SampleController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ICampgroundDAO;

public class PickOffController implements Controller
{
	private ICampgroundDAO campgroundDao;
	
	public void setCampgroundDao(ICampgroundDAO campgroundDao)
	{
		this.campgroundDao = campgroundDao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		
		try
		{
			String camperNum = (String)session.getAttribute("num");
			String campgroundId = request.getParameter("campgroundId");
			
			campgroundDao.pickOff(camperNum, campgroundId);

			// pickList 여부에 따라 돌아가는 페이지를 다르게 한다.
			if (request.getParameter("pickList") != null)
				mav.setViewName("redirect:bookinglist.wei?pickList="+ request.getParameter("pickList") );
			else
				mav.setViewName("redirect:campickdetail.wei?campgroundId="+campgroundId);
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}
	

}
