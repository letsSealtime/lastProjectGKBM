package kr.or.GKBM.board;

import java.util.List;
import java.util.Map;

public interface BoardService {

	public int updateBoard(BoardDTO boardDTO);
	public int insertBoard(BoardDTO boardDTO);
	public int deleteBoard(BoardDTO boardDTO);
	public int viewsUpdateBoard(BoardDTO boardDTO);
	
	public BoardDTO getBoardDetail(BoardDTO boardDTO);
	
	// 페이징
	public Map<String, Object> getBoardSearchList(BoardDTO boardDTO);
	
}
