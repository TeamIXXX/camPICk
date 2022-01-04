/*====================================
	PartnerMainController.java
=====================================*/

package com.campick.mycontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.campick.dao.IPartnerCampgroundDAO;
import com.campick.dao.IPartnerMainDAO;
import com.campick.dao.ISurveyResultDAO;
import com.campick.dao.ISurveyResultPartnerDAO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.PartnerDTO;
import com.campick.dto.ThemeSurvResultDTO;
import com.campick.dto.ThemeSurvResultPartnerDTO;

@Controller
public class PartnerMainController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 파트너 메인 페이지로 이동(사이트맵없는)
	@RequestMapping(value = "partnercampick.wei", method = RequestMethod.GET)
	public String toPartnerMain(HttpServletRequest request)
	{
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
				
		return "/WEB-INF/view/PartnerMain.jsp";
	}
	
	// 메인에서 『캠핑장 관리』 메뉴 선택시 사이트맵 포함된 캠핑장관리 템플릿으로 이동
	@RequestMapping(value = "mycampgroundtemplate.wei", method = RequestMethod.GET)
	public String toMyCampground(HttpServletRequest request, ModelMap model)
	{
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
		
		return "/WEB-INF/view/PartnerMainTemplateCampground.jsp";
	}
	
	// 캠핑장관리 템플릿의 메인영역에 include 되는 페이지
	@RequestMapping(value = "mycampground.wei", method = RequestMethod.GET)
	public String toMyCampgroundInfo(HttpServletRequest request, ModelMap model) throws SQLException
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		
		IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);
		ISurveyResultPartnerDAO surveyResultDao = sqlSession.getMapper(ISurveyResultPartnerDAO.class);

		//효빈추가------------
		IPartnerCampgroundDAO partnerDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		ArrayList<OptionSurvResultDTO> opSurvLists = new ArrayList<OptionSurvResultDTO>();
		ArrayList<ThemeSurvResultPartnerDTO> themeSurvLists = new ArrayList<ThemeSurvResultPartnerDTO>();
		ArrayList<ThemeSurvResultPartnerDTO> themeAllCountLists = new ArrayList<ThemeSurvResultPartnerDTO>();
		int count = dao.checkMyCampground(partnerNum);
		

		//효빈 추가---------------
		CampgroundDTO myCampgroundInfo = new CampgroundDTO();
		
		
		String campgroundId = dao.getCampgroundId(partnerNum);		
		
		
		if (count>0)			// 등록된 캠핑장이 있다면... (캠핑장관리 jsp 호출)
		{
			
			opSurvLists = surveyResultDao.getOptionResult(campgroundId);
			
			
			// 테마 타입별 테마종류 개수
			int typeCount21 = surveyResultDao.getThemeTypeCount(21);
			int typeCount22 = surveyResultDao.getThemeTypeCount(22);
			int typeCount23 = surveyResultDao.getThemeTypeCount(23);
			
			// 테마타입별 총 설문 답변 수
			/*
			int themeResultCount21 = surveyResultDao.getThemeResultCount(21, "CG0001");
			int themeResultCount22 = surveyResultDao.getThemeResultCount(22, "CG0001");
			int themeResultCount23 = surveyResultDao.getThemeResultCount(23, "CG0001");
			*/
			themeAllCountLists = surveyResultDao.getThemeResultCount(campgroundId);
			
			// 테마 결과 리스트 담기
			themeSurvLists = surveyResultDao.getThemeResult(campgroundId);
			
			
			//효빈추가----
			myCampgroundInfo = partnerDao.myCampgroundInfo(partnerNum);
			
			model.addAttribute("campgroundId", campgroundId);
			model.addAttribute("opSurvLists", opSurvLists);
			model.addAttribute("themeSurvLists", themeSurvLists);
			

			//효빈추가-----------
			model.addAttribute("myCampgroundInfo", myCampgroundInfo);		// 캠핑장 세부 정부 출력
			model.addAttribute("roomTypeList", partnerDao.roomTypeList(partnerNum));	// 캠핑장에 따른 객실 유형 출력
			model.addAttribute("comfortsList", partnerDao.comfortsList(partnerNum));	// 편의시설 출력
			model.addAttribute("funList", partnerDao.funList(partnerNum));			// 즐길거리출력
			
			
			return "/WEB-INF/view/MyCampgroundInfo.jsp";
			
		} else					// 등록된 캠핑장이 없다면... ( 캠핑장 등록 폼 jsp 호출. 현재 임의)
		{
			
			return "redirect:partnercampick.wei";
		}
		
		
		
	}
	
}