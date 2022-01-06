/*==================================
	SignupController.java
	- 회원가입 관련 컨트롤러
===================================*/

package com.campick.mycontroller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dao.ISignupDAO;
import com.campick.dto.CamperDTO;

@Controller
public class SignupController
{
	@Autowired
	private SqlSession sqlSession;
	
	
	// 회원가입 페이지로 이동
	@RequestMapping(value = "signupForm.wei", method = RequestMethod.GET)
	public String showSignupForm()
	{
		return "/WEB-INF/view/Sign.jsp";
	}
	
	
	// 아이디 중복확인 ajax (캠퍼)
	@RequestMapping(value = "ajaxSignupId.wei", method = RequestMethod.GET)
	public String ajaxSignupId(@RequestParam("id") String id, ModelMap model, HttpServletRequest request)
	{
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		int result = signupDao.getSameIdCheck(id);
		// 중복 아이디 있으면1, 없으면0(==사용가능) 반환
		
		model.addAttribute("result", result);
		
		return "/WEB-INF/view/ajaxSignupId.jsp";
	}
	
	
	// 캠퍼 회원가입(insert)
	
	
	
	// 파트너 회원가입(insert)
	
	
	

}
