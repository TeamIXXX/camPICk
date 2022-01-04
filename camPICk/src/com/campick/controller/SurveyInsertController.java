/*==============================
	SurveyInsertController.java
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
import com.campick.dto.SurveyDTO;

public class SurveyInsertController implements Controller
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
		
		//데이터 수신
		
		String campgroundId = request.getParameter("campgroundId");
		String memberNum = request.getParameter("memberNum");
		String themeNum1=request.getParameter("sea");
		String themeNum2=request.getParameter("mem");
		String themeNum3=request.getParameter("vib");
		String firewood=request.getParameter("firewood");
		String textreview=request.getParameter("textreview");
		textreview=textreview.replace("\r\n","<br>");
		String bookingNum = request.getParameter("bookingNum");
		
		// 추후 날짜 지우고 SYSDATE로 변경
		//String surveyDate = "2021-12-26";
		
		String option_name = request.getParameter("option_name");
		String option_check = request.getParameter("option_check");
		
		String[] optionname = option_name.split(",");
		String[] optionck = option_check.split(",");
		
		
		try
		{	
			// 리뷰 설문조사 결과 입력 메소드
			// (CONTENTNUM, BOOKINGNUM, CREATEDATE, CONTENT, FIREWOOD)
			SurveyDTO survey = new SurveyDTO();
			survey.setContent(textreview);
			survey.setFirewood(Integer.parseInt(firewood));
			survey.setBookingNum(bookingNum);
			//survey.setSurveyDate(surveyDate);
			
			dao.reviewAdd(survey);
			
			
			// 테마1 설문조사 결과 입력 메소드
			// (SURVEYNUM, BOOKINGNUM, THEMENUM, SURVEYDATE)
			SurveyDTO theme1 = new SurveyDTO();
			theme1.setBookingNum(bookingNum);
			theme1.setThemeNum(Integer.parseInt(themeNum1));
			//theme1.setSurveyDate(surveyDate);
			
			dao.themeAdd(theme1);

			
			// 테마2 설문조사 결과 입력 메소드
			// (SURVEYNUM, BOOKINGNUM, THEMENUM, SURVEYDATE)
			SurveyDTO theme2 = new SurveyDTO();
			theme2.setBookingNum(bookingNum);
			theme2.setThemeNum(Integer.parseInt(themeNum2));
			//theme2.setSurveyDate(surveyDate);
			
			dao.themeAdd(theme2);

			
			// 테마3 설문조사 결과 입력 메소드
			// (SURVEYNUM, BOOKINGNUM, THEMENUM, SURVEYDATE)
			SurveyDTO theme3 = new SurveyDTO();
			theme3.setBookingNum(bookingNum);
			theme3.setThemeNum(Integer.parseInt(themeNum3));
			//theme3.setSurveyDate(surveyDate);
			
			dao.themeAdd(theme3);
			
			
			// 옵션 설문조사 결과 입력 메소드
			// (SURVEYNUM, BOOKINGNUM, OPTIONNUM, SURVEYSCORE, SURVEYDATE)
			for (int i = 0; i < optionname.length; i++)
			{
				SurveyDTO option = new SurveyDTO();
				option.setBookingNum(bookingNum);
				option.setOptionNum(Integer.parseInt(optionname[i]));
				option.setSurveyScore(Integer.parseInt(optionck[i]));
				//option.setSurveyDate(surveyDate);
				
				dao.optionAdd(option);
			}
			
			mav.addObject("campgroundId", campgroundId);
			mav.setViewName("redirect:campickdetail.wei");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}
	

}
