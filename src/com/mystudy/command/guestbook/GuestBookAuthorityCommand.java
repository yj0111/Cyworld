package com.mystudy.command.guestbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.GuestBookDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;

public class GuestBookAuthorityCommand implements Command{

	public static void main(String[] args) {

	}

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(">> GuestAuthorityCommand 들어옴");
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int visitHost = Integer.parseInt(request.getParameter("visitHost"));
		String authority = request.getParameter("authority");
		
		int result = GuestBookDAO.updateAuthority(visitHost, authority);
		
		String path = null;
		
		if (result >= 1) {
			
			UserVO vo = UserDAO.getUserInfoByCodeDAO(visitHost);
			request.setAttribute("visitHostVO", vo);
			path = "guestBook?userCode="+userCode+"&visitHost="+visitHost+"&type=getList&cPage=1";
		}
		return path;
	}
	

}
