package kr.or.GKBM.defect;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.GKBM.work.WorkDTO;

@Service
public class DefectServiceImpl implements DefectService {
	
	@Autowired
	DefectDAO dao;
	
	@Override
	public List<DefectDTO> code_select(DefectDTO dto) {
		
		List<DefectDTO> code_select = dao.code_select(dto);

		return code_select;		
	}
	
	@Override
	public int insert(DefectDTO dto) {
		int insert = dao.insert(dto);

		return insert;
	}
	
	

}
