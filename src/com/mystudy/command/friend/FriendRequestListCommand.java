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
import com.mystudy.vo.UserVO;

public class FriendRequestListCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int userCode = Integer.parseInt(request.getParameter("userCode"));
		
		// 접속한 유저에게 도착한 친구신청을 리스트로 불러오는 부분
		List<FriendRequestVO> list = new ArrayList<>();
		
		list = FriendDAO.getRequestList(userCode);
		System.out.println("FriendRequestListCommand에서 list : " + list);
		
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<requests>");
		
		for (FriendRequestVO frvo : list) {
			
			result.append("<request>");
			result.append("<requestCode>" + frvo.getRequestCode() + "</requestCode>");
			result.append("<requesterCode>" + frvo.getRequesterCode() + " </requesterCode>");
			result.append("<id>" + frvo.getId() + " </id>");
			result.append("<name>" + frvo.getName() + " </name>");
			result.append("<message>" + frvo.getMessage() + "</message>");
			result.append("<checked>" + frvo.getChecked() + "</checked>");
			result.append("</request>");
		}
		result.append("</requests> ");
		
		System.out.println(list);
		
		// 응답하기
		PrintWriter out = response.getWriter();
		
		out.print(result);
		
		return null;
	}

}
