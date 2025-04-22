package kr.or.GKBM.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public int insertBoard(BoardDTO boardDTO) {
		int dto = sqlSession.insert("gkbm.emp.insertBoard", boardDTO);
		return dto;
	}

	@Override
	public int updateBoard(BoardDTO boardDTO) {
		int countUpdate = sqlSession.update("gkbm.emp.udpateBoard", boardDTO);
		return countUpdate;
	}

	@Override
	public int deleteBoard(BoardDTO boardDTO) {
		int dto = sqlSession.update("gkbm.emp.deleteComment", boardDTO);
		return dto;
	}

	@Override
	public BoardDTO getBoardDetail(BoardDTO boardDTO) {
		BoardDTO dto = sqlSession.selectOne("gkbm.emp.getBoardDetail", boardDTO);
		return dto;
	}

	@Override
	public int viewsUpdateBoard(BoardDTO boardDTO) {
		int dto = sqlSession.update("gkbm.emp.viewsUpdateBoard", boardDTO);
		return dto;
	}

	@Override
	public List<BoardDTO> searchPageBoard(BoardDTO boardDTO) {
		List<BoardDTO> result = sqlSession.selectList("gkbm.emp.searchPageBoard", boardDTO);
		return result;
	}

	@Override
	public int totalList() {
		int result = sqlSession.selectOne("gkbm.emp.totalBoardPage");
		return result;
	}



}
