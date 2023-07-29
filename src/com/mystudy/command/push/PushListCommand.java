package com.mystudy.command.push;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.PushDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.FriendVO;
import com.mystudy.vo.PushVO;
import com.mystudy.vo.UserVO;

public class PushListCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("PushListCommand 진입");
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		
		List<PushVO> pushList = PushDAO.getPushListDAO(userCode);
		
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<pushs>");
		
		UserVO userVO = null;
		
		for (PushVO pushVO : pushList) {
			
			userVO = UserDAO.getUserInfoByCodeDAO(pushVO.getUserCode2());
			result.append("<push>");
			result.append("<pushCode>" + pushVO.getPushCode() + "</pushCode>");
			result.append("<userCode1>" + pushVO.getUserCode1() + "</userCode1>");
			result.append("<userCode2>" + pushVO.getUserCode2() + "</userCode2>");
			result.append("<opponentName>" + userVO.getName() + "</opponentName>");
			result.append("<opponentId>" + userVO.getId() + "</opponentId>");
			result.append("<guestCode>" + pushVO.getGuestCode() + "</guestCode>");				
			result.append("<comCode>" + pushVO.getComCode() + "</comCode>");				
			result.append("<check>" + pushVO.getCheck() + "</check>");				
			result.append("<content>" + pushVO.getContent() + "</content>");				
			result.append("<regdate>" + pushVO.getRegdate() + "</regdate>");				
			result.append("</push>");
		}
		result.append("</pushs> ");
		
		PrintWriter out = response.getWriter();
		
		out.print(result);
		
		return null;
	}

}
