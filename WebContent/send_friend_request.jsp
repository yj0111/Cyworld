<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int opponentCode = Integer.parseInt(request.getParameter("opponentCode"));
	//int userCode = (int)session.getAttribute("userCdoe");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	pageContext.setAttribute("opponentCode", opponentCode);
	pageContext.setAttribute("name", name);
	pageContext.setAttribute("id", id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	.history_back {
		border: 1px solid gray;
		background-color: white;
		border-radius: 20px;
		width: 250px;
		height: 450px;
		margin: 0;
		padding: 20px;
		margin: auto;
	}
	#history_contentBox {
		border: 1px dotted black;
		width: 200px;
	}
	
	#history_img {
		 width: 180px;
		 height: 180px;
	}
	.disable {
		color: WhiteSmoke;;
	}
	.pageBtn {
		text-decoration: none;
	}
	
	
	
	#pageBlock a{
		text-decoration: none;
	}
</style>

<script type="text/javascript">
	
	 function popupSubmit(frm) {
		
		opener.location.href = "login_join/friend?myCode=" + ${userCode } + "&opponentCode=" 
				+ ${opponentCode }+ "&type=request&message=" + frm.message.value ;
		self.close(); 
		opener.focus();
		alert("친구신청이 완료되었습니다!");
	}
		

</script>

		
</head>

<body>
	<h1 style="margin: auto;">친구요청</h1>
	<br>
	<div class="history_back">
		<div > 
			<img src="${pfImgSrc }" alt="지금프사" class ="currentProfile"> 
		</div> 
		<div>친구 : ${name } (${id }) <br><br>
		</div>
	
	<div class = "profile">
		<form method="post" enctype="multipart/form-data" > 
			<textarea rows="4" cols="29" name ="message" style="padding: 10px;">일촌 맺어요~</textarea>
			<input type="hidden" name="opponentCode" value="${opponentCode }">
			<input type="hidden" name="type" value="request"> <br>
			<input type="button" value="요청보내기" onclick="popupSubmit(this.form)" style="float: right;">
		</form>
	</div>
	</div>
	<br>
	
</body>
</html>