package kr.or.GKBM.memberJoin;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	SqlSession sqlsession;
	
	@Override
	public int insert(memberDTO dto) {
		
		int value = sqlsession.insert("gkbm.emp.memberjoin", dto);
		
		return value;
	}
	
}
