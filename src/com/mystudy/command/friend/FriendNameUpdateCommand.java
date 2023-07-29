package com.mystudy.command.friend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.FriendDAO;

public class FriendNameUpdateCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int friendCode = Integer.parseInt(request.getParameter("friendCode"));
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int visitHost = Integer.parseInt(request.getParameter("visitHost"));
		String text = request.getParameter("text");
		
		int result = FriendDAO.updateFriendName(friendCode, text); 
		
		String path = "mainLoadController?userCode=" + userCode + "&visitHost" + visitHost;
		
		return path;
	}

}
