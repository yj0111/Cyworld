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

public class FriendAcceptCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("FriendAcceptCommand 진입");
		int requestCode = Integer.parseInt(request.getParameter("requestCode"));
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int requesterCode = Integer.parseInt(request.getParameter("requesterCode"));
		
		int result1 = FriendDAO.insertFriend(userCode, requesterCode);
		
		String path = null;
		if (result1 <=0) {
			System.err.println("친구 입력도중(FRIEND에 새로운 친구 입력도중) 에러 발생:: 관리자 확인 요망");
			path = "../errorPage.jap";
			return path;
		}
		
		int result2 = FriendDAO.deleteRequest(requestCode);
		
		System.out.println("FriendAcceptCommand에서 삭제 튜플수 : " + result2);
		
		if (result2 <= 0) {
			System.err.println("친구 요청 삭제도중(FRIEND_REQUEST 행 삭제도중) 에러 발생:: 관리자 확인 요망");
			path = "../errorPage.jsp";
			return path;
		}
		
		request.setAttribute("type", "pushFriendAccept");
		path = "push";
		
		return path;
	}

}
