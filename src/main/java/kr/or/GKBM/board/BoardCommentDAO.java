package kr.or.GKBM.board;

import java.util.List;

public interface BoardCommentDAO {

	int insertComment(BoardCommentDTO commentDTO);
	int updateComment(BoardCommentDTO commentDTO);
	int deleteComment(BoardCommentDTO commentDTO);
	int checkCommentchildren(BoardCommentDTO commentDTO);
	
	List selectComment(BoardCommentDTO commentDTO);
	
	
}
