<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    
<% 
//mainLoad컨트롤러에 데이터 전달 외에 하는 일없음 
	
	//visitCode 추가 
	UserVO userVO = (UserVO) request.getAttribute("userVO");

	int userCode = userVO.getUserCode();
	int visitHost = userVO.getUserCode();
	
	//session.setAttribute("userCode", userCode);	
	//session.setAttribute("visitHost", visitHost);
	//session.setAttribute("userVO", userVO);

%>
<html>
<script>


// 메인페이지로 요청할 것 : 유저 VO, 프로필 VO, 친구목록 list
	 location.href="mainLoadController?userCode=<%=userCode %>&visitHost=<%=visitHost %>";
	
</script>
</html>