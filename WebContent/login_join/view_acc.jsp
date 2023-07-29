<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%--
 <jsp:useBean id="userVo" class="user.UserVO"/>
 <jsp:setProperty property="*" name="userVo"/>
 --%>
 <%
	System.out.println(">> 내 정보 찾기 페이지");
	UserVO uvo = (UserVO)session.getAttribute("userVO");
	System.out.println("UserVO : " + uvo);
%>
<!doctype html>
<html>
<head>
	<meta charset ="utf-8">
	<title>내정보 페이지</title>
	
 <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script>        
	function check_form(){
		var frm =document.frm;    
		console.log(frm);
	    if(frm.name.value=="" || frm.phone.value=="" || frm.phone.value != ${userVO.phone} ){
	         if(frm.name.value==""){
	              alert("이름을 입력해주세요.");
	         }else if(frm.phone.value==""){
	              alert("전화번호를 입력해주세요.");
	         }else if(frm.phone.value != ${userVO.phone}){
	        	 alert("가입하신 전화번호 정보가 다릅니다");
	         }
	         return false;
	    } else{
	    	frm.submit();
	    }
	}
     
   function login_go(){
	   location.href="login.jsp"
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
    	
    	#account th{
    	   text-align: right;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
    	#account td{
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
       .html{
	  position: relative; 
		}  
		.cyworldaccount{
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
	
	.button:hover {background-color: #E56D29}
	
	.button:active {
	  background-color: #DB631F;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
	
	.input {
	border:none;
	}
</style>
</head>

<body>
<div id="account" class="cyworldaccount">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	
	<form name="frm" action="UserController?type=viewAcc&userCode=${userCode }" method="post">
	<table>
		<tbody>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" class="input" placeholder="성명"></td>
			</tr>
			<tr>
				<th>전화번호(-제외)</th>
				<td><input type="text" name="phone" class="input" placeholder="전화번호"></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
				    <input type ="button" class="button" style="width:260px;height:40px; font-size:1em;" onclick="check_form()" value="회원 정보 조회">
				</td>
    		</tr>
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>