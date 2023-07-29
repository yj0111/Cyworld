package com.mystudy.command.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardDAO;

public class BoarddeleteCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int postCode = Integer.parseInt(request.getParameter("postCode"));
		
			int result = BoardDAO.delete(postCode);
			if(result>0) {
				return "board.jsp";
			}else {
				System.out.println("삭제 실패!! 게시판으로 이동해");
				return "board.jsp";
			}
		}
}
	


