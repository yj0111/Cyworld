<%@page import="com.mystudy.dao.BoardDAO"%>
<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="com.mystudy.vo.BoardCommentVO"%>
<%@page import="com.mystudy.dao.BoardCommentDAO"%>
<%@page import="com.mystudy.vo.BoardPaging"%>
<%@page import="com.mystudy.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<% 

	int userCode = (int)session.getAttribute("userCode");
	int visitHost = (int)session.getAttribute("visitHost");
	System.out.println("visitHost : " + visitHost);	
	System.out.println("userCode : " + userCode);	
	
	System.out.println("게시판 읽기 페이지 !");

	UserVO uvo = (UserVO)session.getAttribute("userVO");
	System.out.println("userVO : " + uvo);	
	String name = uvo.getName();
	
	System.out.println("userCode : " + userCode);	
	System.out.println("name : " + name);	


	//프로필에서 최근 등록한 프로필게시글 찾아오기
	ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
	session.setAttribute("pvo", pvo);
	
	//Image File 테이블에서 프로필 사진 가져오기(경로포함)
	String pfImgSrc = ImageFileDAO.getImg(visitHost);
	session.setAttribute("pfImgSrc", pfImgSrc);
	System.out.println("[home] 프로필이미지 >> : " + pfImgSrc);
	
	//파라미터 값 추출(확인)
	int postCode = Integer.parseInt(request.getParameter("postCode"));
	String cPage = request.getParameter("cPage");
	
	BoardVO bvo = BoardDAO.selectOne(postCode);
	System.out.println("> bvo : " + bvo);
	
	List<BoardCommentVO> list = BoardCommentDAO.commentList(postCode);
	System.out.println("> 댓글 list : " + list);
	
	//조회수 증가
	System.out.println("> 조회수 : " + bvo.getHit());
	BoardDAO.updateHit(postCode);
	
	//EL, JSTL 사용을 위한 scope 상에 속성 등록처리
	session.setAttribute("bvo", bvo); //게시글 데이터
	session.setAttribute("cPage", cPage);
	
	pageContext.setAttribute("c_list", list);
%>	

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
  	 <title>${visitHostVO.name} 님의 미니홈피</title>

<script>
	 	function delete_go(){       
	 		var frm =document.frm;   
			frm.action="BoardController?type=delete&postCode=${bvo.postCode }"
			frm.submit();
	        alert("게시글 삭제 완료~~~~~~~~~");
	     }
	 	function list_go(){
	 		location.href = "board.jsp?userCode=${userVO.userCode }"
	 	}
	 	function modify_go(){
	 		location.href = "board_modify.jsp?postCode=${bvo.postCode }"
	 	}
	 	
	 	function check_comment(){
	 		if(commentfrm.content.value==""){
	 			alert("댓글 내용을 입력해주세요.");
	 			return false;
	 		}else{
	 		commentfrm.action="BoardController"
 			commentfrm.submit();
	 		alert("댓글작성 완료!");
	 		}
	 	}
	 	
	 	function delete_comment(comCode){
	 		alert(comCode);
	 		location.href = "BoardController?type=deleteCom&postCode=${bvo.postCode}&comCode="+comCode;
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
	label[for="label_title"] {
        position: relative;
        left: 1px;
        color: black;
        font-size: 15px;
      }
    .comment{
     	color: black;
     	font-size: 12px;
     }
	.modify , .delete , .list{
	border : none;
	background-color: white;
	}
	.comname{
	font-weight: 1000; 
	}
	.deletebutton{
	float: right; 
	border : none;
	background-color: white;
	}
	
</style>    
    <link rel="stylesheet" href="./static/font.css" />
    <link rel="stylesheet" href="./static/layout.css" />
    <link rel="stylesheet" href="./static/diary.css" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css" />
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
		              		<span class="title">${HSvo.homeName }</span> &emsp;&emsp;&emsp; 
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
					<div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } </div>
	
			 	

                  </div>
              <div class="home_contents" style="width: 540px; height:550px; overflow-x: auto;">
                  <div id="board">
                  	<form name = "frm" method="post" style="padding:10px 5px;">
					<table class="align-left" style="width: 490px; word-break: break-all;">
					<tbody>
						<tr>
							<th class= "title1">제목</th>
							<td>${bvo.title }</td>
						</tr>
						<tr>
							<th class ="regdate">작성일</th>
							<td>${bvo.regdate }</td>
						</tr>
						<tr>
							<th class = "content">내용</th>
							<td>${bvo.content }</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>				
						<c:if test="${userCode == visitHost}"> 	
							<td colspan="3" style="text-align: right">
								<input type="button" value="수정  /" class="modify" onclick="modify_go()">
								<input type="button" value="삭제  /" class="delete" onclick="delete_go()">
								<input type="button" value="목록" class="list" onclick="list_go()" 
								style="float: right;">
							</td>						
						</c:if>	
						</tr>
					</tfoot>
					</table>
					</form>
					</div>
					<div>
						<hr>
				<%-- 댓글 작성 영역 --%>
					<form name = "commentfrm" method="get" class="comment" style="padding: 10px;">
						<label for="label_title"></label>
						<br>
						<textarea name="content" rows="4" cols="62" placeholder="댓글을 입력해주세요."></textarea>
						<input type="submit" value="등록" onclick="check_comment(this.form)">
					  	<input type="hidden" name="name" value="${userVO.name }">
					  	<input type="hidden" name="type" value="insertCom">
					  	<input type="hidden" name="userCode" value="${userCode }">
					  	<input type="hidden" name="postCode" value="${bvo.postCode}">
					</form>
					<hr>
				</div>
				<%-- 댓글 표시 영역 --%>
				<div class="commentList" style="padding: 10px;">
				<c:forEach var="vo" items="${c_list}">
				<div class="comment">
					<div style="display: flex; justify-content: space-between;"> 
					<div class="comname" style="inline">${vo.name } </div>
					<div style="inline"> ${vo.regdate }</div>
					</div>
						<br>
						${vo.content }
						<c:if test="${userCode == visitHost}"> 
						<input type="submit" value="삭제"  onclick="delete_comment(${vo.comCode })" class ="deletebutton">
						</c:if>	
						<hr>
				</div>
				</c:forEach>
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