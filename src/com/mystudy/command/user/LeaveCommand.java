package com.mystudy.command.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.UserDAO;


public class LeaveCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		
			int result = UserDAO.leave(userCode);
			if(result>0) {
				System.out.println("탈퇴 성공!!");
				return "leave_ok.jsp";
			}else {
				System.out.println("탈퇴 실패!!");
				return "login.jsp";
			}
		}
}
	


