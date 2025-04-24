package kr.or.GKBM.product_in_out2;

import java.util.List;

public interface P_product_in_outDAO2 {

	public List<P_product_in_outDTO2> fulltableList2_5(P_product_in_outDTO2 pioDTO2);
	
	public int Count_2_5(P_product_in_outDTO2 pioDTO2);
	//추가
	public int addition_2_5(P_product_in_outDTO2 pioDTO2);
	//삭제
	public int delete_2_5(P_product_in_outDTO2 pioDTO2);
	//수정
	public int udpate_2_5(P_product_in_outDTO2 pioDTO2);
	
}
