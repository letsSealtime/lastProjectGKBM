package kr.or.GKBM.material_in_out2;

import java.util.List;

public interface P_material_in_outDAO2 {

	public List<P_material_in_outDTO2> fulltableList2_2(P_material_in_outDTO2 mioDTO2);
	
	public int Count_2_2(P_material_in_outDTO2 mioDTO2);
	//추가
	public int addition_2_2(P_material_in_outDTO2 mioDTO2);
	//삭제
	public int delete_2_2(P_material_in_outDTO2 mioDTO2);
	//수정
	public int udpate_2_2(P_material_in_outDTO2 mioDTO2);
	
}
