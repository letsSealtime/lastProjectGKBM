package kr.or.GKBM.board;

import java.util.List;


public interface BoardDAO {

//	List<BoardDTO> selectBoardList(BoardDTO boardDTO);
	// paging + select
	public List<BoardDTO> searchPageBoard(BoardDTO boardDTO);

	public int insertBoard(BoardDTO boardDTO);
	public int updateBoard(BoardDTO boardDTO);
	public int deleteBoard(BoardDTO boardDTO);
	public BoardDTO getBoardDetail(BoardDTO boardDTO);
	public int viewsUpdateBoard(BoardDTO boardDTO);
	public int countCommentForList(int board_id);
	
	int totalList();
	
	
}
