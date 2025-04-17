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
	public List<BoardDTO> selectBoardList(BoardDTO boardDTO) {
		List<BoardDTO> result = sqlSession.selectList("gkbm.emp.selectBoardList");
		System.out.println("result : " + result);
		return result;
	}
	
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
		int dto = sqlSession.delete("gkbm.emp.deleteBoard", boardDTO);
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
	public List<BoardDTO> selectBoardSearchList(BoardDTO boardDTO) {
		List<BoardDTO> result = sqlSession.selectList("gkbm.emp.selectPageBoard", boardDTO);
		System.out.println("페이징 결과 : " + result);
		return result;
	}

	@Override
	public int totalList() {
		int result = sqlSession.selectOne("gkbm.emp.totalBoardPage");
		System.out.println("count(*) : "+ result);
		return result;
	}



}
