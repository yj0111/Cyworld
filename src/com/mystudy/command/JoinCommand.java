package com.mystudy.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.dao.UserDAO;
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
		String gender = request.getParameter("gender");
		String regdate = request.getParameter("regdate");
		
		UserVO vo = new UserVO(0,id, password ,email, phone, name, birth, gender, regdate, 0);
		UserDAO.joinUser(vo);
		request.setAttribute("user", vo);
		
		return "login.jsp";
	}

}
