package kr.or.GKBM.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardCommentController {

	@Autowired
	BoardCommentDAO commentDAO;

	// CUD

	// insert
	@RequestMapping(value = "/comment_insert", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int commentInsert(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {

		int result = commentDAO.insertComment(commentDTO);
		System.out.println("insert 결과" + result);
		return result;
	}

	// update
	@RequestMapping(value = "/comment_update", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int commentUpdate(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {

		int result = commentDAO.updateComment(commentDTO);
		System.out.println("update 결과" + result);
		return result;
	}

	// delete
	@RequestMapping(value = "/comment_delete", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int deleteComment(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {

		int result = commentDAO.deleteComment(commentDTO);
		System.out.println("delete 결과" + result);
		return result;
	}

	// 댓글 목록
	@RequestMapping(value = "/comment_list", method = { RequestMethod.GET })
	@ResponseBody
	public List<BoardCommentDTO> selectCommentList(
			@RequestParam(value = "board_id", required = false) String boardIdStr) {
		int boardId = 0;
		if (boardIdStr != null && !boardIdStr.trim().isEmpty()) {
			boardId = Integer.parseInt(boardIdStr.trim());
		}

		List<BoardCommentDTO> commentList = commentDAO.selectComment(boardId);
		return commentList;
	}

}
