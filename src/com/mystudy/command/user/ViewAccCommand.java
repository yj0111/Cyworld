package com.mystudy.command.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;


public class ViewAccCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int userCode = Integer.parseInt(request.getParameter("userCode"));
		System.out.println("ACCCOMMAND 유저코드:"+userCode);
		UserVO uvo = UserDAO.getUserInfoByCodeDAO(userCode);
		System.out.println("uvo" + uvo);
		if(uvo == null) {
			return "view_acc_fail.jsp";
		}else {
			System.out.println("아이디찾기 :" + uvo.getId());
			String id ="";
			request.setAttribute("id",id);
			request.setAttribute("uvo",uvo);
			return "view_acc_ok.jsp";
		}
	}


	

	}


