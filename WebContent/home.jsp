<%@page import="com.mystudy.vo.BoardVO"%>
<%@page import="com.mystudy.dao.HomeStateDAO"%>
<%@page import="com.mystudy.vo.HomeStateVO"%>
<%@page import="com.mystudy.vo.FriendCommVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mystudy.vo.FriendVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.vo.ImageFileVO"%>
<%@page import="com.mystudy.vo.ProfileVO"%>
<%@page import="com.mystudy.dao.ImageFileDAO"%>
<%@page import="com.mystudy.dao.ProfileDAO"%>
<%@page import="com.mystudy.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
     <title>${visitHostVO.name} 님의 미니홈피</title>
    <link rel="stylesheet" href="/CYWORLD/static/font.css" />
    <link rel="stylesheet" href="/CYWORLD/static/layout.css" />
    <link rel="stylesheet" href="/CYWORLD/static/home.css" />
    <link rel="stylesheet" href="/CYWORLD/static/common.css?ds" />
    <link rel="short icon" href="#">
    
    <script src="https://kit.fontawesome.com/ae242928e2.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    
    
<%-- 세션영역 유저코드 저장 변수명 : userCode --%>
<%
	//로그인 후 메인 에서 불러올거 : 방문홈페이지 정보 프로필, 친구평, 친구목록 
	// 방문페이지의 정보 노출 하면됨
	
	//친구평 관련 상태 
	String state = request.getParameter("state");

	int userCode = (int)request.getAttribute("userCode");
	int visitHost = (int)request.getAttribute("visitHost");
	
	session.setAttribute("userCode", userCode);
	session.setAttribute("visitHost", visitHost);
	
	UserVO visitHostVO = (UserVO)request.getAttribute("visitHostVO");
	session.setAttribute("visitHostVO", visitHostVO);
	
	System.out.println((UserVO)request.getAttribute("visitHostVO"));
	
	System.out.println(">>>>>>>>>> home.jsp 들어옴, userCode = " + userCode + ", visitHost = " + visitHost);

	// 로그인 유저 정보 VO 받아옴
	UserVO userVO = (UserVO) request.getAttribute("userVO");
	session.setAttribute("userVO", userVO);
	//System.out.println("유저 vo : " + userVO);

	// 홈페이지 주인 친구 목록 리스트로 받아옴
	List<FriendVO> friendList = (List<FriendVO>) request.getAttribute("friendList");
	//System.out.println("홈페이지 주인 친구 목록 : " + friendList);
	
	//프로필에서 최근 등록한 프로필게시글 찾아오기
	ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
	session.setAttribute("pvo", pvo);
	
	//Image File 테이블에서 프로필 사진 가져오기(경로포함)
	String pfImgSrc = ImageFileDAO.getImg(visitHost);
	session.setAttribute("pfImgSrc", pfImgSrc);
	System.out.println("[home] 프로필이미지 >> : " + pfImgSrc);
	

	//친구평 정보 
	List<FriendCommVO> friendCommList = (List<FriendCommVO>) request.getAttribute("friendCommList");
	System.out.println("[home] 친구평 목록>> : " + friendCommList);
	session.setAttribute("friendCommlist", friendCommList);
	//int friendCommCode ;
	
	
	//미니홈피 상태 - 미니홈피제목, 투데이 토탈
	HomeStateVO HSvo = HomeStateDAO.getHomeState(visitHost);
	session.setAttribute("HSvo", HSvo);
	System.out.println("[home] 홈페이지 상태> : " + HSvo);
	
	//최근 게시글 목록 불러오기
	List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("boardList");
	session.setAttribute("boardList", boardList);
	System.out.println("[home] 게시글 목록>> : " + boardList);
	
	
	System.out.println("========================= home.jsp 로딩 완료 ==================================");
	
	
	
	// 새로운 푸시 존재여부 확인
	int newPushCheck = (Integer) request.getAttribute("newPushCheck");
	pageContext.setAttribute("newPushCheck", newPushCheck);

	
%>
<script>
//문서 다 읽히고 나서 실행할 함수 모음

$(function() {	
	console.log("페이지 로드됨");
	friend_ajax();		

});

</script>


