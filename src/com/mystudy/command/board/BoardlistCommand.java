package com.mystudy.command.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardDAO;
import com.mystudy.vo.BoardVO;

public class BoardlistCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(">> 게시판 list command 들어옴");
		int userCode = Integer.parseInt(request.getParameter("userCode"));
		System.out.println("list command에서 userCode : " + userCode);
		List<BoardVO> list = BoardDAO.getList(userCode);
		System.out.println("list dao.getlist 햇음");
		request.setAttribute("bList", list);
		
		return "board.jsp";
	}
	

}

