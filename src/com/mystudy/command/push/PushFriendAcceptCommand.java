package com.mystudy.command.push;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.PushDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;

public class PushFriendAcceptCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("PushFriendAcceptCommand 진입");
		int userCode1 = Integer.parseInt(request.getParameter("requesterCode"));
		int userCode2 = Integer.parseInt(request.getParameter("userCode"));
		
		int result = PushDAO.insertFriendAccept(userCode1, userCode2);
		
		String path = null;
		
		if (result >= 1) {
			path = "mainLoadController?userCode=" + userCode2 + "&visitHost=" + userCode2;
		} else {
			path = "errorPage.jsp";
		}
		
		response.sendRedirect(path);
		
		return null;
	}

}
