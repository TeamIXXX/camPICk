package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.BookingDTO;
import com.campick.dto.CampgroundDTO;

public interface IBookingDAO
{
	// 예약 추가 
	public int addBooking(BookingDTO booking) throws SQLException;
	
	// 캠퍼 예약 내역 조회 (→ my캠핑장 이용내역)
	public ArrayList<BookingDTO> bookingCPList(String memberNum) throws SQLException;
	
	// 캠퍼 예약 내역 상태별 조회 (→ my캠핑장 이용내역) 
	public ArrayList<BookingDTO> bookingCPList(String memberNum, String status) throws SQLException;
	
	// 파트너 예약 내역 조회 (파트너 예약 관리)
	public ArrayList<BookingDTO> bookingPTList(String campgroundId) throws SQLException;

	// 예약 취소 
	public int removeBooking(String bookingNum, int refund) throws SQLException;
	
	// 예약 → 결제 진행 후 예약번호를 띄워주기 위해. 제일 위에 있는 예약번호 
	public String getBookingNum(BookingDTO booking) throws SQLException;
	
	// 예약번호로 예약 정보 조회 
	public BookingDTO searchBookingNum(String bookingNum) throws SQLException;
	
	// 결제 금액 계산
	public int getAmount(String roomId, String checkInDate, String checkOutDate) throws SQLException;
	
	// 예약 취소 해당 환불 구정 구하기
	public int getRefundPolicy(String bookingNum) throws SQLException;
	
	// 픽한 캠핑장 조회
	public ArrayList<CampgroundDTO> pickList(String memberNum) throws SQLException;
}
