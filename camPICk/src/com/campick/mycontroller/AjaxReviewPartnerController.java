/*=======================================================================
	AjaxReviewPartnerController.java
	- mybatis, annotation 을 활용한 파트너쪽 리뷰 관련 처리 컨트롤러
=========================================================================*/

package com.campick.mycontroller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.controller.MyUtilReview;
import com.campick.dao.IReviewPartnerDAO;
import com.campick.dto.ReviewControlDTO;
import com.campick.dto.ReviewDTO;

@Controller
public class AjaxReviewPartnerController
{
	@Autowired
	private SqlSession sqlSession;
	
	
	// 리뷰 리스트 조회
	@RequestMapping(value = "ajaxreviewpartner.wei", method = RequestMethod.GET)
	public String reviewList(ReviewControlDTO dto, ModelMap model, HttpServletRequest request)
	{
		IReviewPartnerDAO dao = sqlSession.getMapper(IReviewPartnerDAO.class);
		
		// 세션 처리 추가(추후)
		HttpSession session = request.getSession(); 
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei";
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		// 페이징을 위한 util.java
		MyUtilReview myUtilReview = new MyUtilReview();
		
		// 넘어온(요청된) 페이지 번호 확인
		//String pageNum = request.getParameter("pageNum");
		
		// 현재 표시되어야 하는 페이지
		int currentPage = 1;

		if(dto.getPageNum()!=0)
			currentPage = dto.getPageNum();
		
		// 전체 리뷰 갯수 구하기
		int dataCount = dao.getReviewCount(dto.getCampgroundId());
		
		// 전체 페이지를 기준으로 총 페이지 수 계산
		int numPerPage = 3;		//-- 한 페이지에 표시할 데이터 갯수
		int totalPage = myUtilReview.getPageCount(numPerPage, dataCount);
		
		// 전체 페이지 수 보다 표시할 페이지가 큰 경우
		// 표시할 페이지를 전체 페이지로 처리
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 데이터베이스에서 가져올 시작과 끝 위치(1페이지의 start/end, 2페이지의 start/end, ... 페이지마다 개수가 다를수있음)
		int start = (currentPage-1) * numPerPage + 1;
		int end = (currentPage * numPerPage);
		
		String pageIndexList = myUtilReview.pageIndexList(currentPage, totalPage, dto.getCampgroundId());
		
		ReviewControlDTO dto2 = new ReviewControlDTO();
		dto2.setCampgroundId(dto.getCampgroundId());
		dto2.setStart(start);
		dto2.setEnd(end);
		dto2.setSortKey(dto.getSortKey());
		dto2.setSortOrder(dto.getSortOrder());
		
		model.addAttribute("lists", dao.getReviewLists(dto2));
		model.addAttribute("pageIndexList", pageIndexList);
		
		return "/WEB-INF/view/AjaxReviewPartner.jsp";
	}
	
	
	
	// 리뷰 댓글 입력(등록)
	@RequestMapping(value = "ajaxreviewreplyinsert.wei", method = RequestMethod.GET)
	public String reviewReplyInsert(ReviewDTO r, HttpServletRequest request)
	{
		IReviewPartnerDAO dao = sqlSession.getMapper(IReviewPartnerDAO.class);
		
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei";
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		
		dao.addReply(r);
		
		return "/WEB-INF/view/  .jsp";
	}
	
	
	// 리뷰 댓글 수정
	@RequestMapping(value = "ajaxreviewreplyupdate.wei", method = RequestMethod.GET)
	public String reviewReplyUpdate(ReviewDTO r, HttpServletRequest request)
	{
		IReviewPartnerDAO dao = sqlSession.getMapper(IReviewPartnerDAO.class);
		
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei";
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		
		//System.out.println(r.getReplyNum() + "/" + r.getReply());
		
		dao.modifyReply(r);
		
		return "/WEB-INF/view/AjaxReviewPartnerUpdate.jsp";
		
	}
	
	// 리뷰 댓글 삭제
	@RequestMapping(value = "ajaxreviewreplydel.wei", method = RequestMethod.GET)
	public String reviewReplyDelete(ReviewDTO r, HttpServletRequest request)
	{
		IReviewPartnerDAO dao = sqlSession.getMapper(IReviewPartnerDAO.class);
		
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei";
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		
		dao.removeReply(r);
		
		return "/WEB-INF/view/AjaxReviewPartnerDelete.jsp";
	}

}
