package kr.or.GKBM.board;

import java.util.List;



public interface BoardService {

	List<BoardDTO> getBoardList();
	
	public int updateEmp(BoardDTO boardDTO);
	public int insertEmp(BoardDTO boardDTO);
	public int deleteEmp(BoardDTO boardDTO);
	
	public BoardDTO getBoardDetail(BoardDTO boardDTO);
	public int viewsUpdateBoard(BoardDTO boardDTO);
	
}
