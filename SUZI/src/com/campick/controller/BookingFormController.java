/*==============================
	BookingFormController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IBookingDAO;
import com.campick.dao.ICampgroundDAO;
import com.campick.dao.IRoomDAO;
import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.RoomDTO;

public class BookingFormController implements Controller
{
	private IBookingDAO bookingDao;
	private IRoomDAO roomDao;
	private ICampgroundDAO campgroundDao;
	
	public void setBookingDao(IBookingDAO bookingDao)
	{
		this.bookingDao = bookingDao;
	}
	
	public void setRoomDao(IRoomDAO roomDao)
	{
		this.roomDao = roomDao;
	}	
	
	public void setCampgroundDao(ICampgroundDAO campgroundDao)
	{
		this.campgroundDao = campgroundDao;
	}	
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		
		String num = (String) session.getAttribute("num");
		
		if (num == null)
		{
			mav.setViewName("redirect:loginrequest.wei");
			return mav;
		}
		else if (!(session.getAttribute("account").equals("camper")))
		{
			mav.setViewName("redirect:limit.wei");
			return mav;
		}	

		try
		{
			String roomId = request.getParameter("roomId");
			String checkInDate = request.getParameter("checkInDate");
			String checkOutDate = request.getParameter("checkOutDate");
			
			BookingDTO booking = new BookingDTO();
			
			// 앞에서부터 넘어온 roomId로 입력폼에 구성할 값을 구해와서, bookingDTO에 구성
			int paymentAmount = bookingDao.getAmount(roomId, checkInDate, checkOutDate);
			RoomDTO room = roomDao.searchRoomId(roomId);
			CampgroundDTO campground = campgroundDao.campgroundListDetail(room.getCampgroundId());
			
			booking.setRoomId(roomId);
			booking.setRoomName(room.getRoomName());
			booking.setCampgroundId(room.getCampgroundId());
			booking.setCampgroundName(room.getCampgroundName());
			booking.setCheckInDate(checkInDate);
			booking.setCheckOutDate(checkOutDate);
			booking.setPaymentAmount(paymentAmount);
			booking.setMemberNum(num);
			
			mav.addObject("roomDTO", room);		// 입력폼에서만 구성할거라서 mav에 보냄
			session.setAttribute("campgroundDTO", campground);
			session.setAttribute("bookingDTO", booking);
			
			mav.setViewName("/WEB-INF/view/BookingForm.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("/WEB-INF/view/BookingForm.jsp");

		return mav;
		
	}
	

}
