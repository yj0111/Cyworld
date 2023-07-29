<%@page import="com.mystudy.dao.UserDAO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
	System.out.println(">>내정보 수정 후 결과페이지");
%> 
<!doctype html>
<html>

<head>
	<meta charset ="utf-8">
	<title>내 정보 수정 후 페이지 </title>
	
 <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<% 
	int userCode = Integer.parseInt(request.getParameter("userCode"));
	String phone = request.getParameter("phone");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	UserVO uvo = UserDAO.getUserInfoByCodeDAO(userCode);
	pageContext.setAttribute("uvo", uvo);
	System.out.println("내 아이디:" + uvo.getId());
	System.out.println("내 정보:" + uvo);
%>
<script>
   function login_go(){
	   alert("수정하신 정보로 재로그인하세요.");
	   location.href ="login.jsp";
   }
</script>
    <style>
    	#account table{
    		width: 580px;
    		margin-left: auto; 
    		margin-right: auto;
    		border-collapse: collapse;
    		font-size: 14px;
    	}

       #account tr, #account h2 {
    		padding: 4px 10px;
           text-align: center;
        }
    	
    	#account th , #account td{
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
     .html{
	  position: relative; 
		}  
	.cyworldaccount_m_view{
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
<div id="account" class="cyworldaccount_m_view">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	<h2>나의 정보 수정 결과</h2>
	<hr>
	
	<form>
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
			<tr>
				<th>전화번호</th>
				<td>${uvo.phone }</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${uvo.birth }</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan ="2">
				    <input type ="button" class="button" style="width:260px;height:40px; font-size:1em;" onclick="login_go()" value="재로그인 하기">
				</td>
			</tr>
			
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>