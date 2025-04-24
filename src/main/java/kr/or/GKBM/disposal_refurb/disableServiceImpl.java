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
		
		List<disableDTO> select = sqlsession.selectList("gkbm.emp.disable", dto);
		
		return select;
		
	}
	
}
