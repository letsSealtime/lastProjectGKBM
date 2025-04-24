package kr.or.GKBM.material_in_out3;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.sku.P_skuDTO;









@Repository
public class P_material_in_outDAOImpl3 implements P_material_in_outDAO3{
	
	@Autowired
	SqlSession sqlSession;
	
	public List<P_material_in_outDTO3> fulltableList2_3(P_material_in_outDTO3 mioDTO3) {		
		
		
		List<P_material_in_outDTO3> result1 = sqlSession.selectList("gkbm.emp.fulltable_2_3", mioDTO3);		
		System.out.println("result1 : " + result1);
		return result1;
	}
	
	public int Count_2_3(P_material_in_outDTO3 mioDTO3) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_3", mioDTO3);
	}
	
		
	
}