<script>
	function log_out() {
		 location.href="logout.jsp";
	}
	function user_account(){
		 location.href="view_acc.jsp?userCode=${userVO.userCode }";
	}

</script>

<script>
	if(userCode != visitHost){
		
	}
</script>

<!-- 미니룸 제목관련 스크립트  -->
<script> 

	function homeNameEdit() {
		//alert("미니홈제목 수정 버튼 클릭");
		console.log($("#homeName").html());
		let htmlTag = '<input type="text" maxlength="10" value="${HSvo.homeName }" name="homeName" id="homeTitle" class ="textBox" onclick="homeNameClick()">';
		htmlTag += '<input type="button" value="저장" onclick="homeNameEdit_go(this.form)">';
		htmlTag += '<input type="reset" value="취소" onclick="homeNameEdit_cancel(this.form)">';
		console.log(htmlTag);
		$("#homeName").html(htmlTag);
	}
	
	function homeNameClick(){
		document.getElementById("homeTitle").value ="";
		return;
	}
	
	function homeNameEdit_go(frm){
		//alert("미니홈피 이름 변경 실행");
		frm.action = "homeState?type=clickEdit&userCode=${userCode}&visitHost=${visitHost}";
		frm.submit();
	}
	
	function homeNameEdit_cancel(frm) {
		// 미니홈 제목 변경 취소
		frm.action = "mainLoadController?state=good&userCode=${userCode}&visitHost=${visitHost}";
		frm.submit();
	}

</script>

<!--function friend_ajax() -->
<script> 
function friend_ajax() {
$.ajax({
		url: "friendComm",
		type: "post", 
		data: {"type":"viewList", "userCode" : ${userCode}, "visitHost": ${visitHost} },
		dataType: "json",
		
		success: function(data){
			console.log("친구평Ajax 처리 성공");	
			//console.log(data);
			//console.log(data.list);
			
			let htmlTag = "";
			let alist = data.list;			
			console.log(alist.length);

			
			if (alist.length < 1){
				htmlTag += '<div class="updated_news_right1">';
				htmlTag += '친구평이 없습니다';
				htmlTag += '</div>';
				
				$("#friendCommBox").append(htmlTag);
			} else {
					htmlTag += '<div style="height: 300px; overflow: auto">';
				for (let i = 0; i < alist.length; i++) {
					//console.log(alist[i].friendCommCode);
					let fcCode = alist[i].friendCommCode; 
					
					console.log("친구평 코드 : " + fcCode + "내용 :" + alist[i].content + "친구명 : " + alist[i].friendName);
					
					htmlTag += '<form class="friendComm" id="fcForm" action="friendComm?type=delete" method="post">';
					htmlTag += '<div class="updated_news_right1">';
					htmlTag += alist[i].content + '  || <div style="display: inline-block">(' +  alist[i].friendName +')</div>'; 
					htmlTag += '<a href="mainLoadController?userCode=${userCode }&visitHost=' + alist[i].guestCode+'">' + alist[i].guestName +'</a>';
					htmlTag += '<input type="hidden" name="friendCommCode" value="'+ alist[i].friendCommCode + '">';
					htmlTag += '<input type="hidden" name="visitHost" value=${visitHost}>';
					htmlTag += '<input type="hidden" name="userCode" value=${userCode}>';			
					
					
					htmlTag += '<a><img src="/CYWORLD/imgStorage/public/deleteButton.png" alt="삭제버튼"' +
									'width="20px" height="20px" onclick="fcFormSubmit()"></a>';				
					
				
					htmlTag += '</div>';
					htmlTag += '</form>';	
					
				}
				htmlTag += '</div>';
			$("#friendCommBox").append(htmlTag);
			
			//console.log("hmltTag:" + htmlTag);
			}
		},//success
		
		error: function(data){  
			alert("친구평Ajax 처리 실패 ");

		}
	}); 	
}

</script>


<script>

	//텍스트 박스 클릭시 내용지우기 (친구평)
	function textClick() {
		document.getElementById("friendComm").value ="";	
		return;			
	}
	
	function writeFM(frm) {
		console.log("친구평 작성 버튼 클릭");	
		frm.action="friendComm?type=write";
		frm.submit();
	}
	
	
	function fcFormSubmit() {	
		console.log("친구평 삭제 버튼 클릭");
		document.getElementById("fcForm").submit();
	}   
	
	
