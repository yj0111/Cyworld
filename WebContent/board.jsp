<%@page import="com.mystudy.dao.BoardDAO"%>
<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
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
	
	System.out.println("게시판 페이지 !!!!!!!!!!!!!!!!!");
	UserVO uvo = (UserVO)session.getAttribute("userVO");
	System.out.println("userVO : " + uvo);	
	System.out.println("userCode : " + userCode);	

	//페이징 처리를 위한 객체(Paging) 생성
	BoardPaging p = new BoardPaging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(BoardDAO.getTotalCount(userCode));
	p.setTotalPage();
	System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
	System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
	
	//2. 현재 페이지 구하기
	String cPage = request.getParameter("cPage");
	if (cPage != null) {
		p.setNowPage(Integer.parseInt(cPage));
	}
	System.out.println("> cPage : " + cPage);
	System.out.println("> paging nowPage : " + p.getNowPage());
	
	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
	p.setEnd(p.getNowPage() * p.getNumPerPage());
	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
	
	//3-1.(선택적) 끝번호(end)가 건수보다 많으면 데이터 건수와 동일하게 처리
	if (p.getEnd() > p.getTotalRecord()) {
		p.setEnd(p.getTotalRecord());
	}
	
	System.out.println(">> 시작번호(begin) : " + p.getBegin());
	System.out.println(">> 끝번호(end) : " + p.getEnd());
	
	//------ 블록(block) 계산하기 -----------
	//4. 블록 시작페이지, 끝페이지 구하기(현재페이지 번호 사용)
	int nowPage = p.getNowPage();
	int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
	p.setBeginPage(beginPage);
	p.setEndPage(beginPage + p.getNumPerBlock() - 1);
	
	//끝페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
	// 끝페이지를 전체페이지 수로 변경 처리
	if (p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
	}
	
	System.out.println(">> beginPage : " + p.getBeginPage());
	System.out.println(">> endPage : " + p.getEndPage());
	
	//=====================
	//DB 데이터 가져오기
	//시작번호(begin), 끝번호(end) 사용해서 게시글 조회
	List<BoardVO> list = BoardDAO.getList(visitHost,p.getBegin(), p.getEnd());
	System.out.println(">> 현재페이지 글목록(list) : " + list);
	System.out.println("현재 접속중인 userCode : " + userCode);	
	
	
	
	//프로필에서 최근 등록한 프로필게시글 찾아오기
	ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
	session.setAttribute("pvo", pvo);
	
	//Image File 테이블에서 프로필 사진 가져오기(경로포함)
	String pfImgSrc = ImageFileDAO.getImg(visitHost);
	session.setAttribute("pfImgSrc", pfImgSrc);
	System.out.println("[home] 프로필이미지 >> : " + pfImgSrc);
	
	//===================================
	//EL, JSTL 사용을 위해 scope에 데이터 등록(page 영역)
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("paging", p);
%>	
<!DOCTYPE html>
<html lang="ko">

  <head>
    <meta charset="UTF-8" />
    <title>${visitHostVO.name} 님의 미니홈피</title>
<style>
	#board table {
		width: 500px;
		margin-right: 10px;
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
		padding: 4px 10px;
		text-align: center;
		font-size: 13px;
	}
	
	#board .align-left {text-align: left; }
	.no { width: 15%; }
	.regdate { width: 20%; }
	.hit { width: 15%; }
	
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
		font-weight: bold;
	}
	.paging .disable {
		border: none;
		padding: 3px 7px;
	}
	.paging .now {
		color: black;
		padding: 3px 7px;
	}

	
</style>    
    <link rel="stylesheet" href="./static/font.css" />
    <link rel="stylesheet" href="./static/layout.css" />
    <link rel="stylesheet" href="./static/diary.css" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css" />
    <script src="https://kit.fontawesome.com/8bcf872b48.js" crossorigin="anonymous"></script>
  <script>
	  function log_out() {
	 	 alert("로그아웃 클릭됨");
	 	 location.href="logout.jsp";
	  }
  </script>
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
               
                <div class="profile_2">${pvo.content }</div>
				<div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } 
				</div>
					
               </div>
             
             
              <div class="home_contents">
                  <div id="board"  style="padding:18px 10px;">
					<table style="width:100%;">
						<thead>
							<tr class="boradtitle">
								<th class="no">글번호</th>
								<th class="b_title">제목</th>
								<th class="regdate">날짜</th>
								<th class="hit">조회수</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="4">
									<p><img src="/CYWORLD/imgStorage/public/cy_1.png" alt="우는 미니미" width="150px" height="200px" ></p>
									<h3>현재 등록된 게시글이 없습니다</h3>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="vo" items="${list }">
							<tr>
								<td>${vo.rNum }</td>
								<td class="align-left">
								<a href="BoardController?type=view&postCode=${vo.postCode }">${vo.title }</a>
								</td>
								<td>${vo.regdate.substring(0,16) }</td>
								<td>${vo.hit }</td>
							</tr>
							</c:forEach>
						</c:otherwise>
						
						</c:choose>	
							
						</tbody>
						
						<tfoot>
							<tr>
								<td colspan="3" style="text-align:center;">
									<ol class="paging">
									<%--[이전으로]에 대한 사용여부 처리 --%>
									<c:if test="${paging.beginPage == 1 }">
										<li class="disable"><</li>
									</c:if>	
									<c:if test="${paging.beginPage != 1 }">
										<li>
											<a href="board.jsp?cPage=${paging.beginPage - 1 }">이전으로</a>
										</li>
									</c:if>
									
									<%--블록내에 표시할 페이지 태그작성(시작페이지~끝페이지) --%>
									<c:forEach var="pageNo" begin="${paging.beginPage }" end="${paging.endPage }">
									<c:if test="${pageNo == paging.nowPage }">
										<li class="now">${pageNo }</li>
									</c:if>	
									<c:if test="${pageNo != paging.nowPage }">
										<li><a href="board.jsp?cPage=${pageNo }">${pageNo }</a></li>
									</c:if>	
									</c:forEach>
										
									<%--[다음으로]에 대한 사용여부 처리 --%>
									<c:if test="${paging.endPage < paging.totalPage }">
										<li>
											<a href="list.jsp?cPage=${paging.endPage + 1 }">다음으로</a>
										</li>
									</c:if>
									<c:if test="${paging.endPage >= paging.totalPage }">
										<li class="disable">></li>
									</c:if>
									</ol>
								</td>
							</tr>	
						</tfoot>
					</table>
					<c:if test="${visitHost == userCode }">
					<input type="button" value="글쓰기" onclick='javascript:location.href="board_insert.jsp"'
						style="float:right; width: 80px; height: 30px; ">
					</c:if>
				</div>
              </div>
            </div>
          </div>
          <div class="menu_bar" style="position: relative;">
          <c:if test="${userCode != visitHost }">
          		<a href="/CYWORLD/login_join/mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button2" style="padding-left: 5px;"> 마이룸</a>
          	</c:if>
            <a href="/CYWORLD/login_join/mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button1">&nbsp;&nbsp;홈</a>
            <a href="#">&nbsp;&nbsp;게시판</a>
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