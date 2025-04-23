package kr.or.GKBM.work;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkServiceImpl implements WorkService {
	
	@Autowired
	WorkDAO dao;
	
	@Override
	public List<WorkDTO> code_select() {
		
		List<WorkDTO> code_select = dao.code_select();

		return code_select;		
	}
	
	@Override
	public List<WorkDTO> detail_select(WorkDTO dto) {
		
		List<WorkDTO> detail_select = dao.detail_select(dto);

		return detail_select;
	}
	
	@Override
	public List<WorkDTO> insert(WorkDTO dto) {
		
		List<WorkDTO> insert = dao.insert(dto);

		return insert;
	}
	
	@Override
	public List<WorkDTO> delete(WorkDTO dto) {
		
		List<WorkDTO> delete = dao.delete(dto);

		return delete;
	}

}
