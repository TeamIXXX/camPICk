/*==============================
	CampgroundDetailController.java
	- 사용자 정의 컨트롤러
	- 상세페이지 > 캠핑장 정보
===============================*/

package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.CampgroundDAO;
import com.campick.dao.ICampgroundDAO;
import com.campick.dao.ICampgroundOptionDAO;
import com.campick.dao.IRoomDAO;
import com.campick.dao.ISurveyResultDAO;
import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.CampgroundOptionDTO;
import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.ThemeSurvResultDTO;

public class CampgroundDetailController implements Controller
{
	private ISurveyResultDAO surveyResultDao;
	
	public void setSurveyResultDao(ISurveyResultDAO surveyResultDao)
	{
		this.surveyResultDao = surveyResultDao;
	}
	
	private ICampgroundDAO campgroundDao;
	
	public void setCampgroundDao(ICampgroundDAO campgroundDao)
	{
		this.campgroundDao = campgroundDao;
	}
	
	private IRoomDAO roomDao;
	
	public void setRoomDao(IRoomDAO roomDao)
	{
		this.roomDao = roomDao;
	}
	
	private ICampgroundOptionDAO campgroundOptionDao;
	
	public void setCampgroundOptionDao(ICampgroundOptionDAO campgroundOptionDao)
	{
		this.campgroundOptionDao = campgroundOptionDao;
	}
	


	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		
		if ( (session.getAttribute("num")!=null) && (!session.getAttribute("account").equals("camper")) ) 
		{
			mav.setViewName("redirect:campick.wei");
			return mav;
		}
		
		if (session.getAttribute("num")!=null)
		{
			String memberNum = (String)session.getAttribute("num");
		}
		
		String campgroundId = request.getParameter("campgroundId");
		
		// 설문조사 관련
		ArrayList<OptionSurvResultDTO> opSurvLists = new ArrayList<OptionSurvResultDTO>();
		ArrayList<ThemeSurvResultDTO> themeSurvLists = new ArrayList<ThemeSurvResultDTO>();
		
		// 객실 관련
		CampgroundDTO campgroundListDetail = new CampgroundDTO();
		
		// 객실 유형 관련
		ArrayList<String> roomTypeName = new ArrayList<String>();
				
		// 편의시설
		ArrayList<CampgroundOptionDTO> comforts = new ArrayList<CampgroundOptionDTO>();
				
		// 즐길거리
		ArrayList<CampgroundOptionDTO> entertain = new ArrayList<CampgroundOptionDTO>();
		
		// 설문리뷰 작성 관련
		ArrayList<BookingDTO> bookingCheckList = new ArrayList<BookingDTO>();
				
				
		try
		{
			// 옵션 결과 리스트
			opSurvLists = surveyResultDao.getOptionResult(campgroundId);
			
			// 테마 타입별 테마종류 개수
			int typeCount21 = surveyResultDao.getThemeTypeCount(21);
			int typeCount22 = surveyResultDao.getThemeTypeCount(22);
			int typeCount23 = surveyResultDao.getThemeTypeCount(23);
			
			// 테마타입별 총 설문 답변 수
			int themeResultCount21 = surveyResultDao.getThemeResultCount(campgroundId, 21);
			int themeResultCount22 = surveyResultDao.getThemeResultCount(campgroundId, 22);
			int themeResultCount23 = surveyResultDao.getThemeResultCount(campgroundId, 23);
			
			// 테마 결과 리스트 담기
			for (int i = 21; i < 24; i++)
			{
				ThemeSurvResultDTO dto = new ThemeSurvResultDTO();
				dto.setThemeTypeNum(i);
				dto.setThemeName(surveyResultDao.getThemeResult(campgroundId, i, surveyResultDao.getThemeTypeCount(i)).getThemeName());
				dto.setThemeNum(surveyResultDao.getThemeResult(campgroundId, i, surveyResultDao.getThemeTypeCount(i)).getThemeNum());
				dto.setCount(surveyResultDao.getThemeResult(campgroundId, i, surveyResultDao.getThemeTypeCount(i)).getCount());
				
				themeSurvLists.add(dto);
			}
			
			// 객실 리스트
			campgroundListDetail = campgroundDao.campgroundListDetail(campgroundId);
			
			// 객실 유형 리스트
			roomTypeName = roomDao.getRoomType(campgroundId);
						
			// 편의시설 리스트
			comforts = campgroundOptionDao.getComforts(campgroundId);
						
			// 즐길거리 리스트
			entertain = campgroundOptionDao.getEntertain(campgroundId);
			
			
			// 설문리뷰 작성 관련
			if ((String)session.getAttribute("num")==null)		// 비회원일 때 
			{
				bookingCheckList = campgroundDao.bookCheckList(campgroundId);
			}
			else
			{
				bookingCheckList = campgroundDao.bookCheckList(campgroundId, (String)session.getAttribute("num"));
			}
			
			mav.addObject("campgroundId", campgroundId);
			mav.addObject("campgroundListDetail", campgroundListDetail);
			mav.addObject("opSurvLists", opSurvLists);
			mav.addObject("themeSurvLists", themeSurvLists);
			mav.addObject("roomTypeName", roomTypeName);
			mav.addObject("comforts", comforts);
			mav.addObject("entertain", entertain);
			
			mav.addObject("bookingCheckList", bookingCheckList);
			
			// 픽한 캠핑장인지 아닌지 체크
			String pickNum = campgroundDao.pickCheck((String)session.getAttribute("num"), campgroundId);
			
			mav.addObject("pickNum", pickNum);
			
			mav.setViewName("/WEB-INF/view/CampgroundDetail.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		

		return mav;
	}
	

}
