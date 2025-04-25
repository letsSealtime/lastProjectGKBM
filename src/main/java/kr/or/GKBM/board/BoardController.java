package kr.or.GKBM.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
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

		return "board.tiles";

	}

	// 상세 보기
	@RequestMapping(value = "/board_detail", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBoardDetail(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		int board_id = Integer.parseInt(request.getParameter("board_id"));
		
		// 조회수 증가
		boardDAO.viewsUpdateBoard(boardDTO);

		// 상세 보기
		BoardDTO select = boardDAO.getBoardDetail(boardDTO);
		
		// 파일
		List<BoardFileDTO> fileList = boardFileDAO.getFileById(board_id);
		
		System.out.println("detail : " + select);
		model.addAttribute("board", select);
		model.addAttribute("fileList", fileList);

		return "board_detail.tiles";
	}

	// 수정 화면으로
	@RequestMapping(value = "board_modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardModify(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// EmpDTO 추가되면, 로그인 구현해야 한다.
		boardDTO = boardDAO.getBoardDetail(boardDTO);
		model.addAttribute("boardDTO", boardDTO);
		
		int board_id = boardDTO.getBoard_id();
		List<BoardFileDTO> fileList = boardFileDAO.getFileById(board_id);
		model.addAttribute("fileList", fileList);
		
		return "board_form.tiles";

	}
	
	// 파일 다운로드
	@RequestMapping(value = "/fileDownload", method = { RequestMethod.GET, RequestMethod.POST })
	public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String fileName = request.getParameter("file_name");
		String path = "C:\\temp\\upload";
		File file = new File(path + "\\" + fileName);
		
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + fileName);

		// 파일 읽기
		FileInputStream fis = new FileInputStream(file);
		// 메모리로 퍼 올릴 바가지 크기 설정
		byte[] buf = new byte[1024 * 1]; // 보통은 8kB

		OutputStream os = response.getOutputStream();

		int count = -1;
		while ((count = fis.read(buf)) != -1) {
			os.write(buf, 0, count);
		}
		os.flush();
		os.close();
		fis.close();
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
		return "redirect:board.tiles";
	}

	// 새글 작성으로 이동
	@RequestMapping(value = "/board_form", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardForm(@ModelAttribute BoardDTO boardDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		return "board_form.tiles";
	}

	// 새 글
	@RequestMapping(value = "/board_insert", method = { RequestMethod.POST })
	@ResponseBody
	public int insertBoard(@RequestBody BoardDTO boardDTO) throws ServletException, IOException {

		int board_id = boardService.insertBoard(boardDTO);
		System.out.println("insert 결과" + board_id);

		// 전체목록으로 리턴
		return board_id;
	}

	// 파일 등록
	@RequestMapping("/uploads")
	public String uploadFile(MultipartHttpServletRequest req) throws UnsupportedEncodingException {
		req.setCharacterEncoding("utf-8");
		
		String boardIdStr = req.getParameter("board_id");
		int boardId = (boardIdStr != null && !boardIdStr.isEmpty()) ? Integer.parseInt(boardIdStr) : 0;
		
		List<MultipartFile> fileList = req.getFiles("files");

		for (MultipartFile mf : fileList) {

			long fileSize = mf.getSize();
			String fileName = mf.getOriginalFilename();

			try {
				String path = "C:\\temp\\upload";
				String safeFileName = System.currentTimeMillis() + "_" + fileName;
				System.out.println("safeFileName : " + safeFileName);

				String filePath = path + "\\" + safeFileName;
				File file = new File(filePath);
				mf.transferTo(file);
				
				BoardFileDTO boardFileDTO = new BoardFileDTO();
				boardFileDTO.setBoard_id(boardId);
	            boardFileDTO.setFile_name(safeFileName);
	            boardFileDTO.setFile_path(filePath);
	            
	            boardFileDAO.insertBoardFile(boardFileDTO);
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "redirect:/board.tiles";
	}

	// 파일 수정 - 업로드
	@RequestMapping("/uploads/update")
	public String updateFile(MultipartHttpServletRequest req,
			@RequestParam(value = "deleteFileIds", required = false) List<Integer> deleteFileIds)
			throws UnsupportedEncodingException {
		
		req.setCharacterEncoding("utf-8");

		// board_id 먼저 체크
		 String boardIdStr = req.getParameter("board_id");
		    if (boardIdStr == null || boardIdStr.trim().isEmpty()) {
		        System.err.println("파일 없음 → 나가시오");
		        return "redirect:/board";
		    }
		    int board_id = Integer.parseInt(boardIdStr);
		    System.out.println("(Ctr)파일 업뎃한 게시글 ID: " + board_id);
		
		    // 기존 파일 삭제
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
			
			 if (mf.isEmpty() || mf.getOriginalFilename() == null || mf.getOriginalFilename().trim().isEmpty()) {
			        continue;
			    }

			long fileSize = mf.getSize();
			System.out.println("(Ctr)수정 중 업로드된 fileSize : " + fileSize);

			String fileName = mf.getOriginalFilename();
			System.out.println("(Ctr)수정 중 업로드된 fileName : " + fileName);

			try {
				String path = "C:\\temp\\upload";
				String safeFileName = System.currentTimeMillis() + "_" + fileName;
				
				System.out.println("safeFileName : " + safeFileName);
				
				String filePath = path + "\\" + safeFileName;
				File file = new File(filePath);
				mf.transferTo(file);

				BoardFileDTO boardFileDTO = new BoardFileDTO();
			    boardFileDTO.setBoard_id(board_id); 
	            boardFileDTO.setFile_name(safeFileName);
	            boardFileDTO.setFile_path(filePath);
			    
				boardFileDAO.insertBoardFile(boardFileDTO);
						
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "redirect:/board.tiles";
	}

}
