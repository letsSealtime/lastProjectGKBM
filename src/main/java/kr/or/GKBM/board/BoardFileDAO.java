package kr.or.GKBM.board;

import java.util.List;

public interface BoardFileDAO {

	public int insertBoardFile(BoardFileDTO boardFileDTO);
	public int deleteBoardFile(BoardFileDTO boardFileDTO);
	public List<BoardFileDTO> getFileById(int board_id);
}
