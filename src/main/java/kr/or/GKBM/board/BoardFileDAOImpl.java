package kr.or.GKBM.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardFileDAOImpl implements BoardFileDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertBoardFile(BoardFileDTO boardFileDTO) {
		int dto = sqlSession.insert("gkbm.emp.uploadBoardFile", boardFileDTO);
		return dto;
	}

	@Override
	public int deleteBoardFile(BoardFileDTO boardFileDTO) {
		int dto = sqlSession.delete("gkbm.emp.deleteFileByFileId", boardFileDTO);
		return dto;
	}

	@Override
	public List<BoardFileDTO> getFileById(int board_id) {
		List<BoardFileDTO> result = sqlSession.selectList("gkbm.emp.getFileById", board_id);
		return result;
	}
	
}
