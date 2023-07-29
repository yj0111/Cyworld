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

public class FriendRejectCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int requestCode = Integer.parseInt(request.getParameter("requestCode"));
		
		int result = FriendDAO.rejectDAO(requestCode);
		
		if (result <=0) {
			System.err.println("친구요청 삭제도중 에러 발생:: 관리자 확인 요망");
			response.sendRedirect("/CYWORLD/errorPage.jsp");
			return null;
		}
		request.setAttribute("type", "pushFriendReject");
		request.getRequestDispatcher("push").forward(request, response);
		
		return null;
	}

}
