/*==============================
	RoomListController.java
	- 사용자 정의 컨트롤러
	- 객실
===============================*/

package com.campick.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IRoomDAO;
import com.campick.dto.RoomDTO;

public class RoomListController implements Controller
{
	private IRoomDAO roomDao;
	
	public void setRoomDao(IRoomDAO roomDao)
	{
		this.roomDao = roomDao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		//System.out.println("roomList controller start ============================");
		
		String campgroundId = request.getParameter("campgroundId");
		String roomType = request.getParameter("roomTypeNum");
		String checkInDate = request.getParameter("checkInDate");
		String checkOutDate = request.getParameter("checkOutDate");
		
		//System.out.println("campgroundId : " + campgroundId + "roodType : " + roomType + "checkIn : " + checkInDate + "chekOut: " + checkInDate);
		
		RoomDTO roomDTO = new RoomDTO();
		ArrayList<RoomDTO> roomTypeList = new ArrayList<RoomDTO>();
		
		ArrayList<String> dateList = new ArrayList<String>();
		dateList = roomDao.getSelectDate(checkInDate,checkOutDate);
		
		//System.out.println(dateList.get(0).toString());
					
		ArrayList<String> roomList = new ArrayList<String>();
		roomList = roomDao.getPossibleRoom(dateList);
		
		//System.out.println(roomList.get(0).toString());
		
		try
		{
			int roomTypeNum = Integer.parseInt(roomType);
			
			if(roomTypeNum==90)
			{
				for(int i=0; i<roomList.size(); i++)
				{
					roomDTO = roomDao.roomList(campgroundId, roomList.get(i));
					
					//System.out.println(roomDTO.getCampgroundName());
					
					if(roomDTO.getRoomId()!=null)
					{
						roomTypeList.add(roomDTO);
					}
				}	
			}
			else
			{
				for(int i=0; i<roomList.size(); i++)
				{
					roomDTO = roomDao.roomTypeList(campgroundId, roomTypeNum, roomList.get(i));
					
					//System.out.println(roomDTO.getCampgroundName());
					
					if(roomDTO.getRoomId()!=null)
					{
						roomTypeList.add(roomDTO);
					}
				}
			}
			
			
			
			mav.addObject("roomTypeList",roomTypeList);
			
			mav.setViewName("/WEB-INF/view/RoomList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		//System.out.println("============================ roomList controller end ");
		
		return mav;
	}
	

}
