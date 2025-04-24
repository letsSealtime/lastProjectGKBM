package kr.or.GKBM.p_repair;

import java.util.List;
import java.util.Map;

import kr.or.GKBM.p_equipreg.P_equipregDTO;

public interface P_repairDAO {
    // 전체조회 (페이지네이션 포함)
    List<P_repairDTO> selectP_repairBySearchWithPaging(Map<String, Object> params);

    // 조건에 맞는 전체 데이터 수 조회
    int selectTotalCount(Map<String, Object> params);

    // 검색 (페이지네이션 없이)
    List<P_repairDTO> selectP_repairBySearch(Map<String, Object> params);

    // 등록
    int insertP_repair(P_repairDTO dto);

    // 삭제
    int deleteP_repair(P_repairDTO dto);

    // 수정
    int updateP_repair(P_repairDTO dto);
    
    List<P_equipregDTO> selectAllFacilities();
}
