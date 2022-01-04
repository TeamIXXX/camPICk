/*===========================
	ReviewControlDTO.java
=============================*/

package com.campick.dto;

import org.springframework.web.bind.annotation.RequestParam;

public class ReviewControlDTO
{
	private int start, end, pageNum;
	private String campgroundId, sortKey, sortOrder;
	
	
	public int getStart()
	{
		return start;
	}
	public void setStart(int start)
	{
		this.start = start;
	}
	public int getEnd()
	{
		return end;
	}
	public void setEnd(int end)
	{
		this.end = end;
	}
	public String getCampgroundId()
	{
		return campgroundId;
	}
	public void setCampgroundId(String campgroundId)
	{
		this.campgroundId = campgroundId;
	}
	public String getSortKey()
	{
		return sortKey;
	}
	public void setSortKey(String sortKey)
	{
		this.sortKey = sortKey;
	}
	public String getSortOrder()
	{
		return sortOrder;
	}
	public void setSortOrder(String sortOrder)
	{
		this.sortOrder = sortOrder;
	}
	public int getPageNum()
	{
		return pageNum;
	}
	public void setPageNum(int pageNum)
	{
		this.pageNum = pageNum;
	}
	
	
	
}
