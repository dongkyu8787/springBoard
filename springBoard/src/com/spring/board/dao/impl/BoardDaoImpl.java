package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(List<String> arrayParam, PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		int pageNo = pageVo.getPageNo();
		Map<String, Object> appn = new HashMap<String, Object>();
		appn.put("pageNo", pageNo);
		appn.put("arrayParam", arrayParam);
		return sqlSession.selectList("board.boardList",appn);
	}
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	@Override
	public List<CodeVo> comCode() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.ComCode");
	}
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	
	@Override
	public int SelectTypeCnt(List<String> arrayParam) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.typeTotal",arrayParam);
	}
	
	//USER
	
	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userLogin", userVo);
	}
	@Override
	public int userJoin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userJoin",userVo);
	}
	@Override
	public List<CodeVo> comPhone() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("user.ComPhone");
	}
	@Override
	public int idchk(String id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.idchk",id);
	}
	
	
	
}
