package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.friend.FriendAcceptCommand;
import com.mystudy.command.friend.FriendDeleteCommand;
import com.mystudy.command.friend.FriendFindCommand;
import com.mystudy.command.friend.FriendNameUpdateCommand;
import com.mystudy.command.friend.FriendRejectCommand;
import com.mystudy.command.friend.FriendRequestCommand;
import com.mystudy.command.friend.FriendRequestListCommand;
import com.mystudy.command.friend.UserFindCommand;


@WebServlet("/login_join/friend")
public class FriendController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		System.out.println("Friend_controller  진입");				
		
		String type = request.getParameter("type");
		String path = null;
		System.out.println("프렌드 컨트롤러 type : " + type);
		
		if ("request".equals(type)) {
			
			path = new FriendRequestCommand().exec(request, response);
			response.sendRedirect(path);
			return;
			
		} else if ("requestList".equals(type)) {
			
			new FriendRequestListCommand().exec(request, response);
			return;
			
		} else if ("accept".equals(type)) {
			
			path = new FriendAcceptCommand().exec(request, response);
			
		} else if ("reject".equals(type)) {
			
			path = new FriendRejectCommand().exec(request, response);
			return;
			
		} else if ("deleteFriend".equals(type)) {
			
			path = new FriendDeleteCommand().exec(request, response);
			response.sendRedirect(path);
			return;
			
		} else if ("findUser".equals(type)) {
			
			new UserFindCommand().exec(request, response);
			return;
			
		} else if ("findFriendByName".equals(type)) {
			
			new FriendFindCommand().exec(request, response);
			return;
			
		} else if ("friendNameUpdate".equals(type)) {
			
			path = new FriendNameUpdateCommand().exec(request, response);
		} 
		
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> FrontControllerCommand doPost() 실행-------------");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
