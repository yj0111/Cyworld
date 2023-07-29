package com.mystudy.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.HomeStateDAO;
import com.mystudy.vo.HomeStateVO;

@WebServlet("/login_join/homeState")
public class HomeStateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[/homeState] doGet() 실행");
		String type = request.getParameter("type");
		
		int userCode =  Integer.parseInt(request.getParameter("userCode"));
		int visitHost = Integer.parseInt(request.getParameter("visitHost"));
		//HomeStateVO homeVO = HomeStateDAO.getHomeState(visitHost);
		
		if ("clickEdit".equals(type)) {
			System.out.println("clickEdit 실행");			
			String homeName = request.getParameter("homeName");
			System.out.println("[homeState]visitHost : " + visitHost);
			System.out.println("[homeState]homeName : " + homeName);
			HomeStateDAO.updateHomeName(visitHost, homeName);
			
			response.sendRedirect("mainLoadController?state=good&userCode="+userCode+"&visitHost="+visitHost);
			return;
		} else if ("today".equals(type)) {
			System.out.println("today 카운트됨 ");
			int today = HomeStateDAO.updateToday(visitHost);
			int total = HomeStateDAO.updateTotal(visitHost, today);
			System.out.println("[homeState] today : " + today );
			System.out.println("[homeState] total : " + total );
			response.sendRedirect("mainLoadController?state=good&userCode="+userCode+"&visitHost="+visitHost);
			
		} 
		
		
	}
	
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
