/*==============================
	LoginController.java
	- 사용자 정의 컨트롤러
===============================*/

package com.campick.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.campick.dao.IAccountDAO;

public class LoginController implements Controller
{
	private IAccountDAO dao;
	
	public void setDao(IAccountDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		String num = null;
		
		try
		{
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String account = request.getParameter("campa");
			
			HttpSession session = request.getSession();
			
			
			if (account.equals("camper"))			// 캠퍼로 체크한 상황
			{
				num = dao.camperLogin(id, pw);
				
				if (num==null)			// 캠퍼로 로그인 실패 → 관리자로 로그인
				{
					num = dao.adminLogin(id, pw);
					
					if (num==null)		// 관리자에도 로그인 실패, 로그인 최종 실패
					{
						mav.setViewName("redirect:loginform.wei");
						return mav;
					}
					
					// 관리자로 로그인 성공
					session.setAttribute("num", num);
					session.setAttribute("account", "admin");
					session.setAttribute("loginId", id);
					mav.setViewName("redirect:campick.wei");
					return mav;
				}
				
				// 캠퍼로 로그인 성공
				session.setAttribute("num", num);
				session.setAttribute("account", "camper");
				session.setAttribute("loginId", id);
				mav.setViewName("redirect:campick.wei");
				
			}
			else									// 파트너로 체크한 상황
			{
				num = dao.partnerLogin(id, pw);
				
				if (num==null)		// 파트너로 로그인 실패 → 관리자로 로그인
				{
					num = dao.adminLogin(id, pw);
					
					if (num==null)		// 관리자에도 로그인 실패, 로그인 최종 실패
					{
						mav.setViewName("redirect:loginform.wei");
						return mav;
					}
					
					// 관리자로 로그인 성공
					session.setAttribute("num", num);
					session.setAttribute("account", "admin");
					session.setAttribute("loginId", id);
					mav.setViewName("redirect:campick.wei");
					return mav;
				}
				
				// 파트너로 로그인 성공
				session.setAttribute("num", num);
				session.setAttribute("account", "partner");
				session.setAttribute("loginId", id);
				mav.setViewName("redirect:partnercampick.wei");
			}
			
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}
	

}
