package com.mystudy.command.friend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.FriendDAO;
import com.mystudy.vo.UserVO;

public class UserFindCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int userCode = Integer.parseInt(request.getParameter("userCode"));
		
		System.out.println("UserFindCommand 진입");
		
		String subType = request.getParameter("subType");
		
		System.out.println("!!!!!!!!!!!!! subType : " + subType);
		// 검색 조건 받아오는 부분
		String text = request.getParameter("text");
		String gender = request.getParameter("gender");
		
		String birth = request.getParameter("birth").replace('-', '/');
		
		if (birth.length() != 0) {
			birth = birth.substring(2, 10);
		} 
		
		System.out.println(text + birth + gender);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userCode", userCode);
		map.put("text", text);
		map.put("gender", gender);
		map.put("birth", birth);
		
		// 상세조건에 부합하는 유저를 리스트로 가져오는 부분
		List<UserVO> list = new ArrayList<>();
		
		
		if("name".equals(subType)) {
			
			list = FriendDAO.findUserByName(map);
		} else if ("id".equals(subType)) {
			
			list = FriendDAO.findUserById(map);
		}
		
		System.out.println(list);
		
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<users>");
		
		for (UserVO uvo : list) {
			
			result.append("<user>");
			result.append("<userCode>" + uvo.getUserCode() + "</userCode>");
			result.append("<id>" + uvo.getId() + "</id>");
			result.append("<name>" + uvo.getName() + "</name>");
			result.append("<birth>" + uvo.getBirth().substring(0, 10) + "</birth>");
			result.append("</user>");
		}
		result.append("</users> ");
		
		PrintWriter out = response.getWriter();
		
		out.print(result);
		
		return null;
	}

}
