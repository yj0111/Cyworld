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

public class FriendFindCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int userCode = Integer.parseInt(request.getParameter("userCode"));
		String name = request.getParameter("name");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userCode", userCode);
		map.put("name", name);
		
		
		// 이름으로 검색한 친구를 리스트로 받아오는 부분
		List<FriendVO> list = new ArrayList<>();
		
		list = FriendDAO.getFriendsByNameDAO(map);
		
		
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<friends>");
		
		for (FriendVO fvo : list) {
			
			result.append("<friend>");
			result.append("<name>" + fvo.getName() + "</name>");
			result.append("<friendName>" + fvo.getFriendName() + "</friendName>");
			result.append("<regdate>" + fvo.getRegdate() + "</regdate>");
			result.append("<userCode2>" + fvo.getUserCode2() + "</userCode2>");				
			result.append("<friendCode>" + fvo.getFriendCode() + "</friendCode>");				
			result.append("</friend>");
		}
		result.append("</friends> ");
		
		PrintWriter out = response.getWriter();
		
		out.print(result);
		
		return null;
	}

}
