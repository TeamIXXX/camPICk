/*==================================
	SignupController.java
	- 회원가입 관련 컨트롤러
===================================*/

package com.campick.mycontroller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	// 비밀번호 재확인 폼
	@RequestMapping(value = "/checkPwForm.wei", method = RequestMethod.GET)
	public String checkPwForm(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		String num = (String)session.getAttribute("num");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{ 
			if (num == null) 
				return "redirect:loginrequest.wei";
			
			else if (!session.getAttribute("account").equals("camper")
						&& !session.getAttribute("account").equals("partner")
						&& !session.getAttribute("account").equals("admin"))
				return "redirect:limit.wei";

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		model.addAttribute("camper", signupDao.searchCamperId(num));
		
		return "/WEB-INF/view/CheckCamperPw.jsp";
	}
	
	// 캠퍼 회원 정보 수정 폼
	@RequestMapping(value = "/camperUpdateForm.wei", method = RequestMethod.GET)
	public String camperUpdateForm(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		String num = (String)session.getAttribute("num");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{ 
			if (num == null) 
				return "redirect:loginrequest.wei";
			
			else if (!session.getAttribute("account").equals("camper")
						&& !session.getAttribute("account").equals("partner")
						&& !session.getAttribute("account").equals("admin"))
				return "redirect:limit.wei";

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		model.addAttribute("camper", signupDao.searchCamperId(num));
		
		return "/WEB-INF/view/CamperUpdate.jsp";
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
	
	// 캠퍼 회원 정보 수정(update)
	@RequestMapping(value="/camperUpdate.wei", method = RequestMethod.GET)
	public String modifyCamper(CamperDTO camperDTO, ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		String num = (String)session.getAttribute("num");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		signupDao.modifyCamper(camperDTO);
		
		model.addAttribute("num", num);
		
		return "redirect:camperUpdateForm.wei";
	}
	
	// 파트너 회원가입(insert)
	
	
	

}
