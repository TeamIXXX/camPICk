package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.RoomDTO;

public interface IRoomDAO
{
	// 해당 캠핑장의 예약가능한 전체 객실 출력
	public RoomDTO roomList(String campgroundId, String roomId) throws SQLException;
		
	// 해당 캠핑장의 예약가능한 객실 - 유형별 출력
	public RoomDTO roomTypeList(String campgroundId, int roomTypeNum, String roomId) throws SQLException;
	
	//선택한 날짜 사이 날짜 구하기
	public ArrayList<String> getSelectDate(String checkInDate, String checkOutDate) throws SQLException; 
	
	// 예약가능한 모든 ROOMID 출력
	public ArrayList<String> getPossibleRoom(ArrayList<String> datelist) throws SQLException;
	
	// 객실 유형
	public ArrayList<String> getRoomType(String campgroundId) throws SQLException;
	
	// 혜진언니꺼~
	public ArrayList<RoomDTO> roomType() throws SQLException;
	
	// 유동언니
	public RoomDTO searchRoomId(String roomId) throws SQLException;
	
		
}
