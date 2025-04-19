package kr.or.GKBM.Login;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class LoginDAOImpl implements LoginDAO{

	@Autowired
	SqlSession sqlSession;
	
	// 조회하는 쿼리문 연결
	@Override
	public List<LoginDTO> selectP_emp3(){
		List<LoginDTO> list = sqlSession.selectList("gkbm.emp.selectEmp_3");
		System.out.println("list : "+list);
		return list;
	}
	
	
}
