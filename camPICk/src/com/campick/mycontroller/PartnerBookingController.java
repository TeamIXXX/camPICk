/*====================================
	PartnerMainController.java
=====================================*/

package com.campick.mycontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dao.IPartnerBookingDAO;
import com.campick.dao.IPartnerMainDAO;
import com.campick.dto.BookingDTO;
import com.campick.dto.RoomDTO;

@Controller
public class PartnerBookingController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 파트너 예약 페이지로 이동
	@RequestMapping(value = "partnerbookingtemplate.wei", method = RequestMethod.GET)
	public String toPartnerBooking(HttpServletRequest request, ModelMap model)
	{
		String result = "/WEB-INF/view/";
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei"; 
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		try
		{
			IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);
			String campgroundId = dao.getCampgroundId((String)session.getAttribute("num"));
			
			IPartnerBookingDAO bookingDao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			session.setAttribute("campgroundId", campgroundId);
			model.addAttribute("roomList", bookingDao.roomList(campgroundId));
			
			result += "PartnerBookingTemplate.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@RequestMapping(value = "ajaxpartnerbookinglist.wei", method = RequestMethod.GET)
	public String bookingPTList(HttpServletRequest request, ModelMap model)
	/*public String bookingPTList(@RequestParam("campgroundId") String campgroundId, HttpServletRequest request, ModelMap model)*/	
	{
		String result = "/WEB-INF/view/";
		HttpSession session = request.getSession();
		
		
		try
		{
			String campgroundId = (String) session.getAttribute("campgroundId");
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			model.addAttribute("lists", dao.bookingPTList(campgroundId));
			
			result += "AjaxPartnerBookingList.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@RequestMapping(value = "ajaxpartnerdailybookinglist.wei", method = RequestMethod.GET)
	public String bookingDailyList(HttpServletRequest request, ModelMap model)
	{
		String result = "/WEB-INF/view/";
		HttpSession session = request.getSession();
		
		try
		{
			String campgroundId = (String) session.getAttribute("campgroundId");
			String date = request.getParameter("date");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			model.addAttribute("lists", dao.bookingDailyList(campgroundId, date));
			
			result += "AjaxPartnerDailyBookingList.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	
	
}