</script>

<!-- 프로필 팝업 관련 --> 
<script>
		var popupWidth = 500;
		var popupHeight = 500;
		// 팝업창 위치 --------------	
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY = (window.screen.height / 2) - (popupHeight / 2);
	
	    function profileEdit() {

	       	window.open('../profile.jsp', '_blank',  'height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY + ', resizable=no');  			
	    }
	    
		function history() {
	    	popupWidth = 400;
	    	vpopupHeight = 800;
	     	window.open('../profile?type=history&visitHost=${visitHost }', '_blank , scrollbars = yes ', 'height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY); 
		}
	
</script>	

<script>

    function show_friend_list(){ 
   		let con = document.getElementById("friend_list"); 
		if(con.style.display == 'none'){
			con.style.display = 'block';
			find_friend_from_friendList();
		} else {
			con.style.display = 'none';
		}
   	 }
     
     function log_out() {
    	 location.href="/CYWORLD/login_join/logout.jsp";
     }
     
     
	$(document).mouseup(function(){
 	  	
		for (let test of $(".dropdown_button")) {
		    if (event.target == test && test.nextElementSibling.style.display == "none"){
		        test.nextElementSibling.style.display = "block";
		    } else if (event.target.closest(".container_dropdown")) {
		           
		       } else {
		        test.nextElementSibling.style.display = "none";
		   	}
		}
	}); 
	
	
	$(document).keydown(function(){
		
		//console.log(event.target == $("#f_name")[0]);
		
		if (event.target == $("#f_name")){
			//console.log("하하하하하하");
		}
	})
	
	function inputBox_findUser(frm) {
		
		if (event.keyCode == 13) {
			find_users(frm);
		}
		
	}
     
//-------


</script>


<!--  친구리스트 불러오는 부분 -->
<script>

    
	function find_friend_from_friendList(){
		
		$("#edit_friend_button").css("display", "block");
	 
		$.ajax({
			url : "friend",
			type : "get",
			data : { "userCode" : ${visitHostVO.userCode }, "type" : "findFriendByName", "name" : $("#f_name").val() } ,
			dataType : "xml", 
			success : function(data){
				console.log(data);
				
				let htmlTag = "";
				$(data).find("friend").each(function(){
					
					editBoxText = $(this).find("friendName").text();
					htmlTag += "<tr>";
					htmlTag += "<td>" + $(this).find("name").text() + "</td>";
					htmlTag += "<td> <div style='inline-block' class='editBox'>" + $(this).find("friendName").text() + "<i class='fa-solid fa-pen-to-square friend_list_hidden hidden_write_icon' style='display:none;' onclick='edit_friend_name("+$(this).find("friendCode").text()+", this)'></i> </div></td>";
					htmlTag += "<td> <a href='mainLoadController?userCode=${userCode }&visitHost="+ $(this).find("userCode2").text()+"'> 놀러가기 </a> </td>";
					htmlTag += "<td class='friend_list_hidden' style='display:none;'> <button class='hidden_delete_button' onclick='friend_delete("+$(this).find("userCode2").text()+")'> 삭제 </button></td>";   
					htmlTag += "</tr>";
				});
				
				$("#tbody_exist").html(htmlTag);
			},
			error : function(jqXHR,textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
					+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
					+ "textStatus : " + textStatus + "\n"
					+ "errorThrown : " + errorThrown + "\n"
				);
			}
		});
	 
	}

</script>


<!-- 친구 편집 -->
<script>
	
	let box;
	let temporal;
	let editBoxText;
	
	function edit_friend_name (friendCode, element) {
		
		
		box = element.parentNode;
		editBoxText = element.previousSibling.textContent;
		
		let editBox = $("#hidden_edit_box");
		
		
		if (editBox.length == 0) {
			temporal = box.innerHTML;
			box.innerHTML = "<div id='hidden_edit_box' style='position:relative;z-index: 3;'><input id='choiced_box' type='text' style='width: 50px;' value=" + editBoxText + "> <div style='display: inline-block;'><i class='fa-solid fa-check' onclick='friendName_update(" + friendCode + ")'></i></div><div style='display: inline-block;'><i class='fa-solid fa-x' onclick='friendName_cancel()'></i></div></div>";
		} 
		
		
		for (let element of $(".hidden_delete_button")) {
			
			if(element.style.display == 'none') {
				element.style.display = 'inline';	  
			} else {
				element.style.display = 'none';	    			
			}
		} 
		
		for (let element of $(".hidden_write_icon")){
			
			element.style.display = 'none';
		}
		
		$("#edit_friend_button").css("display", "none");
		
		event.stopPropagation();
		
	} 
	
	
	function friendName_update (friendCode) {
		
		let text = $("#choiced_box").val();
		
		location.href = "friend?type=friendNameUpdate&text=" + text + "&friendCode=" + friendCode + "&userCode=${userCode }&visitHost=${visitHost }";
		
	}
	
	function friendName_cancel() {
		
		box.innerHTML = temporal;
		event.stopPropagation();
		
		for (let element of $(".hidden_delete_button")) {
					
			if(element.style.display == 'none') {
				element.style.display = 'inline';	  
			} else {
				element.style.display = 'none';	    			
			}
		} 
		
		for (let element of $(".hidden_write_icon")){
			
			element.style.display = 'inline-block';
		}
		
		$("#edit_friend_button").css("display", "block");
	}
	
	function friend_delete(opponentCode){
					 
		location.href="friend?type=deleteFriend&opponentCode=" + opponentCode +"&userCode=" + ${userVO.userCode };
	}
			 
					 
		
		 
		 
	function edit_friend(){
	 	 
		for (let element of $(".friend_list_hidden")){
	 		
			if(element.style.display == 'none') {
				element.style.display = 'inline';	  
			} else {
				element.style.display = 'none';	    			
			}
		}
	}
  
	$().ready(function(){
	 
		//console.log($(".search_delete")[0]);
		
		for (let element of $(".search_delete")){
			element.onclick = function(){
				element.previousElementSibling.value = null;
			}
		}
		/* $(".search_delete").click(function(){
			$("#f_name").val(null);
		}); */
			 
		let opts = document.querySelectorAll(".show_container");
		
		for (let opt of opts) {
			
			opt.addEventListener("click", showContainer);
		}
		
		
		
		function showContainer() {
			
		}
		
		/* console.log($(newPushCheck > 0);
		if ($(newPushCheck > 0)) {
			 $("#new_push_icon").css("display", "inline-block");
		 }  */
	});
				 

	     
	
</script>


<!-- 유저 검색 -->
<script>
			
	function find_users(frm){
		// 제이쿼리 click 이벤트로도 해보기
		
		console.log(frm);
		let this_form = frm;
			
		if (this_form.text.value == '') {
			alert("검색어를 입력해주세요");
			return;
		}
		
		$.ajax({
			url : "friend",
			type : "get",
			data : { "userCode" : ${userVO.userCode }, "type" : "findUser", "text" : this_form.text.value
					, "birth" : this_form.birth.value
					, "gender" : this_form.gender.value, "subType" : this_form.subType.value } ,
			dataType : "xml", 
			success : function(data){
				console.log(data);
				
			let htmlTag = "";
			
			if ($(data).find("user").length == 0) {
				
				htmlTag += "<tr style='height: 50px;'>"
				htmlTag += "<td colspan='4'> 유저가 존재하지 않습니다. </td>";
				htmlTag += "</tr>"
				
			} else {
				$(data).find("user").each(function(){
					htmlTag += "<tr>";
					htmlTag += "<td>" + $(this).find("id").text() + "</td>";
					htmlTag += "<td>" + $(this).find("name").text() + "</td>";
					htmlTag += "<td>" + $(this).find("birth").text() + "</td>";   				//친구찾기로 나온 친구 코드
					htmlTag += "<td> <a href='mainLoadController?userCode=${userCode }&visitHost="+ $(this).find("userCode").text()+"'> 놀러가기 </a> </td>";
					htmlTag += "<td> <button onclick=\"send_friend_request(\'"+$(this).find("name").text()+"\',\'"+$(this).find("id").text()+"\',"+$(this).find("userCode").text()+")\"> 친구신청 </button> </td>";
					htmlTag += "</tr>";
				});
			}
						
			$("#tbody_new").html(htmlTag);
		},
		error : function(jqXHR,textStatus, errorThrown){
			alert("Ajax 처리 실패 : \n"
				+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
				+ "textStatus : " + textStatus + "\n"
				+ "errorThrown : " + errorThrown + "\n"
			);
				}
		});
			 
	}
	
	
	function show_detail_option() {
			
		let detail_box = $("#search_detail_box");
		let right_icon = $(".detail_search_right_arrow")[0];
		let down_icon = $(".detail_search_down_arrow")[0];
		
		if (detail_box.css("display") == 'none') {
			detail_box.css("display", 'block');
			right_icon.style.display = 'none';
			down_icon.style.display = 'inline-block';
		} else {
			detail_box.css("display", 'none');
			right_icon.style.display = 'inline-block';
			down_icon.style.display = 'none';
		}
		
		
		
			
	}
</script>


<!-- 친구요청 확인 -->
<script>
			
     function show_friend_request() {
    	 
    	 $.ajax({
				url : "friend",
				type : "get",
				data : { "userCode" : ${userVO.userCode }, "type" : "requestList"
						} ,
				dataType : "xml", 
				success : function(data){
					console.log(data);
					
					let htmlTag = "";
					$(data).find("request").each(function(){
						
						htmlTag += "<div style='border:solid 1px black; margin: 5px;'>";
						htmlTag += "<div style='display: flex; justify-content: space-between;'>";
						htmlTag += 	"<div> " + $(this).find("name").text() +  " (" + $(this).find("id").text() +")" + "</div>";
						htmlTag += 	"<div> <a> 프로필 </a> <a> 마이룸 </a></div>";
						htmlTag += "</div>";
						htmlTag += "<div>" + $(this).find("message").text() + "</div>";   				
						htmlTag += "<div>";
						htmlTag += "<button style='margin-right: 10px;' onclick=\'go_accept("+$(this).find("requesterCode").text()+", "+$(this).find("requestCode").text()+")\'> 수락 </button>";
						htmlTag += "<button onclick=\"go_reject("+$(this).find("requesterCode").text()+", "+$(this).find("requestCode").text()+")\"> 거절 </button>";
						htmlTag += "</div>";
						htmlTag += "</div>";
					});
					
					$("#requestList").html(htmlTag);
				},
				error : function(jqXHR,textStatus, errorThrown){
					alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown + "\n"
					);
				}
			});
     }

	function go_accept(requesterCode, requestCode){
		
		location.href = "friend?requestCode=" + requestCode + "&type=accept&userCode="+${userVO.userCode }+"&requesterCode="+requesterCode;
	}
			
	function go_reject(requesterCode, requestCode) {
		
		location.href = "friend?type=reject&requestCode=" + requestCode + "&userCode=" + ${userVO.userCode } + "&requesterCode=" + requesterCode;
	}
	     

     
	function send_friend_request(name, id, userCode) {
		
    	popupWidth = 600;
    	popupHeight = 600;
       	window.open('../send_friend_request.jsp?opponentCode='+userCode+"&name="+name+"&id="+id, '_blank',  'height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY, 'resizable=no');  			
	}
     
   
</script>

<!-- 알림 -->
<script>
	
	function push() {
		 
		 $.ajax({
				url : "push",
				type : "get",
				data : { "userCode" : ${userVO.userCode }, "type" : "pushList"
						} ,
				dataType : "xml", 
				success : function(data){
					
					console.log(data);
					
					let htmlTag = "";
					
					$(data).find("push").each(function(){
						
						if ($(this).find("guestCode").text() != '0') {
							
							
						} else if ($(this).find("comCode").text() != '0') {
							
						} else {
							htmlTag += "<div class='content-background-color unchecked' style='border:solid 1px black; margin: 10px; padding: 10px; border-radius: 5px;'>";
							if($(this).find("content").text() == 'Y') {
								htmlTag += "<div>" + $(this).find("opponentName").text() + "(" + $(this).find("opponentId").text() + ") 님이 친구요청을 승락하셨습니다.";
								
							} else {
								htmlTag += "<div>" + $(this).find("opponentName").text() + "(" + $(this).find("opponentId").text() + ") 님이 친구요청을 거절하셨습니다.";
							}
							htmlTag += "</div>";
							htmlTag += "</div>";
							
						}
					});
					
					$("#pushList").html(htmlTag);
					
				},
				error : function(jqXHR,textStatus, errorThrown){
					alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown + "\n"
					);
				}
			});
		 
		 
		 
	}
	 
	let unchecked;
	$().ready(function(){
		
		unchecked = document.querySelectorAll(".unchecked");
		console.log(unchecked);
		unchecked.forEach((target) => target.addEventListener("click", check_push));
	});
	

