/*======================================================
	AjaxReviewController.java
	- 사용자 정의 컨트롤러
	- 리뷰 데이터값과 페이징처리를 위한 ajax 컨트롤러
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

public class AjaxReviewController implements Controller
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

		// 세션 처리 추가 필요(추후)
		HttpSession session = request.getSession();
		
		try
		{
			// 페이징을 위한 util.java
			MyUtilReview myUtilReview = new MyUtilReview();
			
			// 넘어온(요청된) 페이지 번호 확인
			String pageNum = request.getParameter("pageNum");
			
			// 현재 표시되어야 하는 페이지
			int currentPage = 1;
			
			if(pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 캠핑장id, 정렬 키, 오더 값 수신
			String campgroundId = request.getParameter("campgroundId");
			String sortKey = request.getParameter("sortKey");
			String sortOrder = request.getParameter("sortOrder");
			
			// 전체 리뷰 갯수 구하기
			int dataCount = reviewDao.getReviewCount(campgroundId);
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 3;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = myUtilReview.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = (currentPage-1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			
			// 실제 리스트 가져오기
			ArrayList<ReviewDTO> lists = reviewDao.getReviewLists(start, end, campgroundId, sortKey, sortOrder);
			
			String pageIndexList = myUtilReview.pageIndexList(currentPage, totalPage, campgroundId);
			
			mav.addObject("lists", lists);
			mav.addObject("pageIndexList", pageIndexList);
			
			mav.setViewName("/WEB-INF/view/AjaxReview.jsp");
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

}
