package com.mystudy.command.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardCommentDAO;
import com.mystudy.vo.BoardCommentVO;

public class insertComCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		int postCode = Integer.parseInt(request.getParameter("postCode"));
		String content = request.getParameter("content");
		String name = request.getParameter("name");
		
		BoardCommentVO boardcommentVO = new BoardCommentVO(0, postCode, userCode, name, content, null);
		int result = BoardCommentDAO.BoardCommentInsert(boardcommentVO);
		if(result>0) {
			return "board_view.jsp?postCode="+postCode;
		} else {
			System.out.println("입력 실패 !");
			return "board_view.jsp?postCode="+postCode;
		}
	}
	

}

