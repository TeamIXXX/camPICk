/*===============================
	IReviewDAO.java
	인터페이스 형태의 리뷰 DAO
=================================*/

package com.campick.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.campick.dto.ReviewDTO;

public interface IReviewDAO
{
	
	// 리뷰 갯수 구하는 메소드(캠핑장 아이디)
	public int getReviewCount(String campgroundId) throws SQLException;
	
	// 특정 영역의 리뷰 리스트를 가져오는 메소드(시작번호, 끝번호, 캠핑장 아이디, 정렬조건, 정렬기준)
	public ArrayList<ReviewDTO> getReviewLists(int start, int end, String campgroundId, String sortKey, String sortOrder) throws SQLException;
	
	// 리뷰 작성(데이터 입력)
	
	// 특정 리뷰 삭제(리뷰 댓글까지 cascade 로 삭제됨)
	public int removeReview(int contentNum) throws SQLException;
	
	// 특정 리뷰 수정
	public int modifyReview(ReviewDTO review) throws SQLException;
	
}
