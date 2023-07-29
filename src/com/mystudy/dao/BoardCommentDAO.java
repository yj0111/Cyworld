package com.mystudy.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.mybatis.DBService;
import com.mystudy.vo.BoardCommentVO;
import com.mystudy.vo.BoardVO;

public class BoardCommentDAO {

	//댓글 조회
	public static List<BoardCommentVO> commentList(int postCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<BoardCommentVO> list = ss.selectList("boardcomment.commentList", postCode);
		ss.close();
		return list;
	}	
	
	
	//댓글 입력 
	public static int BoardCommentInsert (BoardCommentVO vo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("boardcomment.insert", vo);
		ss.close();
		return result;
	}
	
	//댓글 삭제
	public static int BoardCommentDelete(int comCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("boardcomment.delete", comCode);
		ss.close();
		return result;
	}
	
	// 댓글 하나씩 
	public static BoardCommentVO BoardCommentselectOne(int comCode) {
		SqlSession ss = DBService.getFactory().openSession(true);
		BoardCommentVO vo = ss.selectOne("boardcomment.one", comCode);
		ss.close();
		return vo;
	}
	
}
