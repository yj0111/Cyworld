<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<style>
	body {
		background-color: #a3a3a3;
		background-image: url("./static/images/pattern.png");
		background-size: 100px;
	
		position: fixed;
		left: 0;
		top: 0;
		right: 0;
		bottom: 0;
	}
	h1 {
		text-align: center;
		margin: auto;
	}
	.profile {
		background-color:  #FFFFFF;
		border: 0.5px solid grey;
		border-radius: 10%;
		width: 240px;
		
		text-align: center;
		margin: auto;
	}
	.currentProfile, #thumb {
		width: 180px;
	    height: 180px;
	  
	    margin: 20px;
	    border-radius: 5px;
	}
	
	
	
</style>

<%
	int userCode = (int)session.getAttribute("userCode");
	session.getAttribute("pfImgSrc");
	ProfileVO pvo = (ProfileVO)session.getAttribute("pvo");
	
	String result = request.getParameter("result");
	System.out.println("result : " + result);
	if (result == null) {
		result = "null";
	}
	pageContext.setAttribute("result", result);
	
	
	String thumbState = "none";
	pageContext.setAttribute("thumbState", thumbState);
%>

<script>
$(function() {	
	if ('${result }' == 'good'){
		console.log('result : ' + '${result }');
		window.close();
	}  
});

function setThumbnail(event) {
	    var reader = new FileReader();
	    reader.onload = function(event) {
					    var img = document.getElementById("thumb");
					    img.setAttribute("src", event.target.result); //이미지 주소를 변경해줌
					    };
	    reader.readAsDataURL(event.target.files[0]);

	  }
	
	function uploadPf(frm) {
		if (frm.oriFilename.value == '') {
			alert("이미지를 첨부하세요!");
			return;
		}
		frm.action="profile?type=upload";
		frm.submit();
	}
	
	function resetPf(frm) {
		frm.action ="profile?type=reset";
		frm.submit();
	}
	
</script>		
</head>

<body>
	<h1>프로필 수정</h1> <br>
	<div class = "profile">
		<form method="post" enctype="multipart/form-data" > 
			<img id="thumb" src="${pfImgSrc }" alt="지금프사" class ="currentProfile"><br> 
			<input type="file" name="oriFilename" accept="image/*" onchange="setThumbnail(event)" style="position: relative; left: 20px;"><br><br>
			<textarea row="4" cols="22" name ="content" maxlength ='30'>${pvo.content }</textarea><br>
			<input type="hidden" name="userCode" value="${userCode }">
			<input type="button" value="프로필 등록" onclick="uploadPf(this.form)" style="position: relative; left: -50px;bottom: -4px;">
		</form>
		<form method="post">
			<input type="hidden" name="userCode" value="${userCode }">
			<input type="hidden" name="oriFilename" value="basic.jpg">
			<input type="hidden" name="content" value="인사말을 입력해주세요.">
			<input type="button" value="프로필 삭제" onclick="resetPf(this.form)" style="position: relative; left: 50px;bottom: 20px;">
		</form>
	</div>
	<br>
</body>
</html>
