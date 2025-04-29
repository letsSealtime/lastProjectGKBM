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
		boardDAO.insertBoard(boardDTO);
		return boardDTO.getBoard_id();
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

	

	@Override
	public Map<String, Object> getBoardSearchList(BoardDTO boardDTO) {
		if("writer".equals(boardDTO.getType())) {
				String writer = boardDTO.getKeyword();
				boardDTO.setWriter(writer);
				} else if(boardDTO.getType() != null && boardDTO.getType().equals("title")) {
					try {
						String title = boardDTO.getKeyword();
						boardDTO.setTitle( title );
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else if(boardDTO.getType() != null && boardDTO.getType().equals("board_content")) {
					try {
						String board_content = boardDTO.getBoard_content();
						boardDTO.setBoard_content( board_content );
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
		
		int page = boardDTO.getPage();
		int viewCount = boardDTO.getViewCount();
		
		int indexStart = (viewCount * (page-1)) +1;
		int indexEnd = page * viewCount;
		
		boardDTO.setIndexStart(indexStart);
		boardDTO.setIndexEnd(indexEnd);
		
		// 한 페이지의 내용만 있는 리스트
		List<BoardDTO> list = boardDAO.searchPageBoard(boardDTO);
				
		// 덧글 개수
		for(BoardDTO dto : list) {
			int commentCount = boardDAO.countCommentForList(dto.getBoard_id());
			dto.setCommentCount(commentCount);
		}
		
		// 전체 글 개수
		int total = boardDAO.totalList();
		
		Map<String, Object> map = new HashMap();
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}


}
