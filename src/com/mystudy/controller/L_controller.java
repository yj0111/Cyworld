package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;



@WebServlet("/login_join/loginController")
public class L_controller extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> loginController doGet() 실행-------------");
		String type = request.getParameter("type");

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		UserVO vo = UserDAO.getUserInfoDAO(id);
		
		request.setAttribute("userVO", vo);
		
		if (vo != null && vo.getPassword().equals(password)) {
			
			request.getRequestDispatcher("login_ok.jsp").forward(request, response);
			
		} else response.sendRedirect("login.jsp?state=no");
			
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> loginController doPost() 실행-------------");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
