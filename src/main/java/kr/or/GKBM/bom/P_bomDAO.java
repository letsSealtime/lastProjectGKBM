package kr.or.GKBM.bom;

import java.util.List;

import org.springframework.stereotype.Repository;





public interface P_bomDAO {
	
	public List<P_bomDTO> fulltableList2_7(P_bomDTO bDTO);
	
	public int Count_2_7(P_bomDTO bDTO);
	//추가
	public int addition_2_7(P_bomDTO bDTO);
	//삭제
	public int delete_2_7(P_bomDTO bDTO);
	//수정
	public int udpate_2_7(P_bomDTO bDTO);
	
	
	
	
	
}
