<%@page import="com.mystudy.dao.UserDAO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
	<meta charset ="utf-8">
	<title>비밀번호 검색 결과</title>
	
 <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<% 
	String phone = request.getParameter("phone");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	UserVO uvo = UserDAO.findId(phone);
	pageContext.setAttribute("uvo", uvo);
	System.out.println("비밀번호 okok:" + uvo.getPassword());
%>
<script>
   function login_go() {
        alert("로그인 페이지로 이동합니다."); 
    	location.href="login.jsp" ; 
   }
</script>
    <style>
    	#find table{
    		width: 580px;
    		margin-left: auto; 
    		margin-right: auto;
    		border-collapse: collapse;
    		font-size: 14px;
    	}

       #find tr, #find h2 {
    		padding: 4px 10px;
           text-align: center;
        }
    	
    	#find th , #find td{
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
        input {
            height: 30px;
        }
       .html{
	 	 position: relative; 
		}  
		.cyworldfindpw_ok{
		  position: absolute;
		  top: 40%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		}
      .button {
	  display: inline-block;
	  font-size: 24px;
	  cursor: pointer;
	  text-align: center;
	  text-decoration: none;
	  outline: none;
	  color: #fff;
	  background-color: #E57733;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 9px #b4b4b4;
	}
    </style>
</head>
<body>
<div id="find" class="cyworldfindpw_ok">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	<p><img src="cy_2.png" alt="웃는 미니미" width="200px" height="150px" ></p>
	</div>
	<h2>비밀번호 검색 결과</h2>
	<hr>
	
	<form method="post">
	<table>
		<tbody>
			<tr>
				<th>성명</th>
				<td>${uvo.name }</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${uvo.id }</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>${uvo.password }</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
    				<input type="button" class="button" style="width:260px;height:40px; font-size:1em;" value="로그인" onclick="login_go()" >
				</td>
			</tr>	
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>