/*====================================
	PartnerMainController.java
=====================================*/

package com.campick.mycontroller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.campick.dao.IPartnerCampgroundDAO;
import com.campick.dao.IPartnerMainDAO;
import com.campick.dao.ISignupDAO;
import com.campick.dao.ISurveyResultDAO;
import com.campick.dao.ISurveyResultPartnerDAO;
import com.campick.dto.CampgroundDTO;
import com.campick.dto.OptionSurvResultDTO;
import com.campick.dto.PartnerDTO;
import com.campick.dto.RoomDTO;
import com.campick.dto.ThemeSurvResultDTO;
import com.campick.dto.ThemeSurvResultPartnerDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class PartnerMainController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 파트너 메인 페이지로 이동(사이트맵없는)
	@RequestMapping(value = "partnercampick.wei", method = RequestMethod.GET)
	public String toPartnerMain(HttpServletRequest request, ModelMap model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei"; 
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		// 유동 추가 - 등록된 캠핑장 없을 경우 예약 막으려고 값 추가. 
		IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);				
		int count = dao.checkMyCampground((String)session.getAttribute("num"));
		
		model.addAttribute("count", count);
		return "/WEB-INF/view/PartnerMain.jsp";
	}
	
	
	// 메인에서 『캠핑장 관리』 메뉴 선택 시 이동
	@RequestMapping(value = "mycampgroundtemplate.wei", method = RequestMethod.GET)
	public String toMyCampground(HttpServletRequest request, ModelMap model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		String numStr = (String)session.getAttribute("num");
		
		IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);
		String campgroundId = dao.getCampgroundId(numStr);
		
		// 캠핑장id session 추가
		session.setAttribute("campgroundId",campgroundId);
		
		IPartnerCampgroundDAO partnerDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		//ArrayList<String> numList = partnerDao.partnerCampgroundGet();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei"; 
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
		
		return "/WEB-INF/view/PartnerMainTemplateCampground.jsp"; 
	}
	
	// 캠핑장관리 템플릿의 메인영역에 include 되는 페이지
	// 등록된 캠핑장 유무에 따라 분기
	@RequestMapping(value = "mycampground.wei", method = RequestMethod.GET)
	public String toMyCampgroundInfo(HttpServletRequest request, ModelMap model) throws SQLException
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		
		IPartnerMainDAO dao = sqlSession.getMapper(IPartnerMainDAO.class);
		ISurveyResultPartnerDAO surveyResultDao = sqlSession.getMapper(ISurveyResultPartnerDAO.class);

		//효빈추가------------
		IPartnerCampgroundDAO partnerDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		ArrayList<OptionSurvResultDTO> opSurvLists = new ArrayList<OptionSurvResultDTO>();
		ArrayList<ThemeSurvResultPartnerDTO> themeSurvLists = new ArrayList<ThemeSurvResultPartnerDTO>();
		ArrayList<ThemeSurvResultPartnerDTO> themeAllCountLists = new ArrayList<ThemeSurvResultPartnerDTO>();
		int count = dao.checkMyCampground(partnerNum);
		

		//효빈 추가---------------
		CampgroundDTO myCampgroundInfo = new CampgroundDTO();
		
		
		String campgroundId = dao.getCampgroundId(partnerNum);		
		
		
		if (count>0)			// 등록된 캠핑장이 있다면... (캠핑장관리 jsp 호출)
		{
			opSurvLists = surveyResultDao.getOptionResult(campgroundId);
			
			
			// 테마 타입별 테마종류 개수
			int typeCount21 = surveyResultDao.getThemeTypeCount(21);
			int typeCount22 = surveyResultDao.getThemeTypeCount(22);
			int typeCount23 = surveyResultDao.getThemeTypeCount(23);
			
			// 테마타입별 총 설문 답변 수
			/*
			int themeResultCount21 = surveyResultDao.getThemeResultCount(21, "CG0001");
			int themeResultCount22 = surveyResultDao.getThemeResultCount(22, "CG0001");
			int themeResultCount23 = surveyResultDao.getThemeResultCount(23, "CG0001");
			*/
			themeAllCountLists = surveyResultDao.getThemeResultCount(campgroundId);
			
			// 테마 결과 리스트 담기
			themeSurvLists = surveyResultDao.getThemeResult(campgroundId);
			
			
			//효빈추가----
			myCampgroundInfo = partnerDao.myCampgroundInfo(partnerNum);
			
			model.addAttribute("campgroundId", campgroundId);
			model.addAttribute("opSurvLists", opSurvLists);
			model.addAttribute("themeSurvLists", themeSurvLists);
			

			//효빈추가-----------
			model.addAttribute("myCampgroundInfo", myCampgroundInfo);		// 캠핑장 세부 정부 출력
			model.addAttribute("roomTypeList", partnerDao.roomTypeList(partnerNum));	// 캠핑장에 따른 객실 유형 출력
			model.addAttribute("comfortsList", partnerDao.comfortsList(partnerNum));	// 편의시설 출력
			model.addAttribute("funList", partnerDao.funList(partnerNum));			// 즐길거리출력
			
			
			return "/WEB-INF/view/MyCampgroundInfo.jsp";
			
		} else					// 등록된 캠핑장이 없다면... ( 캠핑장 등록 폼 jsp 호출. 현재 임의)
		{
			
			return "/WEB-INF/view/MyCampgroundInfoInsert.jsp";
		}
	}
	
	// 캠핑장 관리 에서 캠핑장 수정 클릭 시 수정 폼으로 이동
	@RequestMapping(value = "mycampgroundupdatetemplate.wei", method = RequestMethod.GET)
	public String toCampgroundUpdateTemplate(HttpServletRequest request, ModelMap model)
	{
		return "/WEB-INF/view/PartnerMainTemplateCampUpdateForm.jsp";
	}
	
	
	// 캠핑장 수정 템플릿의 메인 영역에 include 되는 페이지
	// 현재 캠핑장 정보를 가져와 뿌려줘야 함.
	// 캠핑장명, 입실시간/퇴실시간, 환불규정1/2/3, 주소1/2/3, 대표번호, 추가정보, 편의시설리스트, 즐길거리리스트, 사진
	@RequestMapping(value = "mycampgroundupdateform.wei", method = RequestMethod.GET)
	public String toCampgroundUpdateForm(HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		
		IPartnerCampgroundDAO campgroundDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		CampgroundDTO myCampgroundInfo = new CampgroundDTO();
		CampgroundDTO guidStandardInfo = new CampgroundDTO();
		myCampgroundInfo = campgroundDao.getCampgroundInfoForUpdate(partnerNum);
		guidStandardInfo = campgroundDao.getGuidStandard();
		
		// 캠핑장 정보 출력
		model.addAttribute("myCampgroundInfo", myCampgroundInfo);					// 캠핑장 정보(환불규정 포함)
		model.addAttribute("comfortsList", campgroundDao.comfortsListForUpdate(partnerNum));	// 편의시설
		model.addAttribute("funList", campgroundDao.funListForUpdate(partnerNum));			// 즐길거리
		model.addAttribute("guidStandardInfo", guidStandardInfo);
		
		return "/WEB-INF/view/MyCampgroundInfoUpdate.jsp";
	}
	
	@RequestMapping(value = "mycampgroundupdate.wei", method = RequestMethod.POST)
	public String updateCampgroundInfo(HttpServletRequest request, ModelMap model)
	{
		IPartnerCampgroundDAO campgroundDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		CampgroundDTO campground = new CampgroundDTO();
		String comfortsStr = "";
		String funStr = "";
				
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
			// 옵션 제외 캠핑장 정보 수정
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, fileRoute, maxFileSize, encType, new DefaultFileRenamePolicy());
			String fileName = multi.getFilesystemName("partnerSignFile");
			campground.setCampgroundId(multi.getParameter("campgroundId"));
			campground.setCampgroundName(multi.getParameter("campgroundName"));
			campground.setAddress1(multi.getParameter("address1"));
			campground.setAddress2(multi.getParameter("address2"));
			campground.setAddress3(multi.getParameter("address3"));
			campground.setTel(multi.getParameter("tel"));
			campground.setExtraInfo(multi.getParameter("extraInfo"));
			campground.setCheckInDate(multi.getParameter("checkInDate"));
			campground.setCheckOutDate(multi.getParameter("checkOutDate"));
			campground.setFileRoute(fileRoute);
			campground.setFileName(fileName);
			campground.setPolicyStandard1(Integer.parseInt(multi.getParameter("policyStandard1")));
			campground.setPolicyStandard2(Integer.parseInt(multi.getParameter("policyStandard2")));
			campground.setPolicyStandard3(Integer.parseInt(multi.getParameter("policyStandard3")));
			
			campgroundDao.modifyCampground(campground);
			
			// 옵션 현황 정보 수정
			// 현재 옵션 삭제
			campgroundDao.removeOptionStatus(multi.getParameter("campgroundId"));
			
			// 선택한 옵션 insert 
			comfortsStr = multi.getParameter("comfortsList");
			funStr = multi.getParameter("funList");
			String[] comfortsList = comfortsStr.split(",");
			for (int i = 0; i < comfortsList.length; i++)
			{
				campgroundDao.addOptionStatus(multi.getParameter("campgroundId"), comfortsList[i]);
				//System.out.println(comfortsList[i]);
			}
			String[] funList = funStr.split(",");
			for (int i = 0; i < funList.length; i++)
			{
				campgroundDao.addOptionStatus(multi.getParameter("campgroundId"), funList[i]);
				//System.out.println(funList[i]);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "redirect:mycampgroundtemplate.wei";
	}
	
	
	
	
	
	//----------------------------------- 계정 관련 -----------------------------
	
	// 계정관리 메뉴 클릭 시 계정관리메인템플릿으로 이동
	@RequestMapping(value = "partneraccounttemplate.wei", method = RequestMethod.GET)
	public String toAccount(HttpServletRequest request)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		if (session.getAttribute("num")==null)
		{
			return "redirect:campick.wei"; 
		}
		else if (!session.getAttribute("account").equals("partner")) 
		{
			return "redirect:campick.wei";
		}
				
		return "/WEB-INF/view/PartnerMainTemplateAccount.jsp";
	}
	
	// 계정관리메인템플릿에서 승인 전이면 승인현황페이지 로드 
	@RequestMapping(value = "partneraccountapproval.wei", method = RequestMethod.GET)
	public String toAccountApproval(HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String partnerId = (String)session.getAttribute("loginId");
		
		ISignupDAO signupDao = sqlSession.getMapper(ISignupDAO.class);
		PartnerDTO dto = new PartnerDTO();
		
		// 승인상태
		dto = signupDao.getApprovalStatus(partnerId);
		int approvalStatusNum = dto.getApprovalStatusNum();
		String approvalStatusName = dto.getApprovalStatusName();
		
		// 서류첨부 여부(대기라면)
		int fileExist = signupDao.getFileExist(partnerId);
		
		model.addAttribute("approvalStatusNum", approvalStatusNum);
		model.addAttribute("approvalStatusName", approvalStatusName);
		model.addAttribute("fileExist", fileExist);
		
		return "/WEB-INF/view/PartnerAccountApproval.jsp";
	}
	

	// 객실 추가 후 캠핑장 관리 페이지로 이동
	@RequestMapping(value = "roominsert.wei", method = RequestMethod.GET)
	public String roomInfoInsert(HttpServletRequest request, ModelMap model) throws SQLException
	{
		HttpSession session = request.getSession();
		String partnerNum = (String)session.getAttribute("num");
		String campgroundId = (String)session.getAttribute("campgroundId");
		
		IPartnerCampgroundDAO partnerDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		RoomDTO room = new RoomDTO();
		
		room.setCampgroundId(campgroundId);
		room.setRoomTypeNum(Integer.parseInt(request.getParameter("roomTypeNum")));
		room.setRoomName(request.getParameter("roomName"));
		room.setBasicNum(Integer.parseInt(request.getParameter("basicNum")));
		room.setMaxNum(Integer.parseInt(request.getParameter("maxNum")));
		room.setWeekDayPrice(Integer.parseInt(request.getParameter("weekDayPrice")));
		room.setWeekEndPrice(Integer.parseInt(request.getParameter("weekEndPrice")));
		room.setRoomInfo(request.getParameter("roomInfo"));
		
		model.addAttribute("roomInfo",partnerDao.roomInsert(room));

		return "redirect:mycampgroundtemplate.wei";
		
	}
	
	
	// 객실 수정 후 캠핑장 관리 페이지로 이동
	@RequestMapping(value = "roomupdate.wei", method = RequestMethod.GET)
	public String roomInfoUpdate(HttpServletRequest request, ModelMap model, RoomDTO room) throws SQLException
	{
		HttpSession session = request.getSession();
		String campgroundId = (String)session.getAttribute("campgroundId");
		
		IPartnerCampgroundDAO partnerDao = sqlSession.getMapper(IPartnerCampgroundDAO.class);
		
		
		System.out.println("출력" + room.getRoomId());
		
		/*
		RoomDTO room = new RoomDTO();
		
		room.setCampgroundId(campgroundId);
		room.setRoomId(roomId);
		room.setRoomTypeNum(Integer.parseInt(request.getParameter("roomTypeNum")));
		room.setRoomName(request.getParameter("roomName"));
		room.setBasicNum(Integer.parseInt(request.getParameter("basicNum")));
		room.setMaxNum(Integer.parseInt(request.getParameter("maxNum")));
		room.setWeekDayPrice(Integer.parseInt(request.getParameter("weekDayPrice")));
		room.setWeekEndPrice(Integer.parseInt(request.getParameter("weekEndPrice")));
		room.setRoomInfo(request.getParameter("roomInfo"));
		*/
		
		model.addAttribute("room",partnerDao.roomInsert(room));

		return "redirect:mycampgroundtemplate.wei";
		
	}
	

	// 계정관리메인템플릿에서 승인 후 계정관리페이지(회원정보수정) 이동을 위한 비밀번호 확인 페이지 로드
	@RequestMapping(value = "checkpartnerpwform.wei", method = RequestMethod.GET)
	public String toAccountManage(HttpServletRequest request, ModelMap model)
	{
		HttpSession session = request.getSession();
		String num = (String)session.getAttribute("num");
		String account = (String)session.getAttribute("account");
		if (num == null)			// 로그인 x 일경우
		{
			return "redirect:loginrequest.wei";
		}
		else if (num!=null && !account.equals("partner"))		// 로그인 o && 파트너 회원이 아닐 경우 
		{
			return "redirect:limit.wei";
		}
		
		return "/WEB-INF/view/CheckPartnerPw.jsp";
	}
	
	

}
