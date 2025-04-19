package kr.or.GKBM.board;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardController {

	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	BoardService boardService;

	// 목록 + 검색
	@RequestMapping(value = "/board")
	public String SelectBoardList(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		Map<String, Object> map = boardService.getBoardSearchList(boardDTO);
		model.addAttribute("map", map);
		model.addAttribute("dto", boardDTO);
		
		return "board";

	}

	// 상세 보기
	@RequestMapping(value = "/board_detail", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBoardDetail(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// 조회수 증가
		boardDAO.viewsUpdateBoard(boardDTO);

		// 상세 보기
		BoardDTO select = boardDAO.getBoardDetail(boardDTO);
		System.out.println("detail : " + select);
		model.addAttribute("board", select);

		return "board_detail";
	}

	// 수정 화면으로
	@RequestMapping(value = "board_modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardModify(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// EmpDTO 추가되면, 로그인 구현해야 한다.
		
		boardDTO = boardDAO.getBoardDetail(boardDTO);
		model.addAttribute("boardDTO", boardDTO);
		return "board_form";

	}

	// 수정
	@RequestMapping(value = "/board_update", method = {RequestMethod.POST})
	@ResponseBody
	public int updateBoard(
			@RequestBody
			BoardDTO boardDTO) throws ServletException, IOException {

		int update = boardDAO.updateBoard(boardDTO);
		System.out.println("update 결과" + update);

		// 전체목록으로 리턴
		return update;
	}

	// 삭제
	@RequestMapping(value = "/board_delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteBoard(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int delete = boardDAO.deleteBoard(boardDTO);
		System.out.println("delete 결과" + delete);

		// 전체목록으로 리턴
		return "redirect:board";
	}

	// 새글 작성으로 이동
	@RequestMapping(value = "/board_form", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardForm(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		return "board_form";
	}

	// 새 글
	
	@RequestMapping(value = "/board_insert", method = {RequestMethod.POST})
	@ResponseBody
	public int insertBoard(
			@RequestBody
			BoardDTO boardDTO) throws ServletException, IOException {

		int insert = boardDAO.insertBoard(boardDTO);
		System.out.println("insert 결과" + insert);

		// 전체목록으로 리턴
		return insert;
	}
	

	// 페이지 메소드
	// 검색

}
