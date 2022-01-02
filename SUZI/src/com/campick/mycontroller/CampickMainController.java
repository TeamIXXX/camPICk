/*==============================
	CampickMainController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.mycontroller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CampickMainController
{
	@RequestMapping(value = "campick.wei", method = RequestMethod.GET)
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
		return "campgroundlist.wei";
	}
	
	
	@RequestMapping(value = "campickdetail.wei", method = RequestMethod.GET)
	public String toMainTemplateDetail(HttpServletRequest request, Model model)
	{
		String campgroundId = request.getParameter("campgroundId");
		
		model.addAttribute("campgroundId", campgroundId);
		return "/WEB-INF/view/MainTemplateDetail.jsp";
	}

}
