/*==================================
	SignupController.java
	- 회원가입 관련 컨트롤러
===================================*/

package com.campick.mycontroller;

import java.io.File;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.campick.dao.ISignupDAO;
import com.campick.dto.CamperDTO;
import com.campick.dto.PartnerDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	
	// 아이디, 비밀번호 찾기 폼
	@RequestMapping(value = "/idFindForm.wei", method = RequestMethod.GET)
	public String idPwFindForm()
	{
		return "/WEB-INF/view/IdPwFindTemplate.jsp";
	}
	
	// 아이디 찾기 결과 폼
	@RequestMapping(value = "/idFindResultForm.wei", method = RequestMethod.POST)
	public String idFindResultForm()
	{
		return "/WEB-INF/view/IdPwFindResultTemplate.jsp";
	}
	
	// 캠퍼 비밀번호 찾기 결과 폼
	@RequestMapping(value = "/camperPwFindForm.wei", method = RequestMethod.POST)
	public String camperPwFindResultForm()
	{
		return "/WEB-INF/view/CamperPwResetTemplate.jsp";
	}
	
	// 파트너 비밀번호 찾기 결과 폼
	@RequestMapping(value = "/partnerPwFindForm.wei", method = RequestMethod.POST)
	public String pwFindResultForm()
	{
		return "/WEB-INF/view/PartnerPwResetTemplate.jsp";
	}
	
	// 캠퍼 계정관리 접근 시, 비밀번호 재확인 폼
	@RequestMapping(value = "/checkPwForm.wei", method = RequestMethod.GET)
	public String checkPwForm(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		String num = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{ 
			if (num == null) 
				return "redirect:loginrequest.wei";
			else if (num!=null && !account.equals("camper"))
				return "redirect:limit.wei";

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		model.addAttribute("camper", signupDao.searchCamperId(num));
		
		return "/WEB-INF/view/CheckCamperPwTemplate.jsp";
	}
	
	// 캠퍼 회원 정보 수정 폼
	@RequestMapping(value = "/camperUpdateForm.wei", method = RequestMethod.POST)
	public String camperUpdateForm(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		String num = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{ 
			if (num == null) 
				return "redirect:loginrequest.wei";
			else if (num!=null && !account.equals("camper"))
				return "redirect:limit.wei";

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		model.addAttribute("camper", signupDao.searchCamperId(num));
		
		return "/WEB-INF/view/CamperUpdateTemplate.jsp";
	}
	
	
	
	// 아이디 중복확인 ajax (캠퍼, 파트너)
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
	@RequestMapping(value="/camperUpdate.wei", method = RequestMethod.POST)
	public String modifyCamper(CamperDTO camperDTO, ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		String num = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		
		if (num == null) 
			return "redirect:loginrequest.wei";
		else if (num!=null && !account.equals("camper"))
			return "redirect:limit.wei";
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		signupDao.modifyCamper(camperDTO);
		
		model.addAttribute("num", num);
		
		return "/camperUpdateForm.wei";
	}
	
	// 파트너 회원가입(insert)
	@RequestMapping(value = "/signuppartner.wei", method = RequestMethod.POST)
	public String partnerSignup(HttpServletRequest request)
	{
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		PartnerDTO partner = new PartnerDTO();
		
		String root = request.getSession().getServletContext().getRealPath("/");
		//System.out.println(root);
		//C:\FinalCampick\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\camPICk\
		String fileRoute = root + "saveFile" + File.separator + "licenseFiles";	
		File dir = new File(fileRoute);
		
		if (!dir.exists())
			dir.mkdirs();
		
		String encType = "UTF-8";					//-- 인코딩 방식
		int maxFileSize = 10*1024*1024;
		
		try
		{
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, fileRoute, maxFileSize, encType, new DefaultFileRenamePolicy());
			String fileName = multi.getFilesystemName("partnerSignFile");
			String partnerId = multi.getParameter("partnerId");
			String partnerPw = multi.getParameter("partnerPw");
			String partnerName = multi.getParameter("partnerName");
			String partnerPhone = multi.getParameter("partnerPhone");
			String businesslicense = multi.getParameter("businesslicense");
			String partnerEmail = multi.getParameter("partnerEmail");
			
			// 필수사항들
			partner.setPartnerId(partnerId);
			partner.setPartnerPw(partnerPw);
			partner.setPartnerName(partnerName);
			partner.setPartnerPhone(partnerPhone);
			partner.setBusinesslicense(businesslicense);
			partner.setPartnerEmail(partnerEmail);
			partner.setFileRoute(fileRoute);
			partner.setFileName(fileName);
			
			/*	
			if (partnerEmail!=null)	// 이메일 입력했다면
			{
				partner.setPartnerEmail(partnerEmail);
			}
			else 						// 이메일 입력하지 않았다면
			{
				partner.setPartnerEmail("emailNotExist");
			}

			if (fileName != null)		// 파일 첨부했다면
			{
				partner.setFileRoute(fileRoute);
				partner.setFileName(fileName);
			}
			else 						// 파일 첨부하지 않았다면
			{
				partner.setFileRoute("fileNotExist");
				partner.setFileName("fileNotExist");
			}
			*/			
			
			signupDao.addPartner(partner);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "redirect:signupOkForm.wei";
	}
	
	// 캠퍼 아이디 조회
	@RequestMapping(value="/findCId.wei", method = RequestMethod.POST)
	public String findCId(@Param("camperName")String camperName, @Param("camperPhone")String camperPhone, ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			String id = signupDao.findCId(camperName, camperPhone);
			model.addAttribute("id", id);
			result="idFindResultForm.wei";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 파트너 아이디 조회
	@RequestMapping(value="/findPId.wei", method = RequestMethod.POST)
	public String findPId(@Param("partnerName")String partnerName, @Param("partnerPhone")String partnerPhone, ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			String id = signupDao.findPId(partnerName, partnerPhone);
			model.addAttribute("id", id);
			result="idFindResultForm.wei";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 캠퍼 비밀번호 조회
	@RequestMapping(value="/findCamper.wei", method = RequestMethod.POST)
	public String findCPw(@Param("camperId")String camperId, @Param("camperPhone")String camperPhone, ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			String id = request.getParameter("camperId");
			String phone = request.getParameter("camperPhone");
			model.addAttribute("pw", signupDao.findCPw(id, camperPhone));
			model.addAttribute("id", id);
			model.addAttribute("phone", phone);
			result="/camperPwFindForm.wei";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 파트너 비밀번호 조회
	@RequestMapping(value="/findPartner.wei", method = RequestMethod.POST)
	public String findPPw(@Param("partnerId")String partnerId, @Param("partnerPhone")String partnerPhone, ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			String id = request.getParameter("partnerId");
			String phone = request.getParameter("partnerPhone");
			model.addAttribute("pw", signupDao.findPPw(id, partnerPhone));
			model.addAttribute("id", id);
			model.addAttribute("phone", phone);
			result="/partnerPwFindForm.wei";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 캠퍼 비밀번호 재설정
	@RequestMapping(value="/resetCPw.wei", method = RequestMethod.POST)
	public String resetCPw(@Param("camperPw")String camperPw, @Param("camperId")String camperId
						 , @Param("camperPhone")String camperPhone, ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			signupDao.resetCPw(camperPw, camperId, camperPhone);
			result="/loginform.wei";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 파트너 비밀번호 재설정
	@RequestMapping(value="/resetPPw.wei", method = RequestMethod.POST)
	public String resetPPw(@Param("partnerPw")String partnerPw, @Param("partnerId")String partnerId
						 , @Param("partnerPhone")String partnerPhone, ModelMap model, HttpServletRequest request)
	{
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		
		try
		{
			signupDao.resetPPw(partnerPw, partnerId, partnerPhone);
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/loginform.wei";
	}

	// (최초 회원가입 이후)
	// 승인현황 페이지에서 서류 첨부 후 신청/재신청 버튼 클릭 시, 파일정보 업데이트
	@RequestMapping(value = "signuppartnerfileupdate.wei", method = RequestMethod.POST)
	public String partnerSignupFileUpdate(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		if (partnerNum == null)			// 로그인 x 일경우
		{
			return "redirect:loginrequest.wei";
		}
		else if (partnerNum!=null && !account.equals("partner"))		// 로그인 o && 파트너 회원이 아닐 경우 
		{
			return "redirect:limit.wei";
		}
		
		String partnerId = (String)session.getAttribute("loginId");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		PartnerDTO partner = new PartnerDTO();
		
		String root = request.getSession().getServletContext().getRealPath("/");
		String fileRoute = root + "saveFile" + File.separator + "licenseFiles";	
		File dir = new File(fileRoute);
		if (!dir.exists())
			dir.mkdirs();
		
		String encType = "UTF-8";					//-- 인코딩 방식
		int maxFileSize = 10*1024*1024;
		
		try
		{
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, fileRoute, maxFileSize, encType, new DefaultFileRenamePolicy());
			String fileName = multi.getFilesystemName("partnerSignFile");
			partner.setFileRoute(fileRoute);
			partner.setFileName(fileName);
			partner.setPartnerId(partnerId);
			
			signupDao.updateFile(partner);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "redirect:partneraccounttemplate.wei";
	}
	
	// 파트너 계정관리 접근 시 비밀번호 확인 ajax
	@RequestMapping(value = "ajaxcheckpartnerpw.wei", method = RequestMethod.GET)
	public String getPartnerPw(HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		if (partnerNum == null)			// 로그인 x 일경우
		{
			return "redirect:loginrequest.wei";
		}
		else if (partnerNum!=null && !account.equals("partner"))		// 로그인 o && 파트너 회원이 아닐 경우 
		{
			return "redirect:limit.wei";
		}
		
		String partnerId = request.getParameter("partnerId");
		String partnerPw = request.getParameter("partnerPw");
		PartnerDTO partner = new PartnerDTO();
		
		partner.setPartnerId(partnerId);
		partner.setPartnerPw(partnerPw);
		
		//System.out.println(partnerId);
		//System.out.println(partnerPw);
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		int result = signupDao.checkPartnerPw(partner);
		//System.out.println(result);
		
		model.addAttribute("result", result);
		return "/WEB-INF/view/AjaxCheckPartnerPw.jsp";
	}
	
	// 파트너 계정관리 회원정보 수정 폼
	@RequestMapping(value = "partnerupdateform.wei", method = RequestMethod.GET)
	public String toPartnerUpdateForm(HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		if (partnerNum == null)			// 로그인 x 일경우
		{
			return "redirect:loginrequest.wei";
		}
		else if (partnerNum!=null && !account.equals("partner"))		// 로그인 o && 파트너 회원이 아닐 경우 
		{
			return "redirect:limit.wei";
		}
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		model.addAttribute("partner", signupDao.searchPartner(partnerNum));
		
		return "/WEB-INF/view/PartnerUpdateTemplate.jsp";
	}
	
	// 파트너 계정관리 회원정보 수정 액션 처리
	@RequestMapping(value = "partnerupdate.wei", method = RequestMethod.POST)	
	public String partnerUpdate(PartnerDTO partner, HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		if (partnerNum == null)			// 로그인 x 일경우
		{
			return "redirect:loginrequest.wei";
		}
		else if (partnerNum!=null && !account.equals("partner"))		// 로그인 o && 파트너 회원이 아닐 경우 
		{
			return "redirect:limit.wei";
		}
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		signupDao.modifyPartner(partner);
			
		return "redirect:partnerupdateform.wei";
	}
	

}
