<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.command.ProfilePaging"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mystudy.vo.ImageFileVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 현재페이지에 표시할 데이터를 화면에 표시 
	 1. 페이징 처리를 위한 객체(Paging) 생성해서 필요한 데이터 참조 
	 2. 페이징 객체에 설정할 데이터 저장 
	 3. (DB) 전체 데이터 건수 조회 
	 4. (DB) 현제 페이지에 표시할 게시글 데이터 조회
	 5. 데이터 화면에 표시 (화면컨드롤 - 스타일지정)
--%>   
<% 
	//user code만 가져오기
	//UserVO userVO = (UserVO)session.getAttribute("userVO");
	//System.out.println("userVO : " + userVO);

	int userCode = (int)session.getAttribute("userCode");
	int visitHost = (int)session.getAttribute("visitHost");
	System.out.println("[profile_history]visitHost : " + visitHost);

	//(페이징)-------------------------------
	ProfilePaging p = new ProfilePaging();
	
	//1. 전체 프로필 수량 구하기
	p.setTotalProfile(ProfileDAO.getProNum(userCode));
	System.out.println("[profile_history] 전체 프로필 수 : " + ProfileDAO.getProNum(visitHost));
	// 전체 페이지 갯수 
	System.out.println("Totalcontent() : " + p.getTotalProfile());
	p.setTotalPage();
	System.out.println("TotalPage() : " + p.getTotalPage());
	
	//2. 현재페이지
	String crntPage = (String)request.getParameter("crntPage");
	if (crntPage != null) {
		p.setNowPage(Integer.parseInt(crntPage));
	} else {
		p.setNowPage(1);
	}
	System.out.println("crntPage : " + crntPage);
	System.out.println("nowPage : " + p.getNowPage());
	
	//3. 현재 페이지에 표시할 게시글 시작번호 끝번호 구하기
	p.setEnd(p.getNowPage() * p.getNumViewPage());
	p.setBegin(p.getEnd() - p.getNumViewPage() + 1);
	
	if(p.getEndPage() > p.getTotalPage()){
		p.setEndPage(p.getTotalPage());
	}
	//System.out.println("> 시작번호(begin) :" + p.getBegin());
	//System.out.println("> 끝번호(end) :" + p.getEnd());
	
	
	//block계산
	//block 시작페이지, 끝페이지
	int nowPage = p.getNowPage();
	int beginPage = (nowPage - 1) / p.getNumViewBlock() * p.getNumViewBlock() + 1; 
	p.setBeginPage(beginPage);
	p.setEndPage(beginPage + p.getNumViewBlock() - 1);
	
	if(p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
	}
	//System.out.println("> BeginPage :" + p.getBeginPage());
	//System.out.println("> endPage :" + p.getEndPage());
	
	
	//!! 수정
	//프로필 전체 리스트
	List<ProfileVO> historyList = ProfileDAO.getPageList(visitHost, p.getBegin(), p.getEnd());
	pageContext.setAttribute("historyList", historyList);
	//System.out.println("historyList size() :" + historyList.size());

	// 가장 최근 프로필
	ProfileVO rcntPf = ProfileDAO.rcntProfile(visitHost);
	pageContext.setAttribute("rcntPf", rcntPf);
	//System.out.println("rcntPf :" + rcntPf);
	
	// pageScope에 등록
	pageContext.setAttribute("pvo", p); //페이지 객체
	
	
	
	//-------------------------------------------------------------------------
	
	
	//USERCODE, IMG SRC, 제목, 프로필CONTENTS, 게시일  
	//List<ProfileVO> proList= (List<ProfileVO>)request.getAttribute("proList");
	//pageContext.setAttribute("proList", proList);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필히스토리</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<!-- 
