package kr.or.GKBM.work;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.GKBM.bill.BillDTO;

@Service
public class WorkServiceImpl implements WorkService {
	
	@Autowired
	WorkDAO dao;
	
	@Override
	public Map code_select(WorkDTO dto) {
		
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());
		
		Map map = dao.code_select(dto);
		
		double up = Math.round(dto.getPage() / 10);
		double down = Math.floor(dto.getPage() / 10);

		System.out.println("up: " + up);
		System.out.println("down: " + down);

		int page;
		if ((double) dto.getLine() / dto.getViewCount() > 0) {
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

		dto.setBegin((int) down);
		dto.setEnd((int) up);

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
