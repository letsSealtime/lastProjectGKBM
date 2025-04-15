package kr.or.GKBM.sku;

import java.util.List;



public interface P_skuDAO {
	//테이블 리스트
	List<P_skuDTO> selectEmpList(); 
	//등록
	public int addition(P_skuDTO skuDTO);
	//삭제
	public int delete(P_skuDTO skuDTO);
	//내가 원하는거 조회
	public List<P_skuDTO> like(P_skuDTO skuDTO);
	
}
