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
		int dto;
		
		if (commentDTO.getParent_id() == null) {
			// 댓글
			dto = sqlSession.insert("gkbm.emp.insertCommentParent", commentDTO);
			
		} else {
			// 답글
			dto = sqlSession.insert("gkbm.emp.insertCommentChild", commentDTO);
		}
		
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
	public List<BoardCommentDTO> selectComment(int board_id) {
		List<BoardCommentDTO> selectComment = sqlSession.selectList("gkbm.emp.selectCommentList", board_id);
		return selectComment;
	}

	@Override
	public int checkCommentchildren(BoardCommentDTO commentDTO) {
		int result = sqlSession.selectOne("gkbm.emp.checkCommentchildren", commentDTO);
		return result;
	}

}
