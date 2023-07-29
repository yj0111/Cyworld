package com.mystudy.command.guestbook;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.common.Paging;
import com.mystudy.common.PagingController;
import com.mystudy.dao.FriendDAO;
import com.mystudy.dao.GuestBookDAO;
import com.mystudy.vo.GuestBookViewVO;

public class GuestBookCommand implements Command{

	public static void main(String[] args) {

	}

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(">> GuestBookCommand 들어옴");
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int visitHost = Integer.parseInt(request.getParameter("visitHost"));
		
		// 페이징 처리를 위한 Paging 객체 생성
		String cPage = request.getParameter("cPage");
		Paging paging = PagingController.getPaging(visitHost, cPage);
		
   		request.setAttribute("paging", paging);
   		
		int begin = paging.getBegin();
		int end = paging.getEnd();
		
		// visitHost의 방명록을 해당 페이지만큼 리스트로 가져옴
		List<GuestBookViewVO> list = GuestBookDAO.getList(visitHost, begin, end);
		request.setAttribute("gList", list);
		
		// visitHost와 userCode의 친구관계확인
		String relationship = FriendDAO.checkFriend(visitHost, userCode);
		
		request.setAttribute("checkFriend", relationship);
		
		String path = "visit.jsp";
		
		return path;
	}
	

}
