package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ICampgroundInsertDAO;
import com.campick.dto.CampgroundDTO;

public class PartnerCampgroundController implements Controller
{	
	private ICampgroundInsertDAO campgroundInsertDao;
	
	public void setCampgroundInsertDao(ICampgroundInsertDAO campgroundInsertDao)
	{
		this.campgroundInsertDao = campgroundInsertDao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		
		String num = (String) session.getAttribute("num");
		
		CampgroundDTO campground = new CampgroundDTO();
		
		//System.out.println(num);
		
		/*
		if (num == null)
		{
			mav.setViewName("redirect:loginrequest.wei");
			return mav;
		}
		else if (!(session.getAttribute("account").equals("partner")))
		{
			mav.setViewName("redirect:limit.wei");
			return mav;
		}
		*/	

		try
		{
			String campgroundName = request.getParameter("name");
			String checkInDate = request.getParameter("checkin");
			String checkOutDate = request.getParameter("checkout");
			int policyStandard1 = Integer.parseInt(request.getParameter("ps1"));
			int policyStandard2 = Integer.parseInt(request.getParameter("ps2"));
			int policyStandard3 = Integer.parseInt(request.getParameter("ps3"));
			String option = request.getParameter("option");
			String address1 = request.getParameter("ad1");
			String address2 = request.getParameter("ad2");
			String address3 = request.getParameter("ad3");
			String tel = request.getParameter("tel");
			String extraInfo = request.getParameter("extra");
			
			//System.out.println(num);
			//System.out.println("캠핑장이름" + campgroundName);
			//System.out.println(option);
			
				
			campground.setParterNum(num);
			campground.setCampgroundName(campgroundName);
			campground.setCheckInDate(checkInDate);
			campground.setCheckOutDate(checkOutDate);
			campground.setPolicyStandard1(policyStandard1);
			campground.setPolicyStandard2(policyStandard2);
			campground.setPolicyStandard3(policyStandard3);
			campground.setAddress1(address1);
			campground.setAddress2(address2);
			campground.setAddress3(address3);
			campground.setTel(tel);
			campground.setExtraInfo(extraInfo);
			campground.setOptionSelect(option);
			
			campgroundInsertDao.addCampground(campground);
			
			mav.setViewName("/WEB-INF/view/PartnerMain.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("/WEB-INF/view/PartnerMain.jsp");

		return mav;
		
	}
	

}
