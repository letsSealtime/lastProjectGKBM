package kr.or.GKBM.board;

import java.util.List;

public interface BoardCommentDAO {

	int insertComment(BoardCommentDTO commentDTO);
	int updateComment(BoardCommentDTO commentDTO);
	int deleteComment(BoardCommentDTO commentDTO);
	int checkCommentchildren(BoardCommentDTO commentDTO);
	
	List<BoardCommentDTO> selectComment(int board_id);
	
	
}