<link rel="stylesheet" href="./static/font.css" />
    <link rel="stylesheet" href="./static/layout.css" />
    <link rel="stylesheet" href="./static/diary.css" />
 -->
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
	div, h1 {
		text-align: center;
		margin: auto;
	}	

	#content {
		background-color:  #FFFFFF;
		border: 0.5px solid grey;
		border-radius: 10%;
		
		width: 280px;
	}

	#content_text {
		text-align: center;
		width: 180px;
		border: 1px dotted grey;
		margin: auto;
	}

	.flex_container1 div {
		display: inline-block;
	
	}
	#history_img {
		 width: 180px;
		 height: 180px;
	}
	.disable {
		color: bisque;
	}
	.pageBtn {
		text-decoration: none;
	}
	
	#pageBlock a{
		text-decoration: none;
	}

</style>
</head>
<script>

function history_delete(frm) {
	$(".historyChk:checked").each(function(){
		var checkedNum = $(".historyChk:checked").val();
		console.log("삭제될거 : " + $(".historyChk:checked").val());
		//frm.action="delete?historyChked" + checkedNum;
		frm.action="profile?type=delete&historyChked=" + checkedNum;
		frm.submit();
	})
}
	
	


</script>
<body>
<h1>프로필히스토리</h1><br><br>
	<div  class="history_container"  style="overflow: auto;">
	
		<form method="post">
			<c:if test="${empty historyList }">
				<div>히스토리가 없습니다.</div>
			</c:if>
			<c:if test="${not empty historyList }">
				<c:if test="${userCode == visitHost }">
					<div class="flex_item"><input type="button" value="삭제" onclick="history_delete(this.form)"></div> 			
				</c:if>
				
			<c:forEach var="profile" items="${historyList }"> 	
				<div id="content">
					<br>
				<div class="content_item" style="display: flex; justify-content: space-between; width: 40%; margin: auto; ">

					<div class="content_item" >${profile.regdate.substring(0,10) }</div>
					
					<c:if test="${profile.profileCode == rcntPf.profileCode && userCode == visitHost}">
						<input type="checkbox" class="historyChk" name="historyChked" value="${profile.profileCode }" disabled="disabled">
					</c:if>	
					<c:if test="${profile.profileCode != rcntPf.profileCode }">
						<div class="content_item" ><input type="checkbox" class="historyChk" name="historyChked" value="${profile.profileCode }"></div>
					</c:if>

				</div>

				<div><img id="history_img" src="/CYWORLD/imgStorage/${profile.sysFilename }" alt="${profile.oriFilename }"></div>
				<br>
				<div id="content_text">${profile.content}</div>		
				<br><br>
			</div>
			<br><br><br><br>
			</c:forEach>
		
			</c:if>
		</form>
	</div>
	
	
	<div  class="flex_container3">
	<c:if test="${!empty historyList }">
		<div id="pageBlock" style="display: flex; justify-content: space-between; width: 60%; margin: auto; ">

<!-- 이전페이지 -->
		<c:if test="${pvo.beginPage == 1 }">
				<div class="pageBtn"><a href="profile_History.jsp?crntPage=${pvo.beginPage - 1 }" style="color: #585858;">◀</a></div>
		</c:if>
		<c:if test="${pvo.beginPage != 1 }">
				<div class="pageBtn"><a href="profile_History.jsp?crntPage=${pvo.beginPage - 1 }" style="color: #585858;">◀</a></div>
		</c:if>
			
<!-- 시작~끝페이지 -->

			<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
				<c:if test="${pageNo == pvo.nowPage }">
					<div class="disable">${pageNo }</div>
				</c:if>
				<c:if test="${pageNo != pvo.nowPage }">
					<div><a href="profile_History.jsp?crntPage=${pageNo }">${pageNo }</a></div>
				</c:if>
			</c:forEach>
			

<!--  다음페이지 -->	
		<div class="pageBtn"> 
			<c:if test="${pvo.endPage < pvo.totalPage }">
				<div><a href="profile_History.jsp?crntPage=${pvo.endPage + 1 }" style="color: #585858;">▶</a></div>
			</c:if>
			<c:if test="${pvo.endPage >= pvo.totalPage }">
				<div class="disable">▶</div>
			</c:if>
		</div>
	
	
		</div>
	</c:if>
	</div>

</body>
</html>