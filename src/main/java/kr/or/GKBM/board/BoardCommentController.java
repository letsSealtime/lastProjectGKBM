package kr.or.GKBM.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardCommentController {
	
	@Autowired
	BoardCommentDAO commentDAO;
	
	// CUD
	
	// insert
	@RequestMapping(value = "/comment_insert", method = { RequestMethod.POST })
	@ResponseBody
	public void commentInsert(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {
		
			int comment_id = commentDAO.insertComment(commentDTO);
			System.out.println("insert 결과" + comment_id);
	}
	
	// update
	@RequestMapping(value = "/comment_update", method = { RequestMethod.POST })
	@ResponseBody
	public void commentUpdate(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {
		
			int comment_id = commentDAO.updateComment(commentDTO);
			System.out.println("update 결과" + comment_id);
	}
	
	// delete
	@RequestMapping(value = "/comment_delete", method = { RequestMethod.POST })
	@ResponseBody
	public void deleteComment(@RequestBody BoardCommentDTO commentDTO) throws ServletException, IOException {
		
			int comment_id = commentDAO.deleteComment(commentDTO);
			System.out.println("delete 결과" + comment_id);
	}
	
	// 댓글 목록
	@RequestMapping(value="/comment_list", method = { RequestMethod.POST })
	@ResponseBody
	public List selectCommentList(@RequestBody BoardCommentDTO commentDTO) {
		List comment = commentDAO.selectComment(commentDTO);
		System.out.println("댓글 로딩 완료");
		return comment;
	}
}
