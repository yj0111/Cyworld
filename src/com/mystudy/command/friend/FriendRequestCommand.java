package com.mystudy.command.friend;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.FriendDAO;
import com.mystudy.vo.FriendRequestVO;
import com.mystudy.vo.FriendVO;
import com.mystudy.vo.UserVO;

public class FriendRequestCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int myCode = Integer.parseInt(request.getParameter("myCode"));
		int opponentCode = Integer.parseInt(request.getParameter("opponentCode"));
		String message = request.getParameter("message");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("myCode", myCode);
		map.put("opponentCode", opponentCode);
		map.put("message", message);
		
		
		int result = FriendDAO.insertRequestDAO(map);
		
		System.out.println("Friend_controller  끝");
		String path = "mainLoadController?userCode="+myCode+"&visitHost="+myCode;
		
		return path;
	}

}
