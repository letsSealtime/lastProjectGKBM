package kr.or.GKBM.product_in_out;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.sku.P_skuDTO;









@Repository
public class P_product_in_outDAOImpl implements P_product_in_outDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	public List<P_product_in_outDTO> fulltableList2_4(P_product_in_outDTO pioDTO) {		
		
		
		List<P_product_in_outDTO> result1 = sqlSession.selectList("gkbm.emp.fulltable_2_4", pioDTO);		
		System.out.println("result1 : " + result1);
		return result1;
	}
	
	public int Count_2_4(P_product_in_outDTO pioDTO) {
	    return sqlSession.selectOne("gkbm.emp.Count_2_4", pioDTO);
	}
	
			// 추가
			@Override
			public int addition_2_4(P_product_in_outDTO pioDTO) {
				int dto = sqlSession.insert("gkbm.emp.addition_2_4", pioDTO);
				return dto;
			}
			
			//삭제
			@Override
			public int delete_2_4(P_product_in_outDTO pioDTO) {
				int dto = sqlSession.delete("gkbm.emp.delete_2_4", pioDTO);
				return dto;
			}
			
			//수정
			@Override
			public int udpate_2_4(P_product_in_outDTO pioDTO) {
				int countUpdate = sqlSession.update("gkbm.emp.udpate_2_4", pioDTO);
				return countUpdate;
			}
	
}
