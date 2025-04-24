package kr.or.GKBM.p_CMB;

import java.util.List;
import java.util.Map;

public interface P_consumregDAO {
    // 페이징 및 검색 전체조회
    List<P_consumregDTO> selectP_consumregBySearchWithPaging(Map<String, Object> params);

    // 전체 레코드 수 조회
    int selectTotalCount(Map<String, Object> params);

    // 검색(비페이징)
    List<P_consumregDTO> selectP_consumregBySearch(Map<String, Object> params);

    // 등록
    int insertP_con(P_consumregDTO dto);

    // 삭제
    int deleteP_con(P_consumregDTO dto);

    // 수정
    int updateP_con(P_consumregDTO dto);

    List<P_consumregDTO> selectAllConsumreg();
}
