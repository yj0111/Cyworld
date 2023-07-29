package com.mystudy.command.guestbook;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.GuestBookDAO;
import com.mystudy.vo.GuestBookVO;
import com.mystudy.vo.GuestBookViewVO;

public class GuestBookDeleteCommand implements Command{

	public static void main(String[] args) {

	}

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(">> GuestBookCommand 들어옴");
		
		String path = null;
		
		int guestCode = Integer.parseInt(request.getParameter("guestCode"));
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int visitHost = Integer.parseInt(request.getParameter("visitHost"));
		
		int result = GuestBookDAO.delete(guestCode);
		
		if(result > 0) {
			path = "guestBook?userCode=" + userCode + "&visitHost=" + visitHost + "&type=getList";
		} else {
			System.err.println("알수없는 오류로 삭제할 수 없습니다");
			path = "/CYWORLD/home.jsp?userCode=" + userCode + "&visitHost=" + visitHost + "&type=getList";
		}
		
		return path;
	}
	

}
