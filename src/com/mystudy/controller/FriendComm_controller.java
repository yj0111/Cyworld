package com.mystudy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.FriendCommDAO;
import com.mystudy.vo.FriendCommVO;
import com.mystudy.vo.FriendVO;

@WebServlet("/login_join/friendComm")
public class FriendComm_controller extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
												throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		System.out.println(">> friendComm 실행");

		String type = request.getParameter("type");
		
		int visitHost = Integer.parseInt(request.getParameter("visitHost")); //홈피주인
		int guestCode = Integer.parseInt(request.getParameter("userCode"));  //방문자
		
		if ("viewList".equals(type)) { 
			//친구평 전체보기
			List<FriendCommVO> friendCommList = FriendCommDAO.viewFriendComm(visitHost);			
			System.out.println("[friendComm] friendCommList : " + friendCommList);
			String result = makeJason(friendCommList);
			PrintWriter out = response.getWriter();
			out.print(result);
			return;
		} 
		else if ("delete".equals(type)) { 
			//친구평 삭제
			int friendCommCode = Integer.parseInt(request.getParameter("friendCommCode"));
			System.out.println("삭제할 친구평 : " + friendCommCode);
			System.out.println("작성자 : " +guestCode + "게시글: " + friendCommCode);

			FriendCommDAO.delFriendComm(friendCommCode);
			response.sendRedirect("mainLoadController?state=good&userCode="+guestCode+"&visitHost="+visitHost);
			return;
		} 
		else if ("write".equals(type)) {
			//친구평 작성
			System.out.println("친구평 작성 실행");
			String content = request.getParameter("content");
			FriendCommVO fcvo = new FriendCommVO();
			fcvo.setUserCode(visitHost);
			fcvo.setGuestCode(guestCode);
			fcvo.setContent(content);
			
			FriendCommDAO.wrtFriendComm(fcvo);
			//request.getRequestDispatcher("/login_join/home.jsp?state=good").forward(request, response);
			response.sendRedirect("mainLoadController?state=good&userCode="+guestCode+"&visitHost="+visitHost);
			return;
		}
		
	}//doGet
	
	private String makeJason(List<FriendCommVO> friendCommList) {
		StringBuilder result = new StringBuilder();
			result.append("{ \"list\" : [ ");
			for (FriendCommVO fcvo : friendCommList) {
				result.append("{");
				result.append("\"friendCommCode\": " + fcvo.getFriendCommCode() +",");
				result.append("\"userCode\": \"" +  fcvo.getUserCode() + "\",");
				result.append("\"guestCode\": \"" + fcvo.getGuestCode() +"\",");
				result.append("\"content\": \"" + fcvo.getContent() + "\",");
				result.append("\"regdate\": \"" + fcvo.getRegdate()  +"\",");
				result.append("\"guestName\": \"" + fcvo.getGuestName()  +"\",");
				result.append("\"friendName\": \"" + fcvo.getFriendName()  +"\"");
				result.append("},");
			}
				result.deleteCharAt(result.length() - 1);
				result.append("]}");	

		System.out.println("[친구평]list : >" + result.toString() +"<");
		return result.toString();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
												throws ServletException, IOException {
		System.out.println(">> P_get_controller doPost 실행");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
