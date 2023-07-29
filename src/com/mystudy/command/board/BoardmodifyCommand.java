package com.mystudy.command.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardDAO;
import com.mystudy.vo.BoardVO;

public class BoardmodifyCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int postCode = Integer.parseInt(request.getParameter("postCode"));
		int hit = Integer.parseInt(request.getParameter("hit"));
		System.out.println("hit : " + hit);
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String regdate = request.getParameter("regdate");
				
		BoardVO boardVO = new BoardVO(0,postCode, userCode, hit, title, content, regdate);
		int result = BoardDAO.update(boardVO);
		if(result>0) {
			return "board.jsp";
		} else {
			System.out.println("수정 실패 ! 게시판으로 이동해");
			return "board.jsp";
		}
	}
	

}

