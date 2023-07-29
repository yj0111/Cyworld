package com.mystudy.command.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.HomeStateDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.HomeStateVO;
import com.mystudy.vo.UserVO;

public class JoinCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String birth = request.getParameter("birth");
		String regdate = request.getParameter("regdate");
		String gender = request.getParameter("gender");
		
	
		UserVO vo = new UserVO(0,id, password ,email, phone, name, birth, gender ,regdate, 0);
		UserDAO.joinUser(vo);
		request.setAttribute("user", vo);
		
		UserVO uvo = UserDAO.getUserInfoDAO(id);
		System.out.println("uvo :" + uvo);
		System.out.println("uvo.usercode : "+ uvo.getUserCode() );
		HomeStateDAO.createHomeState(uvo.getUserCode());
		return "login.jsp";
	}

}
