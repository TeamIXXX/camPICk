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
import com.campick.dao.ISignupDAO;
import com.campick.dao.ISurveyResultDAO;
import com.campick.dao.ISurveyResultPartnerDAO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.PartnerDTO;
import com.campick.dto.ThemeSurvResultDTO;
import com.campick.dto.ThemeSurvResultPartnerDTO;

@Controller
public class PartnerBookingController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 파트너 예약 페이지로 이동
	@RequestMapping(value = "partnerbookingtemplate.wei", method = RequestMethod.GET)
	public String toPartnerBooking(HttpServletRequest request, ModelMap model)
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
		
		
		IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);
		String campgroundId = dao.getCampgroundId((String)session.getAttribute("num"));
		
		model.addAttribute("campgroundId", campgroundId);
		
		return "/WEB-INF/view/PartnerBookingTemplate.jsp";
	}
	

	
	
}
