/*==============================
	AjaxBookinglistReviewController.java
	- 내 캠핑장 > 예약내역 > 리뷰보기 
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IReviewDAO;
import com.campick.dto.ReviewDTO;

public class AjaxBookinglistReviewController implements Controller
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
		ReviewDTO review = new ReviewDTO();
		
		try
		{
			String bookingNum = request.getParameter("bookingNum");
			
			int count = reviewDao.getReviewCountForBookingNum(bookingNum);
			
			if (count==0)
			{
				review.setBookingNum("0");
				review.setCheckMonth(reviewDao.getReviewCheckMonth(bookingNum));
				mav.addObject("review", review);
			}
			else
			{
				review = reviewDao.getSpecificReview(bookingNum);
				mav.addObject("review", review);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("/WEB-INF/view/AjaxBookinglistReview.jsp");
		
		return mav;
	}
	

}
