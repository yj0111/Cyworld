<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 처리</title>
</head>
<body>
<%
	System.out.println("logout.jsp 들어옴");
	session.invalidate();
	response.sendRedirect("login.jsp");
%>
</body>
</html>

