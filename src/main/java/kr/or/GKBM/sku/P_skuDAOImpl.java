package kr.or.GKBM.sku;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;





@Repository
public class P_skuDAOImpl implements P_skuDAO {

	@Autowired
	SqlSession sqlSession;
	
	// emp.xml에서 가져온 전체페이지
	// 목록 조회용
	@Override
	public List<P_skuDTO> fulltableList(P_skuDTO skuDTO) {		
		
		
		List<P_skuDTO> result = sqlSession.selectList("gkbm.emp.fulltable_2", skuDTO);		
		System.out.println("result : " + result);
		return result;
	}
	
	//총 개수 계산용
	public int Count(P_skuDTO skuDTO) {
	    return sqlSession.selectOne("gkbm.emp.Count_2", skuDTO);
	}


	// emp.xml에서 가져온 것으로 등록
		@Override
		public int addition(P_skuDTO skuDTO) {
			int dto = sqlSession.insert("gkbm.emp.addition_2", skuDTO);
			return dto;
		}
	
		// emp.xml에서 가져온 삭제
		@Override
		public int delete(P_skuDTO skuDTO) {
			int dto = sqlSession.delete("gkbm.emp.delete_2", skuDTO);
			return dto;
		}
		
		
		//emp.xml에서 가져온 수정
		@Override
		public int udpate(P_skuDTO skuDTO) {
			int countUpdate = sqlSession.update("gkbm.emp.udpate_2", skuDTO);
			return countUpdate;
		}
		
		

}
