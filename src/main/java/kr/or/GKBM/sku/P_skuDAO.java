package kr.or.GKBM.sku;

import java.util.List;



public interface P_skuDAO {
	//테이블 리스트
	//내가 원하는거 조회
	//페이지네이션
	public List<P_skuDTO> fulltableList(P_skuDTO skuDTO); 
	public int Count(P_skuDTO skuDTO);
	//등록
	public int addition(P_skuDTO skuDTO);
	//삭제
	public int delete(P_skuDTO skuDTO);
	//수정
	public int udpate(P_skuDTO skuDTO);
	
	
	
}
