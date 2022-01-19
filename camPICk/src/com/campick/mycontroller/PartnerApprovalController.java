package com.campick.mycontroller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.campick.controller.MyUtilPartnerApproval;
import com.campick.dao.IPartnerApprovalDAO;
import com.campick.dto.PartnerApprovalDTO;

//미처리한 승인대기
@Controller
public class PartnerApprovalController
{
	@Autowired
	private SqlSession sqlSession;
		
	@RequestMapping(value = "partnerapproval.wei", method = RequestMethod.GET)
	public ModelAndView partnerApprovalList(HttpServletRequest request, HttpServletResponse response)
	{
		IPartnerApprovalDAO dao = sqlSession.getMapper(IPartnerApprovalDAO.class);
		ModelAndView mav = new ModelAndView();
		
		try
		{
			// 페이징을 위한 util.java
			MyUtilPartnerApproval MyUtilPartnerApproval = new MyUtilPartnerApproval();
			
			// 넘어온(요청된) 페이지 번호 확인
			String pageNum = request.getParameter("pageNum");
			
			// 현재 표시되어야 하는 페이지
			int currentPage = 1;
			
			if(pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 전체 리뷰 갯수 구하기
			int dataCount = dao.getPartnerApprovalCount();
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 1;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = MyUtilPartnerApproval.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = (currentPage-1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			
			// 실제 리스트 가져오기
			//ArrayList<PartnerApprovalDTO> lists = dao.partnerApprovalList();
			ArrayList<PartnerApprovalDTO> lists = dao.partnerApprovalList(start, end);
			
			String pageIndexList = MyUtilPartnerApproval.pageIndexList(currentPage, totalPage, "partnerapproval.wei");
			
			mav.addObject("lists", lists);
			mav.addObject("pageIndexList", pageIndexList);
			
			mav.setViewName("/WEB-INF/view/PartnerApproval.jsp");
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	// 승인완료
	@RequestMapping(value = "partnerapproved.wei", method = RequestMethod.GET)
	public ModelAndView partnerApprovedList(HttpServletRequest request, HttpServletResponse response)
	{
		IPartnerApprovalDAO dao = sqlSession.getMapper(IPartnerApprovalDAO.class);
		ModelAndView mav = new ModelAndView();
		
		try
		{
			// 페이징을 위한 util.java
			MyUtilPartnerApproval MyUtilPartnerApproval = new MyUtilPartnerApproval();
			
			// 넘어온(요청된) 페이지 번호 확인
			String pageNum = request.getParameter("pageNum");
			
			// 현재 표시되어야 하는 페이지
			int currentPage = 1;
			
			if(pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 전체 리뷰 갯수 구하기
			int dataCount = dao.getPartnerApprovedCount();
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 1;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = MyUtilPartnerApproval.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = (currentPage-1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			
			// 실제 리스트 가져오기
			ArrayList<PartnerApprovalDTO> lists = dao.partnerApprovalList(start, end);
			
			String pageIndexList = MyUtilPartnerApproval.pageIndexList(currentPage, totalPage, "partnerapproved.wei");
			
			mav.addObject("lists", lists);
			mav.addObject("pageIndexList", pageIndexList);
			
			mav.setViewName("/WEB-INF/view/PartnerApproved.jsp");
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	// 승인 반려 내역
	@RequestMapping(value = "partnernotapproved.wei", method = RequestMethod.GET)
	public ModelAndView partnerNotApprovedList(HttpServletRequest request, HttpServletResponse response)
	{
		IPartnerApprovalDAO dao = sqlSession.getMapper(IPartnerApprovalDAO.class);
		ModelAndView mav = new ModelAndView();
		
		try
		{
			// 페이징을 위한 util.java
			MyUtilPartnerApproval MyUtilPartnerApproval = new MyUtilPartnerApproval();
			
			// 넘어온(요청된) 페이지 번호 확인
			String pageNum = request.getParameter("pageNum");
			
			// 현재 표시되어야 하는 페이지
			int currentPage = 1;
			
			if(pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 전체 리뷰 갯수 구하기
			int dataCount = dao.getPartnerNotApprovedCount();
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 1;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = MyUtilPartnerApproval.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = (currentPage-1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			
			// 실제 리스트 가져오기
			ArrayList<PartnerApprovalDTO> lists = dao.partnerNotApprovedList(start, end);
			
			String pageIndexList = MyUtilPartnerApproval.pageIndexList(currentPage, totalPage, "partnernotapproved.wei");
			
			mav.addObject("lists", lists);
			mav.addObject("pageIndexList", pageIndexList);
			
			mav.setViewName("/WEB-INF/view/PartnerNotApproved.jsp");
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	
	// 승인대기상태 사업자등록증 이미지 모달창 이동
	@RequestMapping(value = "partnerapprovaldmodal.wei", method = RequestMethod.GET)
	public ModelAndView PartnerApprovalBLModal(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mav = new ModelAndView();
		
		try
		{
			String bl = request.getParameter("bl");
			String pi = request.getParameter("pi");
			
			mav.addObject("bl", bl);
			mav.addObject("pi", pi);
			mav.setViewName("/WEB-INF/view/PartnerApprovalBLModal.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	// 승인완료&반려 사업자등록증 이미지 모달창 이동
	@RequestMapping(value = "partnerapprovedmodal.wei", method = RequestMethod.GET)
	public ModelAndView PartnerApprovedBLModal(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mav = new ModelAndView();
		
		try
		{
			mav.setViewName("/WEB-INF/view/PartnerApprovedBLModal.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	// 승인,반려 데이터 Insert 하기
	@RequestMapping(value = "partnerapprovalinsert.wei", method = RequestMethod.GET)
	public ModelAndView PartnerApprovalInsert(HttpServletRequest request, HttpServletResponse response)
	{
		IPartnerApprovalDAO dao = sqlSession.getMapper(IPartnerApprovalDAO.class);
		ModelAndView mav = new ModelAndView();
		
		try
		{
			String pi = request.getParameter("pi");
			int approvalnum = Integer.parseInt(request.getParameter("approvalnum"));
			
			System.out.println(pi);
			System.out.println(approvalnum);
			
			dao.PartnerApprovalInsert(pi, approvalnum);

			mav.setViewName("/WEB-INF/view/PartnerApproval.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
	
}
