package com.mystudy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.FriendCommVO;

public class FriendCommDAO {

	//친구평 불러오기 
	public static List<FriendCommVO> viewFriendComm (int visitHost) {		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<FriendCommVO> list = ss.selectList("friend.viewFriendComm", visitHost);
		ss.close();
		return list ;
	}
		
	//친구평 등록
	public static int wrtFriendComm (FriendCommVO fvo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result= ss.insert("friend.wrtFriendComm", fvo);
		ss.close();
		return result;
		
	}
	
	//친구평 삭제
	public static int delFriendComm(int friendCommCode) {		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result= ss.delete("friend.delFriendComm", friendCommCode);
		ss.close();
		
		System.out.println("삭제 갯수 : " + result);
		return result;
	}
	
	//친구평 삭제
	
}
