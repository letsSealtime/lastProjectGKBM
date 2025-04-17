package kr.or.GKBM.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public int updateBoard(BoardDTO boardDTO) {
		int countUpdate = boardDAO.updateBoard(boardDTO);
		return countUpdate;
	}

	@Override
	public int insertBoard(BoardDTO boardDTO) {
		int countUpdate = boardDAO.insertBoard(boardDTO);
		return countUpdate;
	}

	@Override
	public int deleteBoard(BoardDTO boardDTO) {
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

//	@Override
//	public void paging() {
//		
//		int idxStart = (viewCount * (page-1)) + 1;
//		
//	}

	@Override
	public Map<String, Object> getBoardSearchList(BoardDTO boardDTO) {
		
		int page = boardDTO.getPage();
		int viewCount = boardDTO.getViewCount();
		
		int indexStart = (viewCount * (page-1)) +1;
		int indexEnd = page * viewCount;
		
		boardDTO.setIndexStart(indexStart);
		boardDTO.setIndexEnd(indexEnd);
		
		// 한 페이지의 내용만 있는 리스트
		List<BoardDTO> list = boardDAO.selectBoardSearchList(boardDTO);
				
		// 전체 글 개수
		int total = boardDAO.totalList();
		
		Map<String, Object> map = new HashMap();
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}


}
