package kr.or.GKBM.p_ins;

import java.util.List;
import java.util.Map;

import kr.or.GKBM.p_equipreg.P_equipregDTO;
import kr.or.GKBM.p_repair.P_repairDTO;

// 설비점검 DAO 인터페이스
 interface P_insDAO {
	
	// 전체조회
	 List<P_insDTO> selectP_insBySearchWithPaging(Map<String, Object> params);
	
	// 조건에 맞는 전체 데이터 수 조회
	 int selectTotalCount(Map<String, Object> params);
	
	// 검색 (페이지네이션 없이)
     List<P_insDTO> selectP_insBySearch(Map<String, Object> params);
    
    // 추가
     int insertP_ins(P_insDTO dto);

    // 삭제
     int deleteP_ins(P_insDTO dto);
    
    // 수정
     int updateP_ins(P_insDTO dto);
    
     List<P_equipregDTO> selectAllFacilities();
}
