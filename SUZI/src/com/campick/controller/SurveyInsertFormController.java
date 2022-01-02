/*==============================
	SuerveyListController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.ISurveyDAO;
import com.campick.dto.OptionDTO;

public class SurveyInsertFormController implements Controller
{
	private ISurveyDAO dao;
	
	public void setDao(ISurveyDAO dao)
	{
		this.dao = dao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<OptionDTO> optionList = new ArrayList<OptionDTO>();
		try
		{
			//데이터 수신
			String campgroundId= request.getParameter("campgroundId");
			String memberNum= request.getParameter("memberNum");
			String bookingNum= request.getParameter("bookingNum");
			
			optionList = dao.optionlist(campgroundId);
			
			mav.addObject("campgroundId", campgroundId);
			mav.addObject("optionList", optionList);
			mav.addObject("bookingNum", bookingNum);
			mav.addObject("memberNum", memberNum);
			
			mav.setViewName("/WEB-INF/view/SurveyForm.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return mav;
	}
	

}
