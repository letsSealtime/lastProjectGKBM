package kr.or.GKBM.board;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class BoardController {

	@Autowired
	BoardDAO boardDAO;

	@Autowired
	BoardService boardService;

	@Autowired
	BoardFileDAO boardFileDAO;
	
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
	@RequestMapping(value = "/board_update", method = { RequestMethod.POST })
	@ResponseBody
	public int updateBoard(@RequestBody BoardDTO boardDTO) throws ServletException, IOException {

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
	@RequestMapping(value = "/board_insert", method = { RequestMethod.POST })
	@ResponseBody
	public int insertBoard(@RequestBody BoardDTO boardDTO) throws ServletException, IOException {

		int insert = boardDAO.insertBoard(boardDTO);
		System.out.println("insert 결과" + insert);

		// 전체목록으로 리턴
		return insert;
	}

	// 파일 등록
	@RequestMapping("/uploads")
	public String uploadFile(MultipartHttpServletRequest req) throws UnsupportedEncodingException {
		req.setCharacterEncoding("utf-8");

		List<MultipartFile> fileList = req.getFiles("files");

		for (MultipartFile mf : fileList) {

			long fileSize = mf.getSize();
			System.out.println("(Ctr)fileSize : " + fileSize);

			String fileName = mf.getOriginalFilename();
			System.out.println("(Ctr)fileName : " + fileName);

			try {
				String path = "C:\\temp\\upload";
				String safeFileName = path + "\\" + System.currentTimeMillis() + "_" + fileName;
				System.out.println("safeFileName : " + safeFileName);
				File file = new File(safeFileName);

				mf.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "upload_success";
	}

	@RequestMapping("/uploads/update")
	public String updateFile(MultipartHttpServletRequest req,
			@RequestParam(value = "deleteFileIds", required = false) List<Integer> deleteFileIds)
			throws UnsupportedEncodingException {
		
		req.setCharacterEncoding("utf-8");

		// 기존 파일 처리
		String board_id = req.getParameter("board_id");
		System.out.println("(Ctr)파일 업뎃한 게시글 ID: " + board_id);

		if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
			for (Integer file_id : deleteFileIds) {
				System.out.println("(Ctr) 삭제 파일 ID : " + file_id);
				
				BoardFileDTO boardFileDTO = new BoardFileDTO();
				boardFileDTO.setFile_id(file_id);
				
				int deleteFile = boardFileDAO.deleteBoardFile(boardFileDTO);
			}
		}

		// 새로운 파일 업로드
		List<MultipartFile> fileList = req.getFiles("files");

		for (MultipartFile mf : fileList) {

			long fileSize = mf.getSize();
			System.out.println("(Ctr)수정 중 업로드된 fileSize : " + fileSize);

			String fileName = mf.getOriginalFilename();
			System.out.println("(Ctr)수정 중 업로드된 fileName : " + fileName);

			try {
				String path = "C:\\temp\\upload";
				String safeFileName = path + "\\" + System.currentTimeMillis() + "_" + fileName;
				System.out.println("safeFileName : " + safeFileName);
				File file = new File(safeFileName);

				mf.transferTo(file);
				
			    BoardFileDTO boardFileDTO = new BoardFileDTO();
			    boardFileDTO.setBoard_id(Integer.parseInt(board_id)); 
			    boardFileDTO.setFile_name(fileName);
			    boardFileDTO.setFile_path(safeFileName);
			    
				int updateFile = boardFileDAO.insertBoardFile(boardFileDTO);
						
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "upload_success";
	}

}
