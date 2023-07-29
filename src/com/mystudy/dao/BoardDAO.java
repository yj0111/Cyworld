package com.mystudy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.BoardVO;

public class BoardDAO {
	
	//게시글 입력 
	public static int BoardInsert (BoardVO vo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("board.insert", vo);
		ss.close();
		return result;
	}
		
	//게시글 수정
	public static int update(BoardVO vo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("board.update", vo);
		ss.close();		
		return result;
	}
	
	//게시글 삭제
	public static int delete(int postCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("board.delete", postCode);
		ss.close();
		return result;
	}
	
	//게시판 전체 글 조회
	public static List<BoardVO> getList(int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<BoardVO> list = ss.selectList("board.selectAll", userCode);
		ss.close();
		return list;
	}
	
	//게시판 글 전체개수
	public static int getTotalCount(int userCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int totalCount = ss.selectOne("board.totalCount");
		ss.close();
		
		return totalCount;
	}
	
	//페이지에 해당하는 글목록(게시글) 가져오기(조회)
	public static List<BoardVO> getList(int userCode, int begin, int end) {
		Map<String, Integer> map = new HashMap<>();
		map.put("userCode", userCode);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<BoardVO> list = ss.selectList("board.list", map);
		ss.close();
		return list;
	}
	
	public static List<BoardVO> getList(Map<String, Integer> map) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<BoardVO> list = ss.selectList("board.list", map);
		ss.close();
		return list;
	}
	
	//글 하나씩 내용 보기 
	public static BoardVO selectOne(int postCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		BoardVO vo = ss.selectOne("board.one", postCode);
		ss.close();
		return vo;
	}
	
	//글 조회수 증가
	public static int updateHit(int postCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("board.hit", postCode);
		ss.close();
		return result;
	}
	
	
}
