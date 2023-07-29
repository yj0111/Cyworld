package com.mystudy.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;



public class ProfileCommand implements Command{
	public static void main(String[] args) {
		
	}

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		
		UserVO vo = UserDAO.getUserInfoDAO(id);
		

		if (vo != null && vo.getPassword().equals(password)) {
			
			System.out.println("널아님");
			return "login_ok.jsp?userCode=" + vo.getUserCode();
			
		} else return "login.jsp?state=no";
	}
	
}
