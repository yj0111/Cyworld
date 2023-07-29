package com.mystudy.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mystudy.dao.ImageFileDAO;
import com.mystudy.dao.ProfileDAO;
import com.mystudy.vo.ImageFileVO;
import com.mystudy.vo.ProfileVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/profile")
public class profile_controller extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> P_upload_controller doGet 실행");
		String type = request.getParameter("type");
		String path  = "z:/";
		
		if ("upload".equals(type)) {			
		//업로드파일에 사진 저장
			MultipartRequest mr = new MultipartRequest(
									request, path,
									10 * 1024 * 1024, 
									"UTF-8", new DefaultFileRenamePolicy());
		
			String oriFilename = mr.getOriginalFileName("oriFilename");
			String sysFilename = mr.getFilesystemName("oriFilename");
			
			if(sysFilename != null) {
				
				int userCode = Integer.parseInt(mr.getParameter("userCode"));
				String content = mr.getParameter("content");
				
				System.out.println("userCode : " + userCode);
				
				ProfileVO pvo = new ProfileVO();
				pvo.setUserCode(userCode);
				pvo.setOriFilename(oriFilename);
				pvo.setSysFilename(sysFilename);
				pvo.setContent(content);
				
				//profile DB에 입력
				ProfileDAO.wrtProfile(pvo);
				System.out.println(">>  ProfileDB 입력완료 ");
				
				//profile 게시글 번호 받기
				int profileCode = ProfileDAO.getProCode(userCode);
				
				//imagefileDB에 입력
				ImageFileVO ivo = new ImageFileVO();
				ivo.setPostCode(profileCode);
				ivo.setOriFilename(oriFilename);
				ivo.setSysFilename(sysFilename);
				ivo.setStoragePath(path);
				ivo.setUserCode(userCode);
				
				ImageFileDAO.insertImg(ivo);
				System.out.println(">>  ImageFile DB 입력완료 ");
				
				//프로필 저장후 home 으로 이동+reload
				request.getRequestDispatcher("profile.jsp?result=good").forward(request, response);
			} else {
				request.getRequestDispatcher("profile.jsp?result=empty").forward(request, response);
			}
			return;
			
		} else if ("reset".equals(type)) {
			// 기본프사로 변경
			int userCode = Integer.parseInt(request.getParameter("userCode"));
			String oriFilename= request.getParameter("oriFilename");
			String content= request.getParameter("content");

			ProfileVO pvo = new ProfileVO();
			pvo.setUserCode(userCode);
			pvo.setOriFilename(oriFilename);
			pvo.setSysFilename(oriFilename);
			pvo.setContent(content);
			
			//profile DB에 입력
			ProfileDAO.wrtProfile(pvo);
			System.out.println(">>  ProfileDB 입력완료 (초기화) ");
			response.sendRedirect("profile.jsp?result=good");
			
		} else if ("rcntProfile".equals(type)) { 
			int visitHost = Integer.parseInt(request.getParameter("visitHost"));
			System.out.println("[방문 홈페이지] : " + visitHost);
			
			//메인 페이지에서 최근프로필 노출
			ProfileVO pvo = ProfileDAO.rcntProfile(visitHost);
			request.setAttribute("pvo", pvo);

			request.getRequestDispatcher("home.jsp").forward(request, response);	
			return;
	
		} else if ("history".equals(type)) {
			//프로필 히스토리 보기
			int visitHost = Integer.parseInt(request.getParameter("visitHost"));
			List<ProfileVO> proList = ProfileDAO.getProHistory(visitHost);
			request.setAttribute("proList", proList);
			
			List<ImageFileVO> imgList = ImageFileDAO.getImgHistory(visitHost);
			request.setAttribute("imgList", imgList);
			
			request.getRequestDispatcher("profile_History.jsp").forward(request, response);
			return;
		} else if ("delete".equals(type)) {
			int historyChked = Integer.parseInt(request.getParameter("historyChked"));
			System.out.println("get Attribte historyChked " + historyChked);

			if(historyChked != 0)
				ProfileDAO.delHistory_Img(historyChked);
				ProfileDAO.delHistory_pf(historyChked);
			
			//프로필 삭제후 
			request.getRequestDispatcher("profile_History.jsp").forward(request, response);
				
		}
			
		
		
	}
	
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> P_upload_controller doPost 실행");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
