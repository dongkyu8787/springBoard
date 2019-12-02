package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//@RequestParam( required = false) : 처음 들어갈때 값이 없기 때문에  지정해줘야 한다. 
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo
			,@RequestParam( required = false) List<String> arrayParam
			,UserVo userVo, HttpSession session) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		int page = 1;
		int totalCnt = 0;
		
		codeList = boardService.comCode();
		
		 if(arrayParam == null) {
			if(pageVo.getPageNo() == 0){
				pageVo.setPageNo(page);
			}
			boardList = boardService.SelectBoardList(arrayParam,pageVo);
			totalCnt = boardService.selectBoardCnt();
		
		  }else { 
			  pageVo.setPageNo(page); 
		  boardList = boardService.SelectBoardList( arrayParam, pageVo); 
		  totalCnt = boardService.selectTypeCnt(arrayParam); 
		  }
		
		 session.setAttribute("userInfo", userVo);
		 model.addAttribute("user", userVo);
		model.addAttribute("arrayParam", arrayParam);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("codeList", codeList);
		
		return "board/boardList";
	}
	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardUpdate";
	}
	@RequestMapping(value = "/board/boardUpdateres.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateres(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardDelete.do")
	@ResponseBody
	public String boardDelete(Locale locale,BoardVo boardVo) throws Exception{

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int deleteres = boardService.boardDelete(boardVo.getBoardNum(), boardVo.getBoardType());
		 
		 result.put("success", (deleteres > 0)?"Y":"N");
			String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
			
			System.out.println("callbackMsg::"+callbackMsg);
			
			return callbackMsg;
	
	}
	//USER
	
	@RequestMapping(value = "/board/loginPage.do")
	public String login () throws Exception {
		
		return "board/loginPage";
		
	}
	@RequestMapping(value = "/board/joinPage.do")
	public String join (Locale locale, Model model) throws Exception {
		
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		
		codeList = boardService.comPhone();
		
		model.addAttribute("codeList", codeList);
		
		return "board/joinPage";
		
	}
	@RequestMapping(value = "/board/joinInsert.do")
	@ResponseBody
	public String joinres(Locale locale,UserVo userVo) throws Exception{

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int joinres = boardService.userJoin(userVo);
		 
		 result.put("success", (joinres > 0)?"Y":"N");
			String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
			
			System.out.println("callbackMsg::"+callbackMsg);
			
			return callbackMsg;
	
	}
	@RequestMapping(value = "/board/idchk.do",method = RequestMethod.GET )
	@ResponseBody
	public int idchk(String id) throws Exception{
		return boardService.idchk(id);
	}
	
	@RequestMapping(value = "/board/loginres.do",method = {RequestMethod.POST,RequestMethod.GET} )
	@ResponseBody
	public String loginres (Locale locale,UserVo userVo, HttpSession session) throws Exception{

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		if( boardService.userLogin(userVo) != null) {
			 result.put("success", "Y");
			 
			 session.setAttribute("userInfo", userVo);
			 
		}else {
			result.put("success", "N");
			
		}
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
		 
		
	}
	@RequestMapping(value = "/board/logout.do")
	public String logout(Locale locale, HttpSession session) throws Exception{
		
		session.removeAttribute("userInfo");
		
		return "redirect:/board/boardList.do";
	}
}


