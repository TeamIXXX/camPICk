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
		return "/WEB-INF/view/SignTemplate.jsp";
	}
	
	// 캠퍼 회원가입 폼
	@RequestMapping(value = "/signupCamperForm.wei", method = RequestMethod.GET)
	public String showCamperForm()
	{
		return "/WEB-INF/view/SignCamper.jsp";
	}
	
	// 파트너 회원가입 폼
	@RequestMapping(value = "/signupPartnerForm.wei", method = RequestMethod.GET)
	public String showPartnerForm()
	{
		return "/WEB-INF/view/SignPartner.jsp";
	}
	
	// 회원가입 성공 폼
	@RequestMapping(value = "/signupOkForm.wei", method = RequestMethod.GET)
	public String signupOkForm()
	{
		return "/WEB-INF/view/SignOk.jsp";
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
	@RequestMapping(value="/camperInsert.wei", method = RequestMethod.GET)
	public String camperSignup(CamperDTO camperDTO)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		signupDao.addCamper(camperDTO);
		result="redirect:signupOkForm.wei";
		
		return result;
		
	}
	
	// 파트너 회원가입(insert)
	
	
	

}
