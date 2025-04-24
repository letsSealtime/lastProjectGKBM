package kr.or.GKBM.work;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WorkDAOImpl implements WorkDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Map code_select(WorkDTO dto) {
		
		Map map = new HashMap();
		
		List<WorkDTO> code_select = sqlSession.selectList("gkbm.emp.code_select");
		List<WorkDTO> select = sqlSession.selectList("gkbm.emp.select");
		
		map.put("code_select", code_select);
		map.put("select", select);

		return map;		
	}
	
	@Override
	public List<WorkDTO> detail_select(WorkDTO dto) {
		
		List<WorkDTO> detail_select = sqlSession.selectList("gkbm.emp.detail_select", dto);

		return detail_select;	
	}
	
	@Override
	public int insert(WorkDTO dto) {
		
		int insert = sqlSession.update("gkbm.emp.insertWork", dto);
		
		System.out.println("work insert행: " + insert);

		return insert;	
	}


}
