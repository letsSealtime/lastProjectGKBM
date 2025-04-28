package kr.or.GKBM.material_in_out;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;







@Repository
public class P_material_in_outDAOImpl implements P_material_in_outDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	public List<P_material_in_outDTO> fulltableList2_1(P_material_in_outDTO mioDTO) {		
		
		
		List<P_material_in_outDTO> result1 = sqlSession.selectList("gkbm.emp.fulltable_2_1", mioDTO);		
		System.out.println("result1 : " + result1);
		return result1;
	}
	
	public int Count_2_1(P_material_in_outDTO mioDTO) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_1", mioDTO);
	}
	
			// 추가
			@Override
			public int addition_2_1(P_material_in_outDTO mioDTO) {
				int dto = sqlSession.insert("gkbm.emp.addition_2_1", mioDTO);
				return dto;
			}
			
			//삭제
			@Override
			public int delete_2_1(P_material_in_outDTO mioDTO) {
				int dto = sqlSession.delete("gkbm.emp.delete_2_1", mioDTO);
				return dto;
			}
	
			//수정
			@Override
			public int udpate_2_1(P_material_in_outDTO mioDTO) {
				int countUpdate = sqlSession.update("gkbm.emp.udpate_2_1", mioDTO);
				return countUpdate;
			}
	
			
			
			
			
}