</script>
	     
<script> 

	function homeNameEdit() {
		//alert("미니홈제목 수정 버튼 클릭");
		console.log($("#homeName").html());
		let htmlTag = '<input type="text" value="${HSvo.homeName }" name="homeName" id="homeTitle" class ="textBox" onclick="homeNameClick()">';
		htmlTag += '<input type="button" value="저장" onclick="homeNameEdit_go(this.form)">';
		htmlTag += '<input type="reset" value="취소" onclick="homeNameEdit_cancel(this.form)">';
		console.log(htmlTag);
		$("#homeName").html(htmlTag);
	}
	
	function homeNameClick(){
		document.getElementById("homeTitle").value ="";
		return;
	}
	
	function homeNameEdit_go(frm){
		//alert("미니홈피 이름 변경 실행");
		frm.action = "homeState?type=clickEdit&userCode=${userCode}&visitHost=${visitHost}";
		frm.submit();
	}
	
	function homeNameEdit_cancel(frm) {
		// 미니홈 제목 변경 취소
		frm.action = "mainLoadController?state=good&userCode=${userCode}&visitHost=${visitHost}";
		frm.submit();
	}
	
	
	
</script>  

        
</head>
  <body>
    <div class="bookcover">
      <div class="bookdot">
        <div class="page">
          <div class="home">
            <!-- upside -->
           
           
