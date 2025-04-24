package kr.or.GKBM.p_ins;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.p_equipreg.P_equipregDTO;
import kr.or.GKBM.p_repair.P_repairDTO;

// 설비점검 DAO 구현체
@Repository
public class P_insDAOImpl implements P_insDAO {

    @Autowired
    SqlSession sqlSession;

    // 전체조회
    @Override
    public List<P_insDTO> selectP_insBySearchWithPaging(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_ins", params);
    }
    
 // 조건에 맞는 전체 데이터 수 조회
    @Override
    public int selectTotalCount(Map<String, Object> params) {
        return sqlSession.selectOne("gkbm.emp.selectInsTotalCount", params);
    }
    
 // 검색 (페이지네이션 없이)
    @Override
    public List<P_insDTO> selectP_insBySearch(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_repair", params);
    }
    
    
    // 추가
    @Override
    public int insertP_ins(P_insDTO dto) {
        return sqlSession.insert("gkbm.emp.insertP_ins", dto);
    }

    // 삭제
    @Override
    public int deleteP_ins(P_insDTO dto) {
        return sqlSession.delete("gkbm.emp.deleteP_ins", dto);
    }
    
    // 수정
    @Override
    public int updateP_ins(P_insDTO dto) {
        return sqlSession.update("gkbm.emp.updateP_ins", dto);
    }
    
    @Override
    public List<P_equipregDTO> selectAllFacilities() {
        return sqlSession.selectList("gkbm.emp.selectAllFacilities");
    }
}
