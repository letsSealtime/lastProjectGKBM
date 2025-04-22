package kr.or.GKBM.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardCommentDAOImpl implements BoardCommentDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertComment(BoardCommentDTO commentDTO) {
		int dto = sqlSession.insert("gkbm.emp.insertComment", commentDTO);
		return dto;
	}

	@Override
	public int updateComment(BoardCommentDTO commentDTO) {
		int dto = sqlSession.insert("gkbm.emp.updateComment", commentDTO);
		return dto;
	}

	@Override
	public int deleteComment(BoardCommentDTO commentDTO) {
		int dto = sqlSession.update("gkbm.emp.deleteComment", commentDTO);
		return dto;
	}

	@Override
	public List selectComment(BoardCommentDTO commentDTO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int checkCommentchildren(BoardCommentDTO commentDTO) {
		int result = sqlSession.selectOne("gkbm.emp.checkCommentchildren", commentDTO);
		return result;
	}

}
