package kr.or.GKBM.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public List<BoardDTO> getBoardList() {
		List list = boardDAO.selectBoardList();
		return list;
	}

	@Override
	public int updateEmp(BoardDTO boardDTO) {
		int countUpdate = boardDAO.updateBoard(boardDTO);
		return countUpdate;
	}

	@Override
	public int insertEmp(BoardDTO boardDTO) {
		int countUpdate = boardDAO.insertBoard(boardDTO);
		return countUpdate;
	}

	@Override
	public int deleteEmp(BoardDTO boardDTO) {
		int countUpdate = boardDAO.deleteBoard(boardDTO);
		return countUpdate;
	}

	@Override
	public BoardDTO getBoardDetail(BoardDTO boardDTO) {
		BoardDTO dto = boardDAO.getBoardDetail(boardDTO);
		return dto;
	}

	@Override
	public int viewsUpdateBoard(BoardDTO boardDTO) {
		int dto = boardDAO.viewsUpdateBoard(boardDTO);
		return dto;
	}

}
