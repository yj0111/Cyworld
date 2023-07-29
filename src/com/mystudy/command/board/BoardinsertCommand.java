package com.mystudy.command.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardDAO;
import com.mystudy.vo.BoardVO;

public class BoardinsertCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		BoardVO boardVO = new BoardVO(0,0, userCode, 0, title, content, null);
		int result = BoardDAO.BoardInsert(boardVO);
		if(result>0) {
			return "board.jsp";
		} else {
			System.out.println("입력 실패 ! 게시판으로 이동해");
			return "board.jsp";
		}
	}
	

}

