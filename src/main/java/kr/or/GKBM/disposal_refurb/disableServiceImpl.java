package kr.or.GKBM.disposal_refurb;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

@Service
public class disableServiceImpl implements disableService {

	@Autowired
	SqlSession sqlsession;
	
	@Override
	public List<disableDTO> select(disableDTO dto) {
		
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());
		
		List<disableDTO> select = sqlsession.selectList("gkbm.emp.disable", dto);
		
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
		
		return select;
		
	}
	
}
