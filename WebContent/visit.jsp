<%@page import="com.mystudy.vo.UserVO"%>
<%@page import="com.mystudy.dao.GuestBookDAO"%>
<%@page import="com.mystudy.common.Paging"%>
<%@page import="com.mystudy.vo.GuestBookViewVO"%>
<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.vo.ImageFileVO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="com.mystudy.vo.GuestBookVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!Paging p;%>
    
<%
    	int visitHost = (int)session.getAttribute("visitHost");
    	int userCode = (int)session.getAttribute("userCode");
    	
    	// 작성권한 변경시 새로고침하면서 변경된 visitHostVO를 가져오는 부분
    	session.setAttribute("visitHostVO", (UserVO)session.getAttribute("visitHostVO"));

    	System.out.println(">> visit.jsp 화면" + "\n"
							 + "userCode : " + userCode + "\n"
							 + "visitHost : " + visitHost);
    	
    	System.out.println((UserVO)session.getAttribute("visitHostVO"));
    	
    	//프로필에서 최근 등록한 프로필게시글 찾아오기
    	ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
    	session.setAttribute("pvo", pvo);
    	
    	//Image File 테이블에서 프로필 사진 가져오기(경로포함)
    	String pfImgSrc = ImageFileDAO.getImg(visitHost);
    	session.setAttribute("pfImgSrc", pfImgSrc);
    	System.out.println("[home] 프로필이미지 >> : " + pfImgSrc);
    	
    	
    	////////// 방명록 페이지 단독 부분 //////////////////// 
    	
    	// 페이징 처리를 위한 객체(paging) 가져오기
    	Paging paging = (Paging) request.getAttribute("paging");
    	
	    List<GuestBookViewVO> list = (List<GuestBookViewVO>) request.getAttribute("gList");
		pageContext.setAttribute("gList", list);
   		pageContext.setAttribute("p", paging);
   		
   		// userCode와 visitHost간의 친구관계여부 
   		String checkFriend = (String) request.getAttribute("checkFriend");
   		pageContext.setAttribute("checkFriend", checkFriend);
   		System.out.println(checkFriend);
   		
    %>
	
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>${visitHostVO.name} 님의 미니홈피</title>
    <link rel="stylesheet" href="/CYWORLD/static/font.css" />
    <link rel="stylesheet" href="/CYWORLD/static/layout.css" />
    <link rel="stylesheet" href="/CYWORLD/static/visit.css?aa" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css?sdfsf" />
    <script src="https://kit.fontawesome.com/8bcf872b48.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
    	
    	function go_save(frm) {
    		
    		if (${visitHostVO.guestAuthority } == 2) {
    			alert("해당 유저가 방명록 작성을 닫아놨습니다");
    			return;
    		} else if (${visitHostVO.guestAuthority == 1} && '${checkFriend}' == 'no') {
    			alert("일촌만 작성할 수 있습니다");
    			return;
    		}
    		frm.submit();
    	} 
    	
    	function delete_go(guestCode){
    		
    		location.href = "guestBook?type=delete&guestCode=" + guestCode + "&userCode=" + ${userCode } + "&visitHost=" + ${visitHost };
    	}
    	
    	
    	
    	$().ready(function(){
    		
    		console.log('${visitHostVO.guestAuthority }');
    		switch ('${visitHostVO.guestAuthority }') {
			case '0':
				$("input[name='authority'][value='0']").attr("checked", "checked");
				break;
			case '1':
				$("input[name='authority'][value='1']").attr("checked", "checked");
				break;
			case '2':
				$("input[name='authority'][value='2']").attr("checked", "checked");
				break;
			} 
    	});
    	
    	$(document).click(function(){
	 	  	
	  	    for (let test of $(".dropdown_button")) {
	  	    	
	  	        if (event.target == test && test.nextElementSibling.style.display == "none"){
	  	            test.nextElementSibling.style.display = "block";
	  	            test.nextElementSibling.classList.add('clicked');
	  	        } else if (event.target.closest(".container_dropdown")) {
	                  
	              } else {
	  	            test.nextElementSibling.style.display = "none";
	  	            test.nextElementSibling.classList.remove('clicked');
	  	       	}
	  	   	}
	  	    
		});
    	
    	
    </script>
    
    <style>
    	.visit_top_title {
    		display: flex;
    		justify-content: space-between;
    	}
    	
    	.visit_write_section{
    		display: block;
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
				
				<c:if test="${userCode == visitHost }">
				<div style="display: inline-block; position: relative; right: -180px;">
					<button class="dropdown_button button_mouse_event" style="position: relative; left: 500px;">권한설정</button>
					<div class="container_dropdown" style="position: absolute; left: 205px; display: none;">
					<div class="container_dropdown_inner">
						<form action="guestBook" method="get">
							방명록 작성 권한 <input type="submit" value="저장" style="position: relative; left: 180px;">
							<hr>
							<div style="display: flex; justify-content: space-around; padding-left: 20px;">
								<span><input type="radio" name="authority" value="0">모두허용</span>
								<span><input type="radio" name="authority" value="1">일촌만</span>
								<span><input type="radio" name="authority" value="2">작성금지</span>
								<input type="hidden" name="type" value="authority">
								<input type="hidden" name="userCode" value="${userCode }">
								<input type="hidden" name="visitHost" value="${visitHost }">
								<br>
							</div>
						</form>
					</div>
					</div>
				</div>
				</c:if>
				
            </div>
            <div class="home_main">
            
              <div class="profile">
                
                <div class="profile_1">
                  <img class="profile_image" src="${pfImgSrc }"/> 
                </div>
                <div class="profile_2">${pvo.content }</div>
				<div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } </div>
               
              </div>
              <div class="home_contents">
            
                <div class="visit_contents" style ="width: 540px;">
                
                <c:if test="${visitHost != userCode }">
                <div class="visit_title">&emsp;방명록 작성 <i class="fas fa-home"></i></div>
					<div class="visit_container visit_write_section" style="padding-left:10px;">
	                	<form action="guestBook" method="get">
		                  	<div class="visit_text" style="margin:25px 25px 25px 0px;"> <textarea name="content" rows="5px" cols="65px" maxlength="200" placeholder="방명록을 작성하세요" style="padding: 5px; margin-left: 10px;"></textarea> </div>
			                <div style="margin:0px 10px 20px 10px; text-align: right;">
			                	<input type="button" value="방명록저장" onclick="go_save(this.form)">
			                	<input type="hidden" name="userCode" value="${visitHost }">
			                	<input type="hidden" name="writerCode" value="${userCode }">
			                	<input type="hidden" name="type" value="upload">
	                		</div>
	               		</form>
	               		<hr>
	               	</div>
               	</c:if>
                	
          		<c:if test="${gList.size() == 0 }">
          			<c:if test="${userCode.equals(visitHost) }">
	          			<p><img src="cy_1.png" alt="우는 미니미" width="150px" height="180px" style="margin-left: auto; margin-right: auto; display: block;"></p>
          				<div style="text-align: center; height: 100px; line-height: 100px;"> <span style="vertical-align: middle;"> 작성된 방명록이 없습니다.. </span> </div>
        			</c:if>
        			<c:if test="${!userCode.equals(visitHost) }">
          				<div style="text-align: center; height: 100px; line-height: 100px;"> <span style="vertical-align: middle;">첫 방명록을 작성해주세요!</span> </div>
        			</c:if>
          		</c:if>
               	<c:forEach var="gvo" items="${gList }">
					<div class="visit_title">&emsp;No.${gvo.guestCode } <span style="color:mediumblue">${gvo.name }</span> <i class="fas fa-home"></i><span class="visit_date"> ${gvo.regdate }</span> 
					<c:if test="${userCode == gvo.writerCode || userCode == visitHost }">
						<button style="float: right; margin: 5px 5px 0px 0px;" onclick="delete_go(${gvo.guestCode })"> 삭제 </button>
					</c:if>
					</div>
			        <div class="visit_container">
			          <div class="visit_picture">
			            <img src="cy_mini.png" alt="방명록 작성자 프로필사진" />
			          </div>
			          <div class="visit_text">${gvo.content } </div>
			        </div>
               	
               	</c:forEach>
               	
               	<hr>
               	
               	<ol class="paging">
					
						<%-- [이전으로]에 대한 사용여부 처리 --%>
						<c:if test="${p.beginPage == 1 }"> 
							<c:if test="${p.nowPage > p.numPerBlock }">
								<li class="disable"> &lt; 이전</li>
							</c:if>
						</c:if>
						<c:if test="${p.beginPage != 1 }">
							<li>
								<a href="/CYWORLD/guestBook?userCode=${userCode }&visitHost=${visitHost }&type=getList&cPage=${p.beginPage - 1 }"> &lt;이전 </a>
							</li>
						</c:if>
						
						<%-- 블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
						
						<c:set var="end" value="${p.endPage }"/>
						<c:if test="${(p.totalRecord % p.numPerPage == 0) && (p.totalRecord < p.numPerPage * p.numPerBlock) }"> 
							<c:set var="end" value="${p.endPage-1 }"/>
						</c:if>
						<c:forEach var="pageNo" begin="${p.beginPage }" end="${end }">
							
							
							<c:if test="${pageNo == p.nowPage }">
								<li class="now"> ${pageNo }</li>
							</c:if>
							
							<c:if test="${pageNo != p.nowPage }">
								<li> 
									<a href="/CYWORLD/guestBook?userCode=${userCode }&visitHost=${visitHost }&type=getList&cPage=${pageNo }"> ${pageNo } </a>
								</li>
							</c:if>
							
						</c:forEach>
						<%-- [다음으로]에 대한 사용여부 처리 --%>
						<c:if test="${p.endPage < p.totalPage }">
							<a href="/CYWORLD/guestBook?userCode=${userCode }&visitHost=${visitHost }&type=getList&cPage=${p.endPage + 1 }"> 다음 &gt;</a>
							
						</c:if>
						<c:if test="${p.endPage == p.totalPage }">
							<c:if test="${!(p.totalPage <= p.numPerBlock || nowBlock == totalBlock) }">
								<li class="disable"> 다음 &gt; </li>
							</c:if>
						</c:if>
						<li>
						</li>
					</ol>
				
			      </div>
			    </div>
			  </div>
			</div>
          <div class="menu_bar">
          	<c:if test="${userCode != visitHost }">
          		<a href="/CYWORLD/login_join/mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button2" style="padding-left: 5px;"> 마이룸</a>
          	</c:if>
            <a href="/CYWORLD/login_join/mainLoadController?userCode=${userCode }&visitHost=${visitHost }" class="menu_button1">&nbsp;&nbsp;홈</a>
            <a href="/CYWORLD/BoardController?type=list&userCode=${userVO.userCode }" class="menu_button2">&nbsp;&nbsp;게시판</a>
            <a href="#" class="menu_button4">&nbsp;&nbsp;방명록</a>
            <c:if test="${userCode == visitHost }">
            <button onclick="log_out()" style="position: relative; bottom: -300px; left: 8px;"> 로그아웃 </button>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>