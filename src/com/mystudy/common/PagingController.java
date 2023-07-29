package com.mystudy.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.GuestBookDAO;

public class PagingController {
	

	public static Paging getPaging(int visitHost, String cPage) {
		
		//Map<String, Paging> map = new HashMap<>();
		Paging p = null;
		
		// 페이징 처리를 위한 객체(Paging) 생성
   		p = new Paging();

   		// 1. 전체 게시물 수량 구하기
   		p.setTotalRecord(GuestBookDAO.getTotalCount(visitHost));
   		p.setTotalPage();
   		p.setTotalBlock();
   		
   		//System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
   		//System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
   		
   		// 2. 현재 페이지 구하기
   		//String cPage = request.getParameter("cPage");
   		
   		if(cPage != null) {
    		p.setNowPage(Integer.parseInt(cPage));
   		}
   		
   		//System.out.println("> cPage : " + cPage);
   		//System.out.println("> paging nowPage : " + p.getNowPage());
   		
   		// 3. 현재 페이지 표시할 게시글 시작번호
   		p.setEnd(p.getNowPage() * p.getNumPerPage());
   		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
   		
   		
   		// 3-1. (선택적) 끝번호(end)가 건수보다 많으면 데이터 건수와 동일하게 처리
   		if(p.getEnd() > p.getTotalRecord()) {
    		p.setEnd(p.getTotalRecord());
   		}
    		
   		//System.out.println("현재 페이지 시작 글번호 : " + p.getBegin());
   		//System.out.println("현재 페이지 마지막 글번호 : " + p.getEnd());
   		
   		
   		// ---------------- 블록(block) 계산하기 ----------------
   		// 4. 블록 시작페이지, 끝 페이지 구하기(현재페이지 번호 사용)
   		int nowPage = p.getNowPage();
   		int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
   		p.setBeginPage(beginPage);
   		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
   		
   		// 끝페이지(endPage)가 전체 페이지 수 (totalPage)보다 크면
   		// 끝페이지를 전체페이지 수로 변경 처리
   		if (p.getEndPage() > p.getTotalPage()) {
    		p.setEndPage(p.getTotalPage());
   		}
    		
   		//System.out.println(">> beginPage : " + p.getBeginPage());
   		//System.out.println(">> endPage : " + p.getEndPage());

   		
		//map.put("p", p);
   		
   		// ====================================
   		// DB 데이터 가져오기
   		// 시작번호(begin), 끝번호(end) 사용해서 게시글 조회
   		//List<GuestBookViewVO> glist = GuestBookDAO.getList(p.getBegin(), p.getEnd());
   		
   		//System.out.println(">> 현재페이지 글목록(list) : " + list);
   		
   		// =======================================
   		// EL, JSTL 사용을 위해 scope에 데이터 등록(page 영역)
   		//pageContext.setAttribute("glist", list);
   		//pageContext.setAttribute("pvo", p);
		
		
		return p;
	}

}
