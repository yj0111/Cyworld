<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@page import="com.mystudy.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

 
<%

	int userCode = (int)session.getAttribute("userCode");
	int visitHost = (int)session.getAttribute("visitHost");
	System.out.println(">> 게시판 글 수정페이지!");
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
<html>
  <head>
    <meta charset="UTF-8" />
   <title>${visitHostVO.name} 님의 미니홈피</title>
    <link rel="stylesheet" href="./static/font.css" />
    <link rel="stylesheet" href="./static/layout.css" />
    <link rel="stylesheet" href="./static/diary.css" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css" />
 <script>
 	function modify_ok_go(){
 		var frm =document.frm;    
 		console.log(frm);
     if(frm.title.value=="" || frm.content.value=="" ){
          if(frm.title.value==""){
               alert("수정할 제목를 입력해주세요.");
          }else if(frm.content.value==""){
               alert("수정할 내용을 입력해주세요.");
          }
          return false;
     } else{
     	frm.action="BoardController?type=modify&userCode=${userVO.userCode }&postCode=${bvo.postCode }"
     	frm.submit();
        alert("게시글 수정 완료!");
     }
}
 	function list_go(){
 		location.href = "board.jsp?userCode=${userVO.userCode }"
 	}
 	
 	function log_out() {
	 	 location.href="logout.jsp";
	}
 	
 </script>
<style>
	#board .align-left {text-align: left; }
	#board table {
		width: 500px;
		margin-left: 10px;
		border-collapse: collapse;
		font-size: 12px;
		color: black;
	}
	#board table caption {
		font-size: 2em;
		font-weight: bold;
		margin-bottom: 10px;
	}
	#board th, #board td {
		padding: 10px;
		text-align: left;
		font-size: 13px;
	}
	
	#board .align-left {text-align: left; }
	.title1 { width: 15%; }
	.regdate { width: 20%; }
	.content { width: 15%; }
	
	/*** 페이지 표시 영역 스타일(시작) ****/
	.paging { list-style: none; }
	.paging li { 
		float: left;
		margin-right: 8px;
	}
	.paging li a {
		text-decoration: none;
		display: block;
		padding: 3px 7px;
		border: 1px solid #00B3DC;
		font-weight: bold;
	}
	.paging .disable {
		border: 1px solid silver;
		padding: 3px 7px;
		color: silver;
	}
	.paging .now {
		border: 1px solid #ff4aa5;
		padding: 3px 7px;
		background-color: #ff4aa5;
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
              <div class="profile">
                
                <div class="profile_1">
                  <img class="profile_image" src="${pfImgSrc }"/> 
                </div>
               
                <div class="profile_2">${pvo.content }
                </div>

			 	<div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } 
				</div>

                  </div>
              <div class="home_contents">
                  <div id="board">
                  	<form name="frm" method="post">
					<table class="align-left"  style="width: 530px;">
					<tbody>
						<tr>
							<th class= "title1">제목</th>
							<td><input type="text" name = "title" value="${bvo.title }"></td>
						</tr>
						<tr>
							<th class ="regdate">작성일</th>
							<td>${bvo.regdate }</td>
						</tr>
						<tr>
							<th class = "content">내용</th>
							<td><textarea name="content" rows="20" cols="60"  style="top:0px;">${bvo.content }</textarea></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<input type="hidden" name="hit" value="${bvo.hit }">
								<input type="hidden" name="regdate" value="${bvo.regdate }">
								<input type="button" value="글 수정하기" onclick="modify_ok_go()">
								<input type="button" value="게시글 목록보기" onclick="list_go()">
							</td>
						</tr>
					</tfoot>
					</table>
					</form>
				</div>
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
  </body>
</html>