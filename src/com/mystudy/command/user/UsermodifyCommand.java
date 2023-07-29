package com.mystudy.command.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.command.Command;
import com.mystudy.dao.BoardDAO;
import com.mystudy.dao.UserDAO;
import com.mystudy.vo.UserVO;

public class UsermodifyCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int userCode = Integer.parseInt(request.getParameter("userCode"));	
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
	
		UserVO vo = new UserVO(userCode,null, password ,null, phone, null, null, null, null, 0);
		int result = UserDAO.modifyUser(vo);
		
		if(result>0) {
			System.out.println("내정보수정 성공");
			return "modify_acc_ok.jsp";
		} else {
			System.out.println("정보 수정 실패");
			return "login.jsp";
		}
	}

}
