package com.campick.mycontroller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.campick.dto.CampgroundOptionDTO;
import com.campick.dto.CampgroundThemeDTO;
import com.campick.dto.RoomDTO;

@Controller
public class AdminMainController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "admincampick.wei", method = RequestMethod.GET)
	public String toMainTemplateSearch(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campgroundlist.wei";
			
		}
		else if (session.getAttribute("account").equals("partner")) 
		{
			return "redirect:partnercampick.wei";
		}
		
		//model.addAttribute("campgroundId", campgroundId);
		return "/WEB-INF/view/AdminMain.jsp";
	}
	
	
	@RequestMapping(value = "adminmenu.wei", method = RequestMethod.GET)
	public String toMainTemplateDetail(HttpServletRequest request, Model model)
	{
		return "/WEB-INF/view/AdminMenu.jsp";
	}
	
}
