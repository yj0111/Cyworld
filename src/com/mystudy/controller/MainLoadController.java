package com.mystudy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.BoardDAO;
import com.mystudy.dao.FriendCommDAO;
import com.mystudy.dao.FriendDAO;
import com.mystudy.dao.ProfileDAO;
import com.mystudy.dao.PushDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.BoardVO;
import com.mystudy.vo.FriendCommVO;
import com.mystudy.vo.FriendVO;
import com.mystudy.vo.ProfileVO;
import com.mystudy.vo.UserVO;


@WebServlet("/login_join/mainLoadController")
public class MainLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println(">> MainLoadController FrontControllerCommand doGet() 실행-------------");
		
		// 메인페이지 전체 불러오는 부분
		
		int userCode = Integer.parseInt(request.getParameter("userCode")); //로그인유저
		int visitHost = Integer.parseInt(request.getParameter("visitHost")); //방문홈피 주인코드
		
		request.setAttribute("userCode", userCode);
		request.setAttribute("visitHost", visitHost);
		
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println("userCode : " + userCode + ", visitHost : " + visitHost);
		
		//친구평 상태
		String state = request.getParameter("state");
		request.setAttribute("state", state);
		
		// 접속자 정보 
		//System.out.println("MainLoadCon에서 userCode : " + userCode);
		UserVO userVO = UserDAO.getUserInfoByCodeDAO(userCode);
		request.setAttribute("userVO", userVO);
		
		
		// Visit 홈페이지 정보
		//System.out.println("홈페이지 주인 Code : " + visitHost);
		UserVO visitHostVO = UserDAO.getUserInfoByCodeDAO(visitHost);
		request.setAttribute("visitHostVO", visitHostVO);
		//System.out.println("홈페이지 주인 VO : " + visitHostVO);
		
		// visitHost으로  PROFILE 테이블 정보 불러오는 부분
		List<ProfileVO> profileList = new ArrayList<>();
		profileList = ProfileDAO.getProHistory(visitHost);
		request.setAttribute("profileList", profileList);
		
		// visitHost으로 친구목록 불러옴
		List<FriendVO> friendList = new ArrayList<>();
		if (userCode == visitHost) {
			friendList = FriendDAO.getList(visitHost);
		}
		request.setAttribute("friendList", friendList);
		
		//친구평 불러오기
		List<FriendCommVO> friendCommList = new ArrayList<>();
		friendCommList = FriendCommDAO.viewFriendComm(visitHost);
		System.out.println("홈페이지 친구평 목록>> : " + friendCommList);
	
		request.setAttribute("friendCommList", friendCommList);
		
		// 새로운 푸시 존재 여부 확인
		int newPushCheck = -1;
		if (userCode == visitHost) {
			newPushCheck = PushDAO.newPushCheck(userCode);
		}
		request.setAttribute("newPushCheck", newPushCheck);
		
		//최근게시글 불러오기
		List<BoardVO> boardList = BoardDAO.getList(visitHost);
		request.setAttribute("boardList", boardList);
		
		//페이지 이동
		request.getRequestDispatcher("../home.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println(">> FrontControllerCommand doPost() 실행-------------");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
