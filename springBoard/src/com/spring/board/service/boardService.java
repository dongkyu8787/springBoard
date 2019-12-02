package com.spring.board.service;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

public interface boardService {

	public String selectTest() throws Exception;
	
	public List<CodeVo> comCode() throws Exception;

	public List<BoardVo> SelectBoardList(List<String> arrayParam, PageVo pageVo) throws Exception;
	
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;
	
	public int selectTypeCnt(List<String> arrayParam) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(int boardNum,String boardType) throws Exception;
	
	//USER
	
	public UserVo userLogin(UserVo userVo) throws Exception;
	
	public int userJoin(UserVo userVo) throws Exception;
	
	public List<CodeVo> comPhone() throws Exception;

	public int idchk(String id) throws Exception;

}
