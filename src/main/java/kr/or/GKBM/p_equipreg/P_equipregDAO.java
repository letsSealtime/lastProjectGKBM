package kr.or.GKBM.p_equipreg;

import java.util.List;
import java.util.Map;

public interface P_equipregDAO {
	
    // 전체조회 (페이지네이션 포함)
    List selectP_equipregBySearchWithPaging(Map params);

    // 조건에 맞는 전체 데이터 수 조회
    int selectTotalCount(Map params);

    // 검색
    List selectP_equipregBySearch(Map params);

    // 등록
    int insertP_eq(P_equipregDTO dto);

    // 삭제
    int deleteP_eq(P_equipregDTO dto);

    // 수정
    int updateP_eq(P_equipregDTO dto);
    
    List<P_equipregDTO> selectAllFacilities();

}
