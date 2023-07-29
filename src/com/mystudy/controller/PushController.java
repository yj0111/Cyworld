package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.friend.FriendRequestListCommand;
import com.mystudy.command.push.PushFriendAcceptCommand;
import com.mystudy.command.push.PushFriendRejectCommand;
import com.mystudy.command.push.PushListCommand;


@WebServlet("/login_join/push")
public class PushController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		System.out.println("Pushcontroller  진입");
		
		// 컨트롤러 혹은 커맨드에서 호출되는 경우의 type
		String type = (String) request.getAttribute("type");
		
		// 클라이언트 화면에서 호출되는 경우의 type
		String type1 = request.getParameter("type");
		System.out.println("다른 커맨드에서 호출된 경우의 type : " + type);
		System.out.println("클라이언트에서 호출된 경우의 type1 : " + type);
		String path = null;
		
		if ("pushFriendReject".equals(type)) {
			
			path = new PushFriendRejectCommand().exec(request, response);
			
		} else if ("pushList".equals(type1)) {
			
			new PushListCommand().exec(request, response);
			return;
		}  else if ("pushFriendAccept".equals(type)) {
			
			path = new PushFriendAcceptCommand().exec(request, response);
			return;
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
