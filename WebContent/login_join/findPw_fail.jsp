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
<script>
   function join_go() {
        alert("회원가입 페이지로 이동합니다."); 
    	location.href="join.jsp" ; 
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
		.cyworldfindpw_fail{
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
<div id="find" class="cyworldfindpw_fail">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	<div style="text-align : center;">
	<p><img src="cy_1.png" alt="싸이월드 미니미" width="200px" height="150px" ></p>
	</div>
	
	<form method="post">
	<table>
		<tbody>
			<tr>
				<h2>가입하신 아이디 정보가 없습니다.</h2>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
    				<input type="button" class="button" style="width:260px;height:40px; font-size:1em;" value="회원가입하기" onclick="join_go()" >
				</td>
			</tr>
			
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>