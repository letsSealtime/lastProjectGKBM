package kr.or.GKBM.p_repair;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.p_equipreg.P_equipregDTO;

@Repository
public class P_repairDAOImpl implements P_repairDAO {

    @Autowired
    SqlSession sqlSession;

    // 전체조회
    @Override
    public List<P_repairDTO> selectP_repairBySearchWithPaging(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_repair", params);
    }

    // 조건에 맞는 전체 데이터 수 조회
    @Override
    public int selectTotalCount(Map<String, Object> params) {
        return sqlSession.selectOne("gkbm.emp.selectRepairTotalCount", params);
    }
    
    // 검색 (페이지네이션 없이)
    @Override
    public List<P_repairDTO> selectP_repairBySearch(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_repair", params);
    }
    
    
    // 추가
    @Override
    public int insertP_repair(P_repairDTO dto) {
        return sqlSession.insert("gkbm.emp.insertP_repair", dto);
    }

    // 삭제
    @Override
    public int deleteP_repair(P_repairDTO dto) {
        return sqlSession.delete("gkbm.emp.deleteP_repair", dto);
    }
    
    // 수정
    @Override
    public int updateP_repair(P_repairDTO dto) {
        return sqlSession.update("gkbm.emp.updateP_repair", dto);
    }
    
    @Override
    public List<P_equipregDTO> selectAllFacilities() {
        return sqlSession.selectList("gkbm.emp.selectAllFacilities");
    }
}
