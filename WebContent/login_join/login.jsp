<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println(">>login 페이지");
	UserVO vo = (UserVO) session.getAttribute("userVO");	
	String state = request.getParameter("state");
	request.setAttribute("state", request.getParameter("state"));
%>
<!doctype html>
<html>
<head>
	<meta charset ="utf-8">
	<title>싸이월드 로그인</title>
	
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    function login_go(frm) {
        frm.action = "loginController"; 
  		frm.submit();
    }
    function findId_go() {
		location.href = "findId.jsp"; 
    }
    function findPw_go() {
		location.href = "findPw.jsp"; 
    }
    function join_go() {
		location.href = "join.jsp"; 
    }

    $().ready(function(){
	    if ("<%=state %>" == "no") {
	    	
	    	$("#wrong_msg").show();
	    	
	    } 
    });
</script>
<style>
	#login table{
		width: 580px;
		margin-left: auto; 
		margin-right: auto;
		border-collapse: collapse;
		font-size: 14px;
	}
	form{
	  margin-top: 20px;
        border: none;
        border-bottom: 1px solid rgba(0,0,0,0.1);
        border-radius: 0;
        padding-left: 0;
        box-shadow: none;
	
	}

   #login tr, #login h2 {
		padding: 4px 10px;
       text-align: center;
    }
    
    
	
	#login th {
	   text-align: right;
        margin: auto;
        padding: 0 0 20px 0px;
        width: 32%;    
	}
	
	#login td{
	   text-align: center;
        margin: auto;
        padding: 0 0 20px 0px;
        width: 32%;    
	}
    
    #wrong_msg{
   	   text-align: center;
		margin-left: auto; 
		margin-right: auto;
		font-size: 20px;
		display: none;
    }
    
    .input {
      display: inline-block;
	  padding: 15px 25px;
	  font-size: 15px;
	  cursor: pointer;
	  text-align: left;
	  text-decoration: none;
	  outline: none;
	  color: black;
	  background-color: white;
	  border: none;
	  border-radius: 15px;
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
	
	.button:hover {background-color: #E56D29}
	
	.button:active {
	  background-color: #DB631F;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
	
	
	.button1{
	background-color:white;
	  border: none;
	}
	.html{
	  position: relative; 
	}  
	.cyworldlogin{
	  position: absolute;
	  top: 40%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	}
	.loginFrm{
	border: none;
	}
</style>
</head>
<body>
<div id="login" class = "cyworldlogin">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	
	<form method="post">
	
	<table class="loginFrm">
		<tbody>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" class="input" placeholder="아이디"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="password" class="input"  placeholder="비밀번호"></td>
			</tr>
			<tr>
				<td colspan="3" id="wrong_msg" style="color:red; font-size:1em; "> 아이디와 비밀번호를 다시 확인해주세요</td>
			</tr>
			
		</tbody>
		<tfoot>
			<tr>
				<td colspan ="3">
				<input type="button" class="button" style="width:260px;height:40px; font-size:1em;" value="로그인" onclick="login_go(this.form)" >
			</tr>
			<tr>
				<td colspan="3">
				<input type="button" class="button1" value="아이디 찾기" onclick="findId_go()">
				<input type="button" class="button1" value="비밀번호 찾기" onclick="findPw_go()">
				<input type="button" class="button1" value="회원가입" onclick="join_go()">
			    <input type="hidden" name="type" value="tryLogin">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
</div>
</body>
</html>