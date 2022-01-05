/*==============================
	CampgroundSearchController.java
	- 컨트롤러
==============================*/

package com.campick.mycontroller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class CampgroundSearchController
{
	@Autowired
	private SqlSession sqlSession;
	

	@RequestMapping(value="campgroundsearchmybatis.wei", method=RequestMethod.POST)
	public String campgroundSearchList(HttpServletRequest request, Model model)
	{
		String result = "/WEB-INF/view/";
		String keyword = request.getParameter("keyword");
		String sortkey = request.getParameter("sortkey");
		String sortvalue = request.getParameter("sortvalue");
		
		try
		{
			ICampgroundSearchDAO dao = sqlSession.getMapper(ICampgroundSearchDAO.class);
			
			model.addAttribute("campgroundList", dao.campgroundSearchList(keyword, sortkey, sortvalue));
			model.addAttribute("listCount", dao.campgroundSearchListCount(keyword, sortkey, sortvalue));
			
			
			
			result += "CampgroundListAjax.jsp";
						
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	
	@RequestMapping(value="campgroundsearchmybatischeck.wei", method=RequestMethod.POST)
	public String campgroundSearchListCheck(HttpServletRequest request, Model model)
	{
		String result = "/WEB-INF/view/";
		
		String keyword = request.getParameter("keyword");
		String sortkey = request.getParameter("sortkey");
		String sortvalue = request.getParameter("sortvalue");
		String type = request.getParameter("type");
		String option = request.getParameter("option");
		String theme = request.getParameter("theme");
		
		try
		{
			
			ICampgroundSearchDAO dao = sqlSession.getMapper(ICampgroundSearchDAO.class);
			
			if(dao.campgroundSearchListCheckCount(keyword, type, option, theme, sortkey, sortvalue) == 0)
			{
				model.addAttribute("listCount", 0);
			}
			else
			{
				model.addAttribute("campgroundList", dao.campgroundSearchListCheck(keyword, type, option, theme, sortkey, sortvalue));
				model.addAttribute("listCount", 1);
			}
			
			result += "CampgroundListAjax.jsp";
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}
}
