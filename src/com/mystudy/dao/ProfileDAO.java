package com.mystudy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.ProfileVO;

public class ProfileDAO {

	//profile 테이블에 게시글 등록(insert)
	public static int wrtProfile(ProfileVO pvo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result= ss.insert("profile.write", pvo);
		
		ss.close();
		return result;
	}
	
	//profile 테이블에서 게시글 번호 가져오기  - image_file 테이블등록용
	public static int getProCode(int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int profileCode = ss.selectOne("profile.getProcode", userCode);
		ss.close();
		return profileCode;
		
	}
	//Profile 전체 게시글  list에 담아오기
	public static List<ProfileVO> getProHistory(int userCode) {
		List<ProfileVO> list = null;
		SqlSession ss = DBService.getFactory().openSession(true);
		list = ss.selectList("profile.getProHistory", userCode);
		
		ss.close();
		
		return list;
	}
	
	//profile 테이블에서 게시글 가져오기
	public static ProfileVO rcntProfile(int userCode) {
		System.out.println("[profileDAO get] : " + userCode);
		
		boolean result;
		SqlSession ss = DBService.getFactory().openSession(true);
		ProfileVO pvo = ss.selectOne("profile.rcntProfile", userCode);		
		ss.close();
		
		if (pvo == null ) {
			ProfileVO proVo = new ProfileVO();
			proVo.setContent("상태메시지가 없습니다.");
			pvo = proVo;
		}
		return pvo;
	}
	
	
	//(페이징) 프로필 게시글 전체번호
	public static int getProNum (int userCode) {
		System.out.println("[profileDAO get] : " + userCode);
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.selectOne("profile.getProNum", userCode); 
		return result;
	}
	
// 수정함!!
	//(페이징) 페이지에 해당하는 글 번호 
	public static List<ProfileVO> getPageList(int userCode, int begin, int end) {
		System.out.println("[profileDAO userProfile list usercode] : " + userCode);
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", userCode);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ProfileVO> list = ss.selectList("profile.getPageList", map); //실행시킬 sql(mapper), 전달할데이터
		ss.close();
		
		System.out.println("[profileDAO] 프로필 list사이즈 : " + list.size());

		return list;
	}
	
	//히스토리 삭제 - 이미지
		public static int delHistory_Img (int profileCode) {
			SqlSession ss = DBService.getFactory().openSession(true);
			int result = ss.delete("profile.delHistory_Img", profileCode);
			ss.close();
			return result;
		}
		//히스토리 profile 테이블에서 삭제
		public static int delHistory_pf (int profileCode) {
			SqlSession ss = DBService.getFactory().openSession(true);
			int result = ss.delete("profile.delHistory_pf", profileCode);
			ss.close();
			return result;
		}
}
