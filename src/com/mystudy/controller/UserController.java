package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.command.user.FindIdCommand;
import com.mystudy.command.user.FindPwCommand;
import com.mystudy.command.user.JoinCommand;
import com.mystudy.command.user.LeaveCommand;
import com.mystudy.command.user.UsermodifyCommand;
import com.mystudy.command.user.ViewAccCommand;

@WebServlet("/login_join/UserController")
public class UserController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		System.out.println("UserController 호출");
		Command command = null;
		if ("join".equals(type)) {
			command = new JoinCommand();
		} else if ("findId".equals(type)) {
			command = new FindIdCommand();
		} else if ("findPw".equals(type)) {
			command = new FindPwCommand();
		} else if ("viewAcc".equals(type)) {
			command = new ViewAccCommand();
		} else if ("modify".equals(type)) {
			command = new UsermodifyCommand();
		} else if("leave".equals(type)) {
			command = new LeaveCommand();
		}
		
		String path = command.exec(request, response);
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
