<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

    <% 
    	UserVO requestVO = (UserVO) request.getAttribute("userVO"); 
    	List<ProfileVO> list = (List<ProfileVO>) request.getAttribute("profileList");
    	UserVO userVO = (UserVO) session.getAttribute("userVO");
    	
    	if(userVO == null) {
    		
    		session.setAttribute("userVO", requestVO);
    		
    	} else if (requestVO.getUserCode() != userVO.getUserCode()){
    		
    		session.setAttribute("otherVO", requestVO);
    	}
    	
    	session.setAttribute("profileList", list);
    	System.out.println("프로젝트 절대경로 : " + request.getContextPath());
    	
    	
    	response.sendRedirect("/CYWORLD/home.jsp");
    %>