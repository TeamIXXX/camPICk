/*===============================
	OpotionSurvResultDTO.java
	- 설문조사 결과를 담을 DTO
================================*/

package com.campick.dto;

public class OptionSurvResultDTO
{
	// CH.OPTIONNUM, OP.OPTIONNAME, OP.OPTION_TYPENUM, OP.OPTION_TYPENAME, CH.SUM, CH.COUNT, CH.AVG
	private int optionNum, optionTypeNum, sum, count;
	private double avg;
	private String optionName, optionTypeName, campgroundId;
	
	// getter / setter 구성
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
	public int getSum()
	{
		return sum;
	}
	public void setSum(int sum)
	{
		this.sum = sum;
	}
	public int getCount()
	{
		return count;
	}
	public void setCount(int count)
	{
		this.count = count;
	}
	public double getAvg()
	{
		return avg;
	}
	public void setAvg(double avg)
	{
		this.avg = avg;
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
