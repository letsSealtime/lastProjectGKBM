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
		
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());
		
		List<DefectDTO> code_select = dao.code_select(dto);
		
		double up = Math.round(dto.getPage() / 10);
		double down = Math.floor(dto.getPage() / 10);

		System.out.println("up: " + up);
		System.out.println("down: " + down);
		
		System.out.println(dto.getLine());
		System.out.println(dto.getViewCount());

		int page;
		if ((double) dto.getLine() % dto.getViewCount() > 0) {
			page = (dto.getLine() / dto.getViewCount()) + 1;
		} else {
			page = (dto.getLine() / dto.getViewCount());
		}

		if (up == down) {
			up = ((up * 10) + dto.getViewCount());
			down = (down * 10) + 1;
			if (up > page) {
				up = page;
			}
		} else {
			down = (down * 10) + 1;
		}
		
		System.out.println(down);
		System.out.println(page);

		dto.setBegin((int) down);
		dto.setEnd((int) up);
		
		System.out.println(dto.getBegin());
		System.out.println(dto.getEnd());

		return code_select;		
	}
	
	@Override
	public int insert(DefectDTO dto) {
		int insert = dao.insert(dto);

		return insert;
	}
	
	

}
