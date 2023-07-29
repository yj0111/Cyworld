package com.mystudy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.GuestBookVO;
import com.mystudy.vo.GuestBookViewVO;

public class GuestBookDAO {

	// 게시글(BBS)의 전체 건수 조회
	public static int getTotalCount(int visitHost) {
		
		SqlSession ss = DBService.getFactory().openSession();
		
		int totalCount = ss.selectOne("guest.totalCount", visitHost);
		ss.close();
		
		return totalCount;
	}
	
	// 페이지에 해당하는 글목록(게시글) 가져오기(조회)
	public static List<GuestBookViewVO> getList(int begin, int end) {
		
		Map<String, Integer> map = new HashMap<>();
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession();
		List<GuestBookViewVO> list = ss.selectList("guest.list", map);
		ss.close();
		
		return list;
	}
		
		
	public static List<GuestBookViewVO> getList(int visitHost, int begin, int end) {
		
		Map<String, Integer> map = new HashMap<>();
		map.put("begin", begin);
		map.put("end", end);
		map.put("visitHost", visitHost);
		
		SqlSession ss = DBService.getFactory().openSession();
		List<GuestBookViewVO> list = ss.selectList("guest.pageList", map);
		ss.close();
		
		return list;
	}

	public static int guestbookInsert(GuestBookVO guestbookVO) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("guest.insert", guestbookVO);
		ss.close();
		
		return result;
	}

	public static int delete(int guestCode) {
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("guest.delete", guestCode);
		ss.close();
		
		return result;
	}

	public static int updateAuthority(int visitHost, String authority) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("userCode", visitHost);
		map.put("authority", authority);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("guest.updateAuthority", map);
		ss.close();
		
		return result;
	}

}
