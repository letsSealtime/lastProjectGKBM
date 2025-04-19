package kr.or.GKBM.material_in_out;

import java.util.List;

public interface P_material_in_outDAO {

public List<P_material_in_outDTO> fulltableList2_1(P_material_in_outDTO mioDTO);
	
	public int Count_2_1(P_material_in_outDTO mioDTO);
	//추가
	public int addition_2_1(P_material_in_outDTO mioDTO);
	//삭제
	public int delete_2_1(P_material_in_outDTO mioDTO);
	
}
