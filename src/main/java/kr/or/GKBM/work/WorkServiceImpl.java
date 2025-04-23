package kr.or.GKBM.work;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkServiceImpl implements WorkService {
	
	@Autowired
	WorkDAO dao;
	
	@Override
	public Map code_select() {
		
		Map map = dao.code_select();

		return map;		
	}
	
	@Override
	public List<WorkDTO> detail_select(WorkDTO dto) {
		
		List<WorkDTO> detail_select = dao.detail_select(dto);

		return detail_select;
	}
	
	@Override
	public int insert(WorkDTO dto) {
		
		int insert = dao.insert(dto);

		return insert;
	}

}
