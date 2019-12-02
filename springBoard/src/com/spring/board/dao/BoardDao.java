package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(List<String> arrayParam, PageVo pageVo) throws Exception;
	
	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;

	public int SelectTypeCnt(List<String> arrayParam) throws Exception;
	
	public List<CodeVo> comCode() throws Exception;
	
	//USER
	
	public UserVo userLogin(UserVo userVo) throws Exception;
	
	public int userJoin(UserVo userVo) throws Exception;
	
	public List<CodeVo> comPhone() throws Exception;

	public int idchk(String id)throws Exception;

}
