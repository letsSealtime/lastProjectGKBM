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
	public List<BoardDTO> selectBoardList() {
		List<BoardDTO> result = sqlSession.selectList("mapper.gkbm.emp.board.selectBoardList");
		System.out.println("result : " + result);
		return result;
	}

	@Override
	public int insertBoard(BoardDTO boardDTO) {
		int dto = sqlSession.insert("mapper.gkbm.emp.board.insertBoard", boardDTO);
		return dto;
	}

	@Override
	public int updateBoard(BoardDTO boardDTO) {
		int countUpdate = sqlSession.update("mapper.gkbm.emp.board.udpateBoard", boardDTO);
		return countUpdate;
	}

	@Override
	public int deleteBoard(BoardDTO boardDTO) {
		int dto = sqlSession.delete("mapper.gkbm.emp.board.deleteBoard", boardDTO);
		return dto;
	}

	@Override
	public BoardDTO getBoardDetail(BoardDTO boardDTO) {
		BoardDTO dto = sqlSession.selectOne("mapper.gkbm.emp.board.getBoardDetail", boardDTO);
		return dto;
	}

	@Override
	public int viewsUpdateBoard(BoardDTO boardDTO) {
		int dto = sqlSession.update("mapper.gkbm.emp.board.viewsUpdateBoard", boardDTO);
		return dto;
	}

}
