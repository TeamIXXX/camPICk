/*====================================
	PartnerMainController.java
=====================================*/

package com.campick.mycontroller;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.campick.dao.IPartnerBookingDAO;
import com.campick.dao.IPartnerMainDAO;

@Controller
public class PartnerBookingController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 파트너 예약 페이지로 이동
	@RequestMapping(value = "partnerbookingtemplate.wei", method = RequestMethod.GET)
	public String toPTBooking(HttpServletRequest request, ModelMap model)
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
	
	// 파트너 날짜별 예약 내역 조회
	@RequestMapping(value = "ajaxpartnerbookinglist.wei", method = RequestMethod.GET)
	public String PTbookingList(HttpServletRequest request, ModelMap model)
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
	
	// 캠핑장에 객실 리스트 불러오기
	@RequestMapping(value = "ajaxpartnerdailybookinglist.wei", method = RequestMethod.GET)
	public String PTbookingDailyList(HttpServletRequest request, ModelMap model)
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
	
	// 파트너 예약 취소 모달
	@RequestMapping(value = "ajaxpartnerbookingcancelmodal.wei", method = RequestMethod.GET)
	public String PTbookingCancelModal(HttpServletRequest request, ModelMap model)
	{
		String result = "/WEB-INF/view/";
		
		try
		{
			String bookingNum = request.getParameter("bookingNum");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			model.addAttribute("booking", dao.bookingCancelModal(bookingNum));
			
			result += "AjaxPartnerBookingCancelModal.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 파트너 예약 취소
	@RequestMapping(value = "partnerbookingcancel.wei", method = RequestMethod.GET)
	public String PTbookingCancel(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		try
		{
			String num = (String) session.getAttribute("num");
			String bookingNum = request.getParameter("bookingNum");
			String refund = request.getParameter("refund");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			dao.bookingCancel(bookingNum, num, refund);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 주소 추가
		return "redirect:partnerbookingtemplate.wei";
	}
	
	// 기간 동안 캠핑유형별 개수 세기	
	@RequestMapping(value = "ajaxpartnerchart.wei", method = RequestMethod.GET)
	public String ajaxPTChart(HttpServletRequest request, ModelMap model)
	{
		String result = "/WEB-INF/view/";
		HttpSession session = request.getSession();
		
		try
		{
			String campgroundId = (String) session.getAttribute("campgroundId");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			/*
			String[] arr91 = new String[12];
			String[] arr92 = new String[12];
			String[] arr93 = new String[12];
			String[] arr94 = new String[12];
			
			for (int i = 0; i <= 11; i++)
			{
				String month = String.format("%02d", i+1);
				
				arr91[i] = dao.countRoomtype(campgroundId, month, 91);
				arr92[i] = dao.countRoomtype(campgroundId, month, 92);
				arr93[i] = dao.countRoomtype(campgroundId, month, 93);
				arr94[i] = dao.countRoomtype(campgroundId, month, 94);
			}
			*/
			
			// 예약 수 카운트 → JSON 배열 형식으로 담기 위해 
			StringBuffer sb91 = new StringBuffer();
			StringBuffer sb92 = new StringBuffer();
			StringBuffer sb93 = new StringBuffer();
			StringBuffer sb94 = new StringBuffer();
			
			// 최근 12개월 label → JSON 배열 형식으로 담기 위해
			StringBuffer sbMonth = new StringBuffer();
			
			// 오늘부터 최근 12개월 달 얻어내기 
			Calendar cal = Calendar.getInstance();
			
			// 현재 년, 월
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			
			// 과거 순서대로 배열에 담도록, 11개월 전 ~ 현재
			for (int i = -11; i <= 0; i++)
			{
				if(month + i < 1)
				{
					month = month + 12;
					year = year - 1; 
				}
				
				if(month + i > 12)
				{
					month = month - 12;
					year = year + 1; 
				}
				
				String monthStr = String.format("%02d", month+i);
				String date = year + "-" + monthStr;
				
				sbMonth.append("\"" + date + "\",");
				sb91.append(dao.countRoomtype(campgroundId, date, 91) + ",");
				sb92.append(dao.countRoomtype(campgroundId, date, 92) + ",");
				sb93.append(dao.countRoomtype(campgroundId, date, 93) + ",");
				sb94.append(dao.countRoomtype(campgroundId, date, 94) + ",");
				
				/*
				String month = String.format("%02d", i+1);
				sb91.append(dao.countRoomtype(campgroundId, month, 91) + ",");
				sb92.append(dao.countRoomtype(campgroundId, month, 92) + ",");
				sb93.append(dao.countRoomtype(campgroundId, month, 93) + ",");
				sb94.append(dao.countRoomtype(campgroundId, month, 94) + ",");
				*/
			}
			
			// 제일 끝에 , 삭제
			sbMonth = sbMonth.deleteCharAt(sbMonth.length()-1);
			sb91 = sb91.deleteCharAt(sb91.length()-1);
			sb92 = sb92.deleteCharAt(sb92.length()-1);
			sb93 = sb93.deleteCharAt(sb93.length()-1);
			sb94 = sb94.deleteCharAt(sb94.length()-1);
			
			String arrMonth = "[" + sbMonth.toString() + "]";
			String arr91 = "[" + sb91.toString() + "]";
			String arr92 = "[" + sb92.toString() + "]";
			String arr93 = "[" + sb93.toString() + "]";
			String arr94 = "[" + sb94.toString() + "]";
			
			
			model.addAttribute("arrMonth", arrMonth);
			model.addAttribute("arr91", arr91);
			model.addAttribute("arr92", arr92);
			model.addAttribute("arr93", arr93);
			model.addAttribute("arr94", arr94);
			
			result += "AjaxPartnerChart.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 주소 추가
		return result;
	}
	
	// 기간 동안 예약이 있는지 조회
	@RequestMapping(value = "ajaxptbookingstopcheck.wei", method = RequestMethod.GET)
	public String ajaxPTBookingCheck(HttpServletRequest request, ModelMap model)
	{
		String result = "/WEB-INF/view/";
		
		try
		{
			String roomId = request.getParameter("roomId");
			String checkInDate = request.getParameter("checkInDate");
			String checkOutDate = request.getParameter("checkOutDate");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			int bookingCount = dao.bookingCheck(roomId, checkInDate, checkOutDate);
			
			model.addAttribute("bookingCount", bookingCount);  
			
			result += "AjaxPartnerBookingCheck.jsp";
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 주소 추가
		return result;
		
	}
	
	// 예약 마감
	@RequestMapping(value = "ptbookingstop.wei", method = RequestMethod.GET)
	public String PTbookingStop(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		try
		{
			String num = (String) session.getAttribute("num");
			String roomId = request.getParameter("roomId");
			String checkInDate = request.getParameter("stopStartDate");
			String checkOutDate = request.getParameter("stopEndDate");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			dao.bookingStop(roomId, num, checkInDate, checkOutDate);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "redirect:partnerbookingtemplate.wei";
	}
	
	// 예약 마감
	@RequestMapping(value = "ptbookingstopcancel.wei", method = RequestMethod.GET)
	public String PTbookingStopCancel(HttpServletRequest request)
	{
		try
		{
			String bookingNum = request.getParameter("bookingNum");
			
			IPartnerBookingDAO dao = sqlSession.getMapper(IPartnerBookingDAO.class);
			
			dao.bookingStopCancel(bookingNum);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "redirect:partnerbookingtemplate.wei";
	}
	
	
}
