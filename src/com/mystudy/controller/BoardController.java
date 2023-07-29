package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.command.board.BoarddeleteCommand;
import com.mystudy.command.board.BoardinsertCommand;
import com.mystudy.command.board.BoardlistCommand;
import com.mystudy.command.board.BoardmodifyCommand;
import com.mystudy.command.board.BoardviewCommand;
import com.mystudy.command.board.deleteComCommand;
import com.mystudy.command.board.insertComCommand;
import com.mystudy.command.user.FindIdCommand;
import com.mystudy.command.user.FindPwCommand;
import com.mystudy.command.user.JoinCommand;
import com.mystudy.command.user.UsermodifyCommand;
import com.mystudy.command.user.ViewAccCommand;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		System.out.println("BoardController 호출");
		Command command = null;
		if ("list".equals(type)) {
			command = new BoardlistCommand();
		} else if ("view".equals(type)) {
			command = new BoardviewCommand();
		}else if ("insert".equals(type)) {
			command = new BoardinsertCommand();
		} else if ("modify".equals(type)) {
			command = new BoardmodifyCommand();
		} else if ("delete".equals(type)) {
			command = new BoarddeleteCommand();
		} else if ("insertCom".equals(type)) {
			command = new insertComCommand();
		} else if ("deleteCom".equals(type)) {
			command = new deleteComCommand();
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
