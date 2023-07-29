package com.mystudy.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.PushVO;


public class PushDAO {

	public static int insertFriendReject(int userCode1, int userCode2) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userCode1", userCode1);
		map.put("userCode2", userCode2);
		map.put("content", "N");
		
		int result = ss.insert("push.insertFriendReject", map);
		ss.close();
		
		return result;
	}

	public static List<PushVO> getPushListDAO(int userCode) {
		
		SqlSession ss = DBService.getFactory().openSession();
		
		List<PushVO> list = new ArrayList<>();
		list = ss.selectList("push.pushList", userCode);
		
		ss.close();
		
		return list;
	}

	public static int newPushCheck(int userCode) {
		
		SqlSession ss = DBService.getFactory().openSession();
		
		int result = ss.selectOne("push.newPushCheck", userCode);
		
		ss.close();
		
		return result;
	}

	public static int insertFriendAccept(int userCode1, int userCode2) {

		SqlSession ss = DBService.getFactory().openSession(true);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userCode1", userCode1);
		map.put("userCode2", userCode2);
		map.put("content", "Y");
		
		int result = ss.insert("push.insertFriendAceept", map);
		ss.close();
		
		return result;
	}
	
}
