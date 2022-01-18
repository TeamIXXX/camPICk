package com.campick.dao;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.RoomDTO;

public interface IPartnerBookingDAO
{
	// 파트너 예약 내역 조회 (파트너 예약 관리)
	public ArrayList<BookingDTO> bookingPTList(@RequestParam("campgroundId") String campgroundId);
	
	// 캠핑장에 객실 리스트 
	public ArrayList<RoomDTO> roomList(@RequestParam("campgroundId") String campgroundId);
}
