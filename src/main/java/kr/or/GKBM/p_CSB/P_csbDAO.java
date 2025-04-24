package kr.or.GKBM.p_CSB;

import java.util.List;
import java.util.Map;

public interface P_csbDAO {
    List<P_csbDTO> selectCsbList(Map<String, Object> params);
    int selectCsbTotalCount(Map<String, Object> params);
    int insertCsb(P_csbDTO dto);
    int updateCsb(P_csbDTO dto);
    int deleteCsb(P_csbDTO dto);
    P_csbDTO selectCsbById(int receipt_payment_id);
}
