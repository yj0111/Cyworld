package com.mystudy.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.ImageFileVO;

public class ImageFileDAO {
	
	//프로필등록
	public static int insertImg (ImageFileVO ivo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("imageFile.insert", ivo);
		ss.close();
		return result;
	}
	
//1027 수정 >> 이미지 주소 보내주기
	public static String getImg (int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		ImageFileVO ivo = ss.selectOne("imageFile.getImgVO", userCode);
		ss.close();
		
		String pfImgSrc = "";
		if (ivo == null ) {
			pfImgSrc = "/CYWORLD/imgStorage/public/basic.jpg";
		} else {
			pfImgSrc = "/CYWORLD/imgStorage/"+ivo.getSysFilename();
		}
		return pfImgSrc;
	}
	
	// 프로필히스토리(이미지) 불러오기 
	public static List<ImageFileVO> getImgHistory (int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ImageFileVO> imgList = ss.selectList("imageFile.getImgHistory", userCode);
		
		return imgList;
	}
	
	
	

}

	
	

