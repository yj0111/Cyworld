<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO vo = (UserVO) session.getAttribute("userVO");
%>
<!doctype html>
<html>
<head>
	<meta charset ="utf-8">
	<title>회원가입</title>
	
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script>
    function check_form(){
    	var frm =document.frm;    
    	console.log(frm);
        if(frm.id.value=="" || frm.name.value=="" || frm.password.value==""
				|| frm.phone.value=="" || frm.email.value=="" || frm.birth.value=="" ||isNaN(frm.phone.value)==true){
             if(frm.id.value==""){
                  alert("아이디를 입력해주세요.");
             }else if(frm.name.value==""){
                  alert("이름을 입력해주세요.");
             }else if(frm.password.value==""){
                  alert("비밀번호를 입력해주세요.");
             }else if(frm.phone.value==""){
                  alert("전화번호를 입력해주세요.");
             }else if(frm.email.value==""){
                  alert("이메일을 입력해주세요.");
             }else if (frm.birth.value=="") {
                  alert("생년월일을 입력해주세요.");
             }else if(isNaN(frm.phone.value)==true){
            	 alert("전화번호는 숫자만 입력해주세요.");
            	 frm.phone.focus();
             }
             return false;
        } else{
        	frm.submit();
           alert("회원가입이 완료되었습니다!");
        }
   }
    
    function login_go(){
 	   location.href="login.jsp"
    }
</script>    

<style>
	#join table{
		width: 580px;
		margin-left: auto; 
		margin-right: auto;
		font-size: 14px;
	}

   #join tr, #join h2 {
		padding: 4px 10px;
       text-align: center;
    }
	
	#join th {
	   text-align: right;
        margin: auto;
        padding: 0 0 20px 0px;
        width: 32%; 
       border: none;       
	}
	
	#join td{
	   text-align: center;
        margin: auto;
        padding: 0 0 20px 0px;
        width: 32%; 
        border: none;   
	}
    .input {
        height: 30px;
        border: none;   
        
    }
    .html{
	  position: relative; 
	}  
	.cyworldjoin{
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	}
	
	 .radio{width:13px;height:13px; vertical-align:text-top; left: 0;}
	 
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
	
</style>
</head>
<body>
<div id="join" class="cyworldjoin">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	</div>
	
	<form name="frm" action="UserController?type=join" method="post">
	<table id="joinFrm">
		<tbody>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" class="input" placeholder="아이디"></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" class="input" placeholder="성명"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="password" class="input" placeholder="비밀번호"></td>
			</tr>
			<tr>
				<th>전화번호(-제외)</th>
				<td><input type="text" name="phone" class="input"  placeholder="전화번호"></td>
			</tr>
			<tr>
                <th>이메일</th>
                <td><input type="text" name="email" class="input" placeholder="이메일"></td>
            </tr>
			<tr>
                <th>생년월일</th>
                <td><input type="date" class="input" name="birth" style="width:170px;"></td>
            </tr>
            <tr>
            	<th>성별</th>
            	<td>
            	<div style="text-align: left; padding-left: 57px;">
            	<input type="radio" name="gender" class="radio" value="M" checked>남자
            	 <input type="radio" name="gender" class="radio" value="F" >여자
            	</div>
            	 </td>
            </tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan ="2">
				    <input type ="button" class="button" style="width:260px; height:40px; font-size:1em;" value="가입하기" onclick="check_form()">
			</tr>
		</tfoot>
	</table>
	</form>
</div>
    </body>
</html>