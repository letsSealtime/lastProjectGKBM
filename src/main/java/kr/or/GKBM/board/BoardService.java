package kr.or.GKBM.board;

import java.util.List;



public interface BoardService {

	public int updateBoard(BoardDTO boardDTO);
	public int insertBoard(BoardDTO boardDTO);
	public int deleteBoard(BoardDTO boardDTO);
	public int viewsUpdateBoard(BoardDTO boardDTO);
	
	public BoardDTO getBoardDetail(BoardDTO boardDTO);
	
}
