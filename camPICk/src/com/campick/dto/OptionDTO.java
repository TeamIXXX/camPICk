package com.campick.dto;

public class OptionDTO
{
	private int optionNum, optionTypeNum;
	private String score;
	private String optionName, optionTypeName;
	private String campgroundId;

	
	// getter/setter
	public int getOptionNum()
	{
		return optionNum;
	}
	public void setOptionNum(int optionNum)
	{
		this.optionNum = optionNum;
	}
	public int getOptionTypeNum()
	{
		return optionTypeNum;
	}
	public void setOptionTypeNum(int optionTypeNum)
	{
		this.optionTypeNum = optionTypeNum;
	}
	public String getScore()
	{
		return score;
	}
	public void setScore(String score)
	{
		this.score = score;
	}
	public String getOptionName()
	{
		return optionName;
	}
	public void setOptionName(String optionName)
	{
		this.optionName = optionName;
	}
	public String getOptionTypeName()
	{
		return optionTypeName;
	}
	public void setOptionTypeName(String optionTypeName)
	{
		this.optionTypeName = optionTypeName;
	}
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	
	
}
