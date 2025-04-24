package kr.or.GKBM.work_method;

import java.util.List;



public interface P_work_methodDAO {
	
	public List<P_work_methodDTO> fulltableList2_6(P_work_methodDTO wmDTO); 
	public int Count_2_6(P_work_methodDTO wmDTO);
	//추가
	public int addition_2_6(P_work_methodDTO wmDTO);
	//삭제
	public int delete_2_6(P_work_methodDTO wmDTO);
	//수정
	public int udpate_2_6(P_work_methodDTO wmDTO);
	
	
	
	
	
}
