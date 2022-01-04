/*===============================================
	ISampleDAO.java
	- 인터페이스
===============================================*/

package com.campick.mycontroller;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.campick.dto.CampgroundDTO;

public interface ICampgroundSearchDAO
{
	public ArrayList<CampgroundDTO> campgroundSearchList(@Param("keyword") String keyword
			, @Param("sortkey") String sortkey, @Param("sortvalue") String sortvalue);
	
	public int campgroundSearchListCount(@Param("keyword") String keyword
			, @Param("sortkey") String sortkey, @Param("sortvalue") String sortvalue);
	
	public ArrayList<CampgroundDTO> campgroundSearchListCheck(@Param("keyword") String keyword
			,@Param("type") String type, @Param("option") String option, @Param("theme") String theme
			,@Param("sortkey") String sortkey, @Param("sortvalue") String sortvalue);
	
	public int campgroundSearchListCheckCount(@Param("keyword") String keyword
			,@Param("type") String type, @Param("option") String option, @Param("theme") String theme
			,@Param("sortkey") String sortkey, @Param("sortvalue") String sortvalue);
	
	/*public ArrayList<CampgroundDTO> campgroundSearchListCheck(@Param("keyword") String keyword, 
			@Param("typeArr") String[] typeArr, @Param("optionArr") String[] optionArr, @Param("themeArr") String[] themeArr);*/
}
