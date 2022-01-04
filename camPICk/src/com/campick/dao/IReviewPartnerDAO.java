/*=====================================
	IReviewPartnerDAO
	- 파트너 리뷰 인터페이스
	- 마이바티스, 어노테이션 활용
======================================*/

package com.campick.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dto.ReviewControlDTO;
import com.campick.dto.ReviewDTO;

public interface IReviewPartnerDAO
{
	// 리뷰 갯수 구하는 메소드(캠핑장 아이디)
	public int getReviewCount(@RequestParam("campgroundId") String campgroundId);
	
	// 특정 영역의 리뷰 리스트를 가져오는 메소드(시작번호, 끝번호, 캠핑장 아이디, 정렬조건, 정렬기준)
	public ArrayList<ReviewDTO> getReviewLists(ReviewControlDTO dto);
	//@RequestParam("start") String start, @RequestParam("end") String end, @RequestParam("campgroundId") String campgroundId, @RequestParam("sortKey") String sortKey, @RequestParam("sortOrder") String sortOrder
	
	// 특정 리뷰에 대한 리뷰 댓글 작성(데이터 입력)
	public int addReply(ReviewDTO review);
	
	// 특정 리뷰 댓글 수정
	public int modifyReply(ReviewDTO review);
	
	// 특정 리뷰 댓글 삭제
	public int removeReply(ReviewDTO review);

}
