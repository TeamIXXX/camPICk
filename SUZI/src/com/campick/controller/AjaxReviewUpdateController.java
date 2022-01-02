/*======================================================
	AjaxReviewUpdateController.java
	- 사용자 정의 컨트롤러
	- 리뷰 수정 ajax 컨트롤러
===========================================================*/

package com.campick.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IReviewDAO;
import com.campick.dto.ReviewDTO;

public class AjaxReviewUpdateController implements Controller
{
	private IReviewDAO reviewDao;
	
	public void setReviewDao(IReviewDAO reviewDao)
	{
		this.reviewDao = reviewDao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 로그인 세션 처리 들어가야함.
		// 세션 처리 추가
		/*
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			mav.setViewName("redirect:campick.wei");
			return mav;
		}
		else if (!session.getAttribute("account").equals("camper")) 
		{
			mav.setViewName("redirect:campick.wei");
			return mav;
		}
		*/
		
		try
		{
			int result = 0;
			ReviewDTO review = new ReviewDTO();
			
			String content = request.getParameter("content");
			String contentNum = request.getParameter("contentNum");
			
			review.setContentNum(Integer.parseInt(contentNum));
			review.setContent(content);
			
			result = reviewDao.modifyReview(review);
			
			mav.addObject("result", result);
			mav.setViewName("/WEB-INF/view/AjaxReviewUpdate.jsp");
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
