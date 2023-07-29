package com.mystudy.command.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;


public class FindIdCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone = request.getParameter("phone");
		
		UserVO uvo = UserDAO.findId(phone);
		System.out.println("uvo" + uvo);
		if(uvo == null) {
			return "findId_fail.jsp";
		}else {
			System.out.println("아이디찾기 :" + uvo.getId());
			String id ="";
			request.setAttribute("id",id);
			request.setAttribute("uvo",uvo);
			return "findId_ok.jsp";
		}
	}


	

	}


