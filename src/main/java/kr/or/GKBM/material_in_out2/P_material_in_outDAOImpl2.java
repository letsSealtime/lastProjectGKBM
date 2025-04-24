package kr.or.GKBM.material_in_out2;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.sku.P_skuDTO;









@Repository
public class P_material_in_outDAOImpl2 implements P_material_in_outDAO2{
	
	@Autowired
	SqlSession sqlSession;
	
	public List<P_material_in_outDTO2> fulltableList2_2(P_material_in_outDTO2 mioDTO2) {		
		
		
		List<P_material_in_outDTO2> result1 = sqlSession.selectList("gkbm.emp.fulltable_2_2", mioDTO2);		
		System.out.println("result1 : " + result1);
		return result1;
	}
	
	public int Count_2_2(P_material_in_outDTO2 mioDTO2) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_2", mioDTO2);
	}
	
			// 추가
			@Override
			public int addition_2_2(P_material_in_outDTO2 mioDTO2) {
				int dto = sqlSession.insert("gkbm.emp.addition_2_2", mioDTO2);
				return dto;
			}
			
			//삭제
			@Override
			public int delete_2_2(P_material_in_outDTO2 mioDTO2) {
				int dto = sqlSession.delete("gkbm.emp.delete_2_2", mioDTO2);
				return dto;
			}
			
			//수정
			@Override
			public int udpate_2_2(P_material_in_outDTO2 mioDTO2) {
				int countUpdate = sqlSession.update("gkbm.emp.udpate_2_2", mioDTO2);
				return countUpdate;
			}
	
}
