package kr.or.GKBM.product_in_out;

import java.util.List;

public interface P_product_in_outDAO {

	public List<P_product_in_outDTO> fulltableList2_4(P_product_in_outDTO pioDTO);
	
	public int Count_2_4(P_product_in_outDTO pioDTO);
	//추가
	public int addition_2_4(P_product_in_outDTO pioDTO);
	//삭제
	public int delete_2_4(P_product_in_outDTO pioDTO);
	//수정
	public int udpate_2_4(P_product_in_outDTO pioDTO);
	
}
