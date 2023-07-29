package com.mystudy.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.HomeStateVO;
import com.mystudy.vo.UserVO;

public class HomeStateDAO {
	static int total ;
	// 가입시 미니홈피상태 기본값입력
	public static int createHomeState (int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		UserVO uvo = UserDAO.getUserInfoByCodeDAO(userCode);
		System.out.println("[홈페이지 정보] : " + uvo);
		
		HomeStateVO HSvo = new HomeStateVO();
		
		String homename = uvo.getName() + "님의 미니홈피";
		HSvo.setUserCode(userCode);
		HSvo.setHomeName(homename);
		HSvo.setToday(0);
		HSvo.setTotal(0);
		System.out.println("HSVO : " + HSvo);
		
		int result = ss.insert("homeState.insert", HSvo);
		ss.close();
		
		return result;
	}
	
	// 현재 미니홈피 상태 가져오기
	public static HomeStateVO getHomeState (int visitHost) {
		SqlSession ss = DBService.getFactory().openSession(true);
		HomeStateVO HSvo = ss.selectOne("homeState.now", visitHost);
		ss.close();
		return HSvo;
	}
	
	// 미니홈피 제목변경시
	public static void updateHomeName (int visitHost, String homeName) {
		String userCode = Integer.toString(visitHost);
		Map<String, String> map = new HashMap<String, String>();
		map.put("userCode", userCode);
		map.put("homeName", homeName);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		ss.update("homeState.updateHomeName", map);
		ss.close();
	}
	
	
	// 방문시 마다 투데이변경
	public static int updateToday (int visitHost) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("homeState.updateToday", visitHost);
		ss.close();
		return result;	
	}
	
	// 방문시 마다 토탈 변경
	public static int updateTotal (int visitHost, int today) {
		HomeStateVO HSvo = getHomeState(visitHost);
		total = HSvo.getTotal();
		total += today;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", visitHost);
		map.put("total", total);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("homeState.updateTotal", map);
		ss.close();	
		
		return result;
	}
	
}
