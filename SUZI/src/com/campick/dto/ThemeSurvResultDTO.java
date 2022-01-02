/*==============================
	ThemeSurvResultDTO.java
===============================*/

package com.campick.dto;

public class ThemeSurvResultDTO
{
	// 타입넘버 변수
	// 테마번호, 테마이름, 개수, 결과퍼센트 담을 배열 변수
	private int themeTypeNum;
	private String[] themeName;
	private int[] themeNum, count;
	private double[] themePercent;
	
	// getter / setter 구성
	public int getThemeTypeNum()
	{
		return themeTypeNum;
	}
	public void setThemeTypeNum(int themeTypeNum)
	{
		this.themeTypeNum = themeTypeNum;
	}
	public String[] getThemeName()
	{
		return themeName;
	}
	public void setThemeName(String[] themeName)
	{
		this.themeName = themeName;
	}
	public int[] getThemeNum()
	{
		return themeNum;
	}
	public void setThemeNum(int[] themeNum)
	{
		this.themeNum = themeNum;
	}
	public int[] getCount()
	{
		return count;
	}
	public void setCount(int[] count)
	{
		this.count = count;
	}
	public double[] getThemePercent()
	{
		return themePercent;
	}
	public void setThemePercent(double[] themePercent)
	{
		this.themePercent = themePercent;
	}
	
	
	
	
	
}
