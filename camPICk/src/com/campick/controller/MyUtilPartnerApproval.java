/*===========================
MyUtilPartnerApproval.java
- 게시판 페이징 처리
===========================*/

package com.campick.controller;

public class MyUtilPartnerApproval
{
	// ■ 전체 페이지 수를 구하는 메소드
	// numPerPage : 한 페이지에 표시할 데이터(게시물)의 수
	// dataCount : 전체 데이터(게시물) 수
	public int getPageCount(int numPerPage, int dataCount)
	{
		int pageCount = 0;
		
		pageCount = dataCount/numPerPage;	
		
		// 데이터가 딱 맞아 떨어지지 않을 경우 반올림 필요
		if(dataCount % numPerPage != 0)
			pageCount++;
		
		
		return pageCount;
	}
	//-- 한 페이지에 10개의 게시물을 출력할 때
	//	 총 32 개의 게시물을 페이지로 구성하기 위해서는
	//	 ' 32/10 ' 의 연산을 수행하여 결과 3을 얻을 수 있다.
	//	 -> ' pageCount = dataCount/numPerPage; '
	//	 그런데 이 때, 나머지 2개의 게시물을 출력해 주기 위해서는
	//	  페이지가 하나 더 필요하다.
	
	
	
	// ■ 페이징 처리 기능의 메소드
	// currentPage : 현재 표시할 페이지
	// totalPage : 전체 페이지 수
	// listUrl : 링크 설정할 url
	public String pageIndexList(int currentPage, int totalPage, String listUrl)
	{
		// 실제 페이징을 저장할 StringBuffer 변수
		StringBuffer strList = new StringBuffer();
		
		int numPerBlock = 10;
		//-- 페이징 처리 시 게시물 리스트 하단의 숫자를 10개씩 보여주겠다.
		int currentPageSetup;
		//-- 현재 페이지(이 페이지를 기준으로 보여주는 숫자가 달라져야 하기 때문)
		int page;
		int n;
		//-- 이전 페이지 블럭과 같은 처리에서 이동하기 위한 변수
		//	 (얼마만큼 이동해야 하는지...)
		
		// 페이징 처리가 별도로 필요하지 않은 경우
		//-- 데이터가 존재하지 않거나데이터의 수가
		//	 1 페이지도 못채우는 경우는 별도로 페이징 처리를 할 필요가 없다.
		if(currentPage==0)
			return "";
		
		
		// ※ 페이지 요청을 처리하는 과정에서
		// URL 경로의 패턴에 대한 처리
		/*
		 	- 클라이언트 요청의 형태 -> List.jsp -> (가공) -> List.jsp?
		 	- 클라이언트 요청의 형태 -> List.jsp?subject=study -> (가공) -> List.jsp?subject=study&
		*/
		
		// ○ 링크를 설정할 URL 에 대한 선가공 처리~!~!!!!!!
		if(listUrl.indexOf("?") != -1)	// 링크를 설정할 URL 에 ? 가 있다면
		{
			listUrl = listUrl + "&";	// listUrl += "&";
		}
		else							// 링크를 설정할 URL 에 ? 가 없다면
		{
			listUrl = listUrl + "?";	// listUrl += "?";
		}
		//-- 예를 들어, 검색 값이 존재하면
		//	 이미 request 값에 searchKey 값과 serchValue 값이 들어있는 상황이므로
		//	 & 를 붙여서 추가해 주어야 한다.
		
		
		// currentPageSetup = 표시할 첫 페이지 -1
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock ;
		//-- 만약 현재 페이지가 5페이지 이고(currentPage=5)
		//	 리스트 하단에 보여줄 페이지 갯수가 10 이면(numPerBlock=10)
		//	 5/10 = 0 이며, 여기에 *10 (10을 곱해도) 0 이다.
		//	 하지만, 현재 페이지가 11페이지라면(currentPage=11)
		//	 11/10 = 1 이며, 여기에 *10 (10을 곱하면) 10 이다.
		//	 그러면 currenPageSetup 은 10이 되는 것이다.
		
		if(currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;
			// currentPageSetup -= numPerBlock;
		//-- 만약 위 처리에서 현재 페이지가 20이었다면 (currentPage=20)
		//	 20/10 = 2 이며 여기에 *10 (10을 곱해서)
		//	 20이 되는데
		//	 이와 같은 상황이라면 다시 10을 빼서 10으로 만들어 주기 위한 구문
		
		
		
		// 1 페이지
		if( (totalPage>numPerBlock) && (currentPageSetup>0) )
		{
			strList.append(" <a href='" + listUrl + "pageNum=1'>1</a>");
		}
		//-- listUrl 은 위에서 이미 전처리가 끝난 상황이기 때문에
		//	 ...? 상태 또는 ...?...& 인 상태다.
		//	 이로 인해 결과는 
		//	  ...?pageNum=1 ' 이거나 ' ...&pageNum=1 ' 가 되는 상황이다
		
		
		
		// Prev
		n = currentPage - numPerBlock;	// n : 해당 페이지만큼 앞으로 가기 위한 변수
		if( (totalPage>numPerBlock) && (currentPageSetup>0) )
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Prev</a>");
		//-- currentPageSetup 이 0보다 큰 경우는
		//	 이미 페이지가 10 이상이라는 의미이며
		//	 이 때, 현재 페이지(currentPage) 가 11 이상일 경우
		//	 Prev 를 붙이기 위한 구문.
		//-- Prev 를 클릭할 경우
		//	 n 변수 페이지로 이동하는데 12 에서 Prev 할 경우
		//	 2 페이지가 되고, 22 에서 Prev 할 경우 12 페이지가 될 수 있도록 처리하는 방식.
		
		
		
		// 각 페이지 바로가기
		page = currentPageSetup + 1;
		//-- 『+1』 을 수행하는 이유는
		//	 앞에서 currentPageSetup 에서 10을 가져왔다면
		//	 10부터 시작하는 것이 아니라.
		//	 바로가기 페이지는 11부터 시작해야 하기 때문이다.
		while( (page<=totalPage) && (page<=currentPageSetup+numPerBlock) )
		{
			if(page==currentPage)
			{
				strList.append(" <span style='color:orange; font-weight:bold;'>" + page + "</span>");
			}
			else
			{
				strList.append(" <a href='" + listUrl + "pageNum=" + page + "'>" + page + "</a>");
			}
			
			page++;
		}
		
		
		
		
		// Next
		n = currentPage + numPerBlock;
		if( (totalPage-currentPageSetup) > numPerBlock )
		{
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Next</a>");
		}
		
		
		
		// 마지막 페이지
		if( (totalPage>numPerBlock) && (currentPageSetup+numPerBlock)<totalPage )
		{
			strList.append(" <a href='" + listUrl+ "pageNum=" + totalPage + "'>" + totalPage + "</a>");
		}		
		
		return strList.toString();	
	}//end pageIndexList(int currentPage, int totalPage, String listUrl)
}
