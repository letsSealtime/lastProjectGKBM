package kr.or.GKBM.p_CPG;

import java.util.List;
import java.util.Map;


public interface P_disposalDAO {
    int insertDisposal(P_disposalDTO dto); // 폐기 등록 + 수량 차감
    int updateDisposal(P_disposalDTO dto); // 폐기 수정
    int deleteDisposal(P_disposalDTO dto); // 폐기 삭제 (파라미터 DTO로 변경)
    List<P_disposalDTO> selectDisposalList(Map<String, Object> params);
    int selectDisposalTotalCount(Map<String, Object> params);
}
