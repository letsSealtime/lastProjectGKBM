package kr.or.GKBM.work_method;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Repository;





@Repository
public class P_work_methodDAOImpl implements P_work_methodDAO {

	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public List<P_work_methodDTO> fulltableList2_6(P_work_methodDTO wmDTO) {		
		
		
		List<P_work_methodDTO> result = sqlSession.selectList("gkbm.emp.fulltable_2_6", wmDTO);		
		System.out.println("result : " + result);
		return result;
	}
	
	
	public int Count_2_6(P_work_methodDTO wmDTO) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_6", wmDTO);
	}


	// 추가
		@Override
		public int addition_2_6(P_work_methodDTO wmDTO) {
			int dto = sqlSession.insert("gkbm.emp.addition_2_6", wmDTO);
			return dto;
		}
	
		// 삭제
		@Override
		public int delete_2_6(P_work_methodDTO wmDTO) {
			int dto = sqlSession.delete("gkbm.emp.delete_2_6", wmDTO);
			return dto;
		}
		
		
		// 수정
		@Override
		public int udpate_2_6(P_work_methodDTO wmDTO) {
			int countUpdate = sqlSession.update("gkbm.emp.udpate_2_6", wmDTO);
			return countUpdate;
		}
		
		

}
