package com.mystudy.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;


public class FindPwCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone = request.getParameter("phone");
		
		UserVO uvo = UserDAO.findPw(phone);
		System.out.println("uvo" + uvo);
		System.out.println("비밀번호 찾기 :" + uvo.getPassword());
		String password ="";
		
		request.setAttribute("password",password);
		request.setAttribute("uvo",uvo);
		
		return "findPw_ok.jsp";
		
	}


	

	}


