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
	@Override
	public List<P_skuDTO> selectEmpList() {		
		
		
		List<P_skuDTO> result = sqlSession.selectList("gkbm.emp.selectEmp_2");		
		System.out.println("result : " + result);
		return result;
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
		
		//내가 원하는거 조회
		@Override
		public List<P_skuDTO> like(P_skuDTO skuDTO) {
			List<P_skuDTO> dto = sqlSession.selectList("gkbm.emp.selectBySkuId_2", skuDTO);
			return dto;
		}
	

}
