package com.mystudy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.FriendRequestVO;
import com.mystudy.vo.FriendVO;
import com.mystudy.vo.UserVO;


public class FriendDAO {

	public static List<FriendVO> getList(int userCode) {
		
		List<FriendVO> list = null;
		SqlSession ss = DBService.getFactory().openSession();
		list = ss.selectList("friend.getAll", userCode);
		ss.close();
		
		return list;
	}

	public static List<FriendVO> getFriendsByNameDAO(Map<String, Object> map) {
		
		List<FriendVO> list = null;
		SqlSession ss = DBService.getFactory().openSession();
		list = ss.selectList("friend.getAllByName", map);
		ss.close();
		
		return list;
	}

	public static List<UserVO> findUserByName(Map<String, Object> map) {
		
		List<UserVO> list = null;
		SqlSession ss = DBService.getFactory().openSession();
		list = ss.selectList("friend.getUsersByName", map);
		ss.close();
		
		return list;
	}
	
	public static List<UserVO> findUserById(Map<String, Object> map) {
		
		List<UserVO> list = null;
		SqlSession ss = DBService.getFactory().openSession();
		list = ss.selectList("friend.getUsersById", map);
		ss.close();
		
		return list;
	}

	public static int insertRequestDAO(Map<String, Object> map) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("friend.insertRequest", map);
		ss.close();
		
		return result;
	}

	public static List<FriendRequestVO> getRequestList(int userCode) {
		
		SqlSession ss = DBService.getFactory().openSession();
		List<FriendRequestVO> list = ss.selectList("friend.requestList", userCode);
		ss.close();
		
		return list;
	}

	public static int insertFriend(int userCode, int requesterCode) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", userCode);
		map.put("requesterCode", requesterCode);
		
		System.out.println("친구 추가 매퍼 : " + map);
		int result = ss.insert("friend.insertFriend", map);
		
		if (result <= 0) {
			System.err.println("친구 입력중 오류 발생.. 관리자 확인 요망");
			return -1;
		}
		
		map = new HashMap<>();
		map.put("userCode", requesterCode);
		map.put("requesterCode", userCode);
		
		
		result = ss.insert("friend.insertFriend", map);
		
		ss.close();
		
		return result;
	}

	public static int deleteRequest(int requestCode) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("friend.deleteRequest", requestCode);
		ss.close();
		
		return result;
	}

	public static int deleteFriend(int userCode, int opponentCode) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", userCode);
		map.put("opponentCode", opponentCode);
		int result = ss.delete("friend.deleteFriend", map);
		
		if (result <= 0) {
			System.err.println("친구 삭제도중 오류 발생.. 관리자 확인 요망");
			return -1;
		}
		
		map = new HashMap<>();
		map.put("userCode", opponentCode);
		map.put("opponentCode", userCode);
		
		result = ss.insert("friend.deleteFriend", map);
		
		
		ss.close();
		
		return result;
	}

	public static int rejectDAO(int requestCode) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("friend.deleteRequest", requestCode);
		ss.close();
		
		return result;
	}

	public static int updateFriendName(int friendCode, String text) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		
		Map<String, Object> map = new HashMap<>();
		map.put("friendCode", friendCode);
		map.put("text", text);
		int result = ss.update("friend.updateFriendName", map);
		
		ss.close();
				
		return result;
	}

	public static String checkFriend(int visitHost, int userCode) {
		
		SqlSession ss = DBService.getFactory().openSession();
		
		// 친구는 하나만 존재하므로 하나 찾으면 데이터베이스에서 탐색을 종료시키고 싶은데 방법이 없을까
		
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", userCode);
		map.put("visitHost", visitHost);
		
		int result = ss.selectOne("friend.checkFriend", map);
		
		if (result == 1) {
			return "yes";
		} else  return "no";
	}

}
