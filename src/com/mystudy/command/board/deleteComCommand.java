package com.mystudy.command.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardCommentDAO;

public class deleteComCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int comCode = Integer.parseInt(request.getParameter("comCode"));
		System.out.println("댓글 comCode" + comCode);
		int postCode = Integer.parseInt(request.getParameter("postCode"));
		int result = BoardCommentDAO.BoardCommentDelete(comCode);
		if(result>0) {
			return "board_view.jsp?postCode="+postCode;
		} else {
			System.out.println("삭제 실패 !");
			return "board_view.jsp?postCode="+postCode;
		}
	}
	

}

