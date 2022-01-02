package com.campick.dto;

public class SurveyDTO
{
	// 주요 속성 구성
	private String campgroundId;			// 캠핑장 아이디
	private String memberNum;				// 캠퍼 회원번호
	//private int surveyNum;					// 설문조사 번호
	
	private String themeTypeName;			// 계절, 구성원, 분위기
	private String themeName;				// 봄~겨울, 혼자~반려동물, 차분함~로맨틱
	private int themeNum;					// 테마별 선택번호
	
	private int optionTypeNum;
	private String optionTypeName;			// 편의시설, 즐길거리
	private int optionNum;
	private String optionName;				// 수세식 등등
	private int surveyScore;				// 옵션 점수

	private int firewood;					// 장작점수
	private String content;					// 설문리뷰글
	private String surveyDate;				// 설문조사일
	private String bookingNum; 				// 예약번호
	
	
	// getter/setter 구성
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	public String getMemberNum()
	{
		return memberNum;
	}
	public void setMemberNum(String memberNum)
	{
		this.memberNum = memberNum;
	}
	/*
	public int getSurveyNum()
	{
		return surveyNum;
	}
	public void setSurveyNum(int surveyNum)
	{
		this.surveyNum = surveyNum;
	}
	*/
	
	public String getThemeTypeName()
	{
		return themeTypeName;
	}
	public void setThemeTypeName(String themeTypeName)
	{
		this.themeTypeName = themeTypeName;
	}
	public String getThemeName()
	{
		return themeName;
	}
	public void setThemeName(String themeName)
	{
		this.themeName = themeName;
	}
	public int getThemeNum()
	{
		return themeNum;
	}
	public void setThemeNum(int themeNum)
	{
		this.themeNum = themeNum;
	}
	
	
	public int getOptionTypeNum()
	{
		return optionTypeNum;
	}
	public void setOptionTypeNum(int optionTypeNum)
	{
		this.optionTypeNum = optionTypeNum;
	}
	public String getOptionTypeName()
	{
		return optionTypeName;
	}
	public void setOptionTypeName(String optionTypeName)
	{
		this.optionTypeName = optionTypeName;
	}
	public int getOptionNum()
	{
		return optionNum;
	}
	public void setOptionNum(int optionNum)
	{
		this.optionNum = optionNum;
	}
	public String getOptionName()
	{
		return optionName;
	}
	public void setOptionName(String optionName)
	{
		this.optionName = optionName;
	}
	public int getSurveyScore()
	{
		return surveyScore;
	}
	public void setSurveyScore(int surveyScore)
	{
		this.surveyScore = surveyScore;
	}

	
	
	public int getFirewood()
	{
		return firewood;
	}
	public void setFirewood(int firewood)
	{
		this.firewood = firewood;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getSurveyDate()
	{
		return surveyDate;
	}
	public void setSurveyDate(String surveyDate)
	{
		this.surveyDate = surveyDate;
	}
	public String getBookingNum()
	{
		return bookingNum;
	}
	public void setBookingNum(String bookingNum)
	{
		this.bookingNum = bookingNum;
	}
	


}
