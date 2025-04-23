package kr.or.GKBM.work;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WorkDAOImpl implements WorkDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<WorkDTO> code_select() {
		
		List<WorkDTO> code_select = sqlSession.selectList("gkbm.emp.code_select");

		return code_select;		
	}
	
	@Override
	public List<WorkDTO> detail_select(WorkDTO dto) {
		
		List<WorkDTO> detail_select = sqlSession.selectList("gkbm.emp.detail_select", dto);

		return detail_select;	
	}
	
	@Override
	public List<WorkDTO> insert(WorkDTO dto) {
		
		List<WorkDTO> insert = sqlSession.selectList("gkbm.emp.insertWork", dto);

		return insert;	
	}
	
	@Override
	public List<WorkDTO> delete(WorkDTO dto) {
		
		List<WorkDTO> delete = sqlSession.selectList("gkbm.emp.deleteWork", dto);

		return delete;	
	}

}
