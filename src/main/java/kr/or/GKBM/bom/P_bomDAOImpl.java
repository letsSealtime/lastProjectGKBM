package kr.or.GKBM.bom;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Repository;







@Repository
public class P_bomDAOImpl implements P_bomDAO {

	@Autowired
	SqlSession sqlSession;
	
	
	
	
	@Override
	public List<P_bomDTO> fulltableList2_7(P_bomDTO bDTO) {		
		
		
		List<P_bomDTO> result = sqlSession.selectList("gkbm.emp.fulltable_2_7", bDTO);		
		System.out.println("result : " + result);
		return result;
	}
	
	
	public int Count_2_7(P_bomDTO bDTO) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_7", bDTO);
	}


	// 추가
		@Override
		public int addition_2_7(P_bomDTO bDTO) {
			int dto = sqlSession.insert("gkbm.emp.addition_2_7", bDTO);
			return dto;
		}
	
		// 삭제
		@Override
		public int delete_2_7(P_bomDTO bDTO) {
			int dto = sqlSession.delete("gkbm.emp.delete_2_7", bDTO);
			return dto;
		}
		
		
		// 수정
		@Override
		public int udpate_2_7(P_bomDTO bDTO) {
			int countUpdate = sqlSession.update("gkbm.emp.udpate_2_7", bDTO);
			return countUpdate;
		}
		
		
		

}
