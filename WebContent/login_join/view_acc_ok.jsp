<%@page import="com.mystudy.dao.UserDAO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
	System.out.println(">> 내 정보보기 결과페이지");
%> 
<!doctype html>
<html>

<head>
	<meta charset ="utf-8">
	<title>내 정보 보기 페이지 </title>
	
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
   function modify_go() {
	   alert("회원 수정 클릭");
	   var frm =document.frm;    
   		console.log(frm);
       if(frm.password.value==""
				|| frm.phone.value=="" ){
            if(frm.password.value==""){
                 alert("변경하실 비밀번호를 입력해주세요.");
            }else if(frm.phone.value==""){
                 alert("변경하실 전화번호를 입력해주세요.");
            }
            return false;
       } else{
       	frm.submit();
          alert("회원정보 수정 완료 !");
       }
   }
   function leave_go() {
        alert("탈퇴하시겠습니까?");
        location.href="UserController?type=leave&userCode=${uvo.userCode }";
        alert("탈퇴 처리 완료 ! 감사합니다.");      
   }
   function login_go(){
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
    	
    	#account th {
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
    	#account td{
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%; 
            border:none;   
    	}
        .input {
            border: none;
        }
      .html{
	  position: relative; 
		}  
	.cyworldaccount_view{
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
<div id="account" class="cyworldaccount_view">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	
	<h2>나의 정보</h2>
	<hr>
	
	<form name="frm" action="UserController?type=modify&userCode=${uvo.userCode }" method="post">
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
				<td><input type="text" name="password" class="input" style="text-align: center;"placeholder="${uvo.password }"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone" class="input" style="text-align: center;" placeholder="${uvo.phone }"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${uvo.birth }</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
				    <input type ="button" class="button" style="width:260px;height:40px; font-size:1em;" onclick="modify_go()" value="수정하기">
				    <input type ="hidden" value="${uvo.name }">
				 </td>
			</tr>
			<tr>	 
				 <td colspan="2">   
				    <input type ="button" class="button" style="width:260px;height:40px; font-size:1em;"  onclick="leave_go(${uvo.userCode })" value="탈퇴하기">
				</td>
			</tr>
			
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>