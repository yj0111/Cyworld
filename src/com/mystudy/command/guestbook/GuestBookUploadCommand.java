package com.mystudy.command.guestbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.GuestBookDAO;
import com.mystudy.vo.GuestBookVO;

public class GuestBookUploadCommand implements Command{

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String path = null;
		System.out.println("들어옴");
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int writerCode = Integer.parseInt(request.getParameter("writerCode"));
		String content = request.getParameter("content");
		
		GuestBookVO guestbookVO = new GuestBookVO(content, 0, userCode, writerCode, null);
		
		int result = GuestBookDAO.guestbookInsert(guestbookVO);
		
		if (result > 0) {
			path = "guestBook?userCode=" + writerCode + "&visitHost=" + userCode + "&type=getList";
		} else {
			System.err.println("방명록 데이터 베이스 저장이 정상적으로 이뤄지지 않음");
			path = "home.jsp";
		}
		
		System.out.println(path);
		return path;
	}

}
