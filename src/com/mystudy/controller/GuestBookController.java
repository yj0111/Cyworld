package com.mystudy.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.command.guestbook.GuestBookAuthorityCommand;
import com.mystudy.command.guestbook.GuestBookCommand;
import com.mystudy.command.guestbook.GuestBookDeleteCommand;
import com.mystudy.command.guestbook.GuestBookUploadCommand;

/**
 * Servlet implementation class G_get_controller
 */
@WebServlet("/guestBook")
public class GuestBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(">> G_get_contoller 페이지 들어옴");
		
		String type = request.getParameter("type");
		
		Command command = null;
		String path = null;
		
		if ("getList".equals(type)) {
			
			command = new GuestBookCommand();
			path = command.exec(request, response);
			
		} else if ("upload".equals(type)) {
			
			command = new GuestBookUploadCommand();
			path = command.exec(request, response);
			
		} else if ("delete".equals(type)) {
			
			command = new GuestBookDeleteCommand();
			path = command.exec(request, response);
			
		} else if ("authority".equals(type)) {
			command = new GuestBookAuthorityCommand();
			path = command.exec(request, response);
		}
		
		request.getRequestDispatcher(path).forward(request, response);;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