<!-- !!미니제목!!! 1028 수진 수정 시작 미니홈~~ -->


<!-- !!!!!!! 투데이, -->
              <div class="upside">
              
              <div class="homeName">
             		<div id="today">
	              <strong>&emsp;&emsp;&emsp;&emsp;&emsp;TODAY <span style="color:coral;">${HSvo.today }</span> | TOTAL ${HSvo.today }</strong> &emsp;&emsp;&emsp; &emsp; 
	              &emsp;&emsp;
	              </div>
	              <div id="title">
		              <form id="homeName" method="post">
		              		<span class="title">${HSvo.homeName }</span> &emsp;&emsp;&emsp; 
		              		<c:if test="${userCode == visitHost }">
		              			<input type="button" value="수정" onclick="homeNameEdit()">
		              		</c:if>
		              </form>
	              </div>
              </div>
              <%-- 친구화면과 내화면 구분하는 조건 --%>
              <c:if test="${userCode == visitHost }">
              
              <div id="menue_top_group" style="display: inline-block;float: right; position: absolute; right: 90px;">
              <div style="display:inline;">
              
              <button class="dropdown_button button_mouse_event" onclick="find_friend_from_friendList()">친구목록</button> 
              <div class="container_dropdown" style="left: -280px; display: none;">
              <div class="container_dropdown_inner">
              	<div style="display:flex; justify-content:space-between;"> 
              		<div class="container_dropdown_header">
              			<input type="text" id="f_name" placeholder="검색" onkeyup="find_friend_from_friendList()" style="padding-right: 30px; width: 165px;">
              			<i class="fa-solid fa-circle-xmark search_delete" style="position: relative; left: -30px;"></i>
              			<i class="fa-solid fa-magnifying-glass" onclick="find_friend_from_friendList()" style="position: relative; left: -20px;"></i>
           			</div>
					<button onclick="edit_friend()" id="edit_friend_button" style="border: none;"> 친구편집</button>              		
              	</div>
              	<hr>
              	<div>
              		<table style="width: 100%; border-collapse: collapse;">
              			<tr style="border-bottom: dotted 1px black;">
              				<th> 친구 </th>
              				<th> 친구명 </th>
              				<th> 미니홈피 </th>
              				<th class="friend_list_hidden" style="display:none;"> </th>
           				</tr>
           				
           				<tbody id="tbody_exist">
		              		<%-- <c:forEach var = "fvo" items="${friendList }">
		              			<tr>
		              				<th> ${fvo.name }</th>
		              				<th> ${fvo.friendName }</th>
            						<th> <a href="mainLoadController?userCode=${userCode }&visitHost=${fvo.userCode2 }" style="text-decoration: none; color: black;"> 놀러가기 </a></th>

		              			</tr>
		              		</c:forEach> --%>
	              		</tbody>
              		</table>
              	
              	</div>
              
              </div>
              </div>
              </div> 
              |
              <div style="display:inline;">
              <button class="dropdown_button button_mouse_event">유저검색</button>
              <div class="container_dropdown" style="left: -200px; display: none;">
              <div class="container_dropdown_inner">
              	
              	<form method="get" onsubmit="return false;">
	              	<div class="container_dropdown_header"> 
	              		<div>
							<select name="subType">
							  <option value="none" disabled>= 검색조건 =</option>
							  <option value="name" selected>이름</option>
							  <option value="id">아이디</option>
							</select>
	              			<input type="text" name="text" id="u_name" placeholder="검색" onkeydown="inputBox_findUser(this.form)" style="width: 165px; padding-right: 30px;">
	              			<i class="fa-solid fa-circle-xmark search_delete" style="position: relative; left: -30px; "></i>
	              			<i class="fa-solid fa-magnifying-glass" onclick="find_users(this.parentNode.parentNode.parentNode)" style="position: relative; left: -15px;"></i>
	           			</div>
	           			<!-- <button style="border: none; margin: 5px 5px 0px 0px;" onclick=""> 상세검색<i class="fa-solid fa-chevron-right detail_search_right_arrow"></i> <i class="fa-solid fa-chevron-down detail_search_down_arrow" style="display: none;"></i> </button>-->
	              		<button type="button" style="border: none; margin: 5px 5px 0px 0px;" onclick="show_detail_option()"> 상세검색 <i class="fa-solid fa-chevron-right detail_search_right_arrow"></i> <i class="fa-solid fa-chevron-down detail_search_down_arrow" style="display: none;"></i></button>
	              	</div>
              	
	              	<div id="search_detail_box" style="display: none;">
	              		<table style="width: 100%;">
	              			<tr>
	              				<th> 생년월일 </th>
	              				<td> <input type="date" name="birth"></td>
	              			</tr>
	              			<tr>
	              				<th> 성별 </th>
	              				<td> <input type="radio" name="gender" value="M"> 남  &emsp;&emsp;
	              					 <input type="radio" name="gender" value="F"> 여
	              				</td>
	              			</tr>
	              		
	              		</table>
	              		<hr>
	              	</div>
	              	<input type="hidden" name="type" value="new">
	              	<input type="hidden" name="userCode" value="${userVO.userCode }">
	              	<input type="hidden" name="visitHost" value="${visitHostVO.userCode }">
	              	
              	</form>
              	
              	
              	<div>
              		<table style="width: 100%; border-collapse: collapse;">
              			<tr style="border-bottom: dotted 1px black;">
              				<th> 아이디 </th>
              				<th> 이름 </th>
              				<th> 생년월일 </th>
              				<th> 미니홈피 </th>
              				<th>  </th>
           				</tr>
           				
           				<tbody id="tbody_new">
		              		<tr style="height: 50px;">
		              			<th colspan="4"> 유저를 검색해주세요 </th>
		              		</tr>
	              		</tbody>
              		</table>
              	
              	</div>
              
              </div>
              </div>
            </div>
            
            
			<div style="display:inline ">
				<i class="fa-solid fa-user dropdown_button" style="font-size: 15px;" onclick="show_friend_request()" > <i class="fa-solid fa-plus" style="color: orange; font-size: 5px; position: absolute; right: 40px;"></i></i>
				<div class="container_dropdown" style="left: 0px; display: none; position: absolute; left: -150px;">
              	<div class="container_dropdown_inner">
	              	<div style="display: flex; justify-content: space-between;"> 
	              		<p> 요청받은 친구목록 </p>
	              		<button> 모두수락</button>
	              	</div>
	              	<hr>
	              	
	              	<div id="requestList" style="height: 440px; overflow: auto;">
	              	
	              	
	              	
	              	</div>
              	</div>
				</div>
				<i class="fa-solid fa-bell __icon__middle dropdown_button" style="font-size: 15px; position: relative; right: 10px;" onclick="push()"><i id="new_push_icon" class="fa-sharp fa-solid fa-circle-exclamation" style="font-size: 10px; z-index: 3;position: absolute; right: 5px; color: red; display: none;"></i></i> 
				<div class="container_dropdown" style="left: 0px; display: none; position: absolute; left: -120px;">
              	<div class="container_dropdown_inner">
	              	<div style="display: flex; justify-content: space-between;"> 
	              		<p> 알림목록 </p>
	              		<button> 모두확인 </button>
	              	</div>
	              	<hr>
	              	
	              	<div id="pushList" style="height: 440px; overflow: auto;">
	              	
	              	
	              	
	              	</div>
              	</div>
				</div>
				
            </div>
            	
           	</div>
           	</c:if>
            
            </div>
            <%-- 프로필 사진 부분 --%>           
             <div class="home_main">
         
              <div class="profile">
                
                <div class="profile_1"> <img class="profile_image" src="${pfImgSrc }"/> </div>
                <div class="profile_2">${pvo.content }</div> 
                <div class="profile_3" style="text-align: center;">${visitHostVO.name } | ${visitHostVO.birth.substring(0,10) } </div>
                <div class="profile_4">
	 				<div style="text-align: center; position: relative; bottom: 20px;">
				 	<c:if test="${userCode == visitHost}"> 	
	                	<input type="button" value="수정" onclick="profileEdit()">
	 				</c:if>
	                	<input type="button" value="히스토리" onclick="history()">
					</div>
	                 <!-- 
	                  <div class="profile-dropdown">
	                    <div class="dropdown-btn">
	                      <div class="dropdown-title">Related Link</div>
	                      <div class="triangle-down"></div>
	                    </div>
	                  </div>
	                   -->
                </div>
              
              </div>
              
              
              
              
              
              <div class="home_contents">
                <div class="updated_news_title"><br><strong>Updated news</strong></div>
                <div class="updated_news_contents">
                  <div class="updated_news_left">
                   <c:forEach var="newBoard" items="${boardList }">
                    <span class="updated_news_left1"><span class="updated_news_red">&nbsp;게시판&nbsp;</span>&nbsp;&nbsp;<a href="../BoardController?type=view&postCode=${newBoard.postCode }">${newBoard.title }</a></span>
                  </c:forEach>
                  </div>
               
                </div>
                
                
                
                
               <div class="miniroom_title" ><br><strong>친구평</strong></div>
				<form id="friendCommWrite" method="post" style="padding: 5px 20px;">	
				<c:if test="${userCode != visitHost}"> 
					<input type="text" value="친구평을 작성하세요" size="50%" id="friendComm" class ="textBox" name="content" onclick="textClick()">	
					<input type="button" value="남기기" onclick="writeFM(this.form)">	                
					<input type="hidden" name="visitHost" value="${visitHost }">	                
					<input type="hidden" name="userCode" value="${userCode }">	                	 	
				</c:if>
				</form>
				<div id="friendCommBox" style="padding: 0px 20px;"></div>
              </div>
            </div>
          </div>
          <div class="menu_bar">
           <c:if test="${userCode != visitHost }">
          		<a href="mainLoadController?userCode=${userCode }&visitHost=${userCode }" class="menu_button2" style="padding-left: 5px;"> 마이룸</a>
          	</c:if>
            <a href="#" class="menu_button1">&nbsp;&nbsp;홈</a>
            <a href="/CYWORLD/BoardController?type=list&userCode=${userVO.userCode }" class="menu_button2">&nbsp;&nbsp;게시판</a>
            <a href="/CYWORLD/guestBook?userCode=${userCode }&visitHost=${visitHost }&type=getList&cPage=1" class="menu_button4">&nbsp;&nbsp;방명록</a>
           <c:if test="${userCode == visitHost }">
           <button onclick="log_out()" style="position: relative; bottom: -300px; left: 8px; z-index: 5;"> 로그아웃 </button>
          <button onclick="user_account()" style="position: relative; bottom: -240px; left: 8px;z-index: 5;">내정보</button> 
          </c:if>
          
          </div>
        </div>
      </div>
    </div>
  </body>