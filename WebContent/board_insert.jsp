<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@page import="com.mystudy.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

 
<%
	int userCode = (int)session.getAttribute("userCode");
	int visitHost = (int)session.getAttribute("visitHost");

	System.out.println(">>게시판 글쓰기 페이지!");
	UserVO uvo = (UserVO)session.getAttribute("userVO");
	System.out.println("UserVO : " + uvo);
	System.out.println("글쓰는 userCode:" +uvo.getUserCode());
	
	
	//프로필에서 최근 등록한 프로필게시글 찾아오기
	ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
	session.setAttribute("pvo", pvo);
	
	//Image File 테이블에서 프로필 사진 가져오기(경로포함)
	String pfImgSrc = ImageFileDAO.getImg(visitHost);
	session.setAttribute("pfImgSrc", pfImgSrc);
	System.out.println("[home] 프로필이미지 >> : " + pfImgSrc);
%>      
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>${visitHostVO.name} 님의 미니홈피</title>
    <link rel="stylesheet" href="./static/font.css" />
    <link rel="stylesheet" href="./static/layout.css" />
    <link rel="stylesheet" href="./static/diary.css" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css" />
 <script>
 	function check_board(){
 		var frm =document.frm;    
 		console.log(frm);
     if(frm.title.value=="" || frm.content.value=="" ){
          if(frm.title.value==""){
               alert("제목를 입력해주세요.");
          }else if(frm.content.value==""){
               alert("내용을 입력해주세요.");
          }
          return false;
     } else{
     	frm.action="BoardController?type=insert&userCode=${userVO.userCode }"
     	frm.submit();
        alert("게시글 작성 완료!");
     }
     
 	function log_out() {
	 	 location.href="logout.jsp";
	  }	
}
 </script>
 <style>
 #input_text{

width:30px; height:5px;
border:none;
font-size:11px;
color:#aaa;

      }
label[for="label_title"] {
        position: relative;
        left: 1px;
        color: black;
        font-size: 15px;
      }
 </style>
  </head>
  <body>
    <div class="bookcover">
      <div class="bookdot">
        <div class="page">
          <div class="home">
            <div class="upside">
			 <div class="homeName">
             		<div id="today">
	              <strong>&emsp;&emsp;&emsp;&emsp;&emsp;TODAY <span style="color:coral;">${HSvo.today }</span> | TOTAL ${HSvo.today }</strong> &emsp;&emsp;&emsp; &emsp; 
	              &emsp;&emsp;
	              </div>
	              <div id="title">
		              <form id="homeName" method="post">
		              		<span class="title"><a href="login_join/mainLoadController?userCode=${userCode }&visitHost=${visitHost }" style="text-decoration: none;">
											${HSvo.homeName }</a></span> &emsp;&emsp;&emsp; 
		              </form>
	              </div>
              </div>

            
            </div>
            <div class="home_main">
              <div class="profile" style="height: 550px; width: 200px;">
                
                <div class="profile_1">
                  <img class="profile_image" src="${pfImgSrc }"/> 
                </div>
               
                <div class="profile_2">${pvo.content }
                </div>
                <div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } 
				</div>
              </div>
              <div class="home_contents" style="height: 550px; width: 540px;">
                  <div class="diary" style="top:0px; padding:10px; width: 540px;">
                    <div class="diary_contents" style="border:none; width: 540px;">
               	<form name="frm" method="post">
               		<p><label for="label_title">제목 :  </label><input type = "text" name ="title" class="input_text" style="width:450px; "></p>
                  	<div class="board_text"> <label for="label_title">내용 :  </label><textarea name="content" style="top:0px; width:500px; height: 350px;"></textarea> </div>
	                <div style="margin:0px 10px 20px 10px; text-align: right;">
	                <input type="button" value="저장" onclick="check_board()">
	                </div>
                </form>
              </div>
            </div>
          </div>
          <div class="menu_bar" style="position: relative;">
          	<c:if test="${userCode != visitHost }">
          		<a href="mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button2" style="padding-left: 5px;"> 마이룸</a>
          	</c:if>
          	<a href="/CYWORLD/login_join/mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button1">&nbsp;&nbsp;홈</a>
            <a href="/CYWORLD/BoardController?type=list&userCode=${userVO.userCode }" class="menu_button2">&nbsp;&nbsp;게시판</a>
            <a href="/CYWORLD/guestBook?userCode=${userCode }&visitHost=${visitHost }&type=getList&cPage=1" class="menu_button4">&nbsp;&nbsp;방명록</a>
            <c:if test="${userCode == visitHost }">
            <button onclick="log_out()" style="position: relative; bottom: -300px; left: 8px;"> 로그아웃 </button>
            </c:if>
          </div>
        </div>
      </div>
    </div>
    </div>
    </div>
  </body>
</html>