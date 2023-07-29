package com.mystudy.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.UserVO;


public class UserDAO {
	
	public static UserVO getUserInfoDAO (String id) {
		
		SqlSession ss = DBService.getFactory().openSession();
		UserVO vo = ss.selectOne("user.selectOne", id);
		
		ss.close();
		
		return vo;
	}

	public static UserVO getUserInfoByCodeDAO(int userCode) {
		
		SqlSession ss = DBService.getFactory().openSession();
		UserVO vo = ss.selectOne("user.selectOneByCode", userCode);
		ss.close();
		
		return vo;
	}
	
		//회원 가입
		public static int joinUser(UserVO vo) {
			SqlSession ss = DBService.getFactory().openSession(true);
			int result = ss.insert("user.insert", vo);
			ss.close();
			return result;
		}
			
		
		//아이디 찾기
		public static UserVO findId(String phone) {
			SqlSession ss = DBService.getFactory().openSession(true);
			UserVO uvo = ss.selectOne("user.findId", phone);
			ss.close();
			return uvo;
		}
		
		
		//비밀번호 찾기
		public static UserVO findPw(String phone) {
			SqlSession ss = DBService.getFactory().openSession(true);
			UserVO uvo = ss.selectOne("user.findPw", phone);
			ss.close();
			return uvo;
		}
		
	   // 회원 탈퇴
	   public static int leave(int userCode) {
	      SqlSession ss = DBService.getFactory().openSession(true);
	      int result = ss.delete("user.leave", userCode);
	      ss.close();
	      return result;
	   }

	   //회원 정보 수정
	public static int modifyUser(UserVO vo) {
			SqlSession ss = DBService.getFactory().openSession(true);
			int result = ss.update("user.modify", vo);
			ss.close();
			return result;
		} 
}
