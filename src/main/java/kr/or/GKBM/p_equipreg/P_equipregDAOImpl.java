package kr.or.GKBM.p_equipreg;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class P_equipregDAOImpl implements P_equipregDAO {

    @Autowired
    SqlSession sqlSession;

    // 페이지네이션 전체 조회
    @Override
    public List selectP_equipregBySearchWithPaging(Map params) {
        return sqlSession.selectList("gkbm.emp.selectP_equipreg", params);
    }

    // 조건에 맞는 전체 데이터 수 조회
    @Override
    public int selectTotalCount(Map params) {
        return sqlSession.selectOne("gkbm.emp.selectTotalCount", params);
    }

    // 검색 (페이지네이션 없이)
    @Override
    public List selectP_equipregBySearch(Map params) {
        return sqlSession.selectList("gkbm.emp.selectP_equipreg", params);
    }

    // 등록
    @Override
    public int insertP_eq(P_equipregDTO eqDTO) {
        int dto = sqlSession.insert("gkbm.emp.insertP_eq", eqDTO);
        System.out.println("insertP_eq eqDTO" + eqDTO);
        return dto;
    }

    // 삭제
    @Override
    public int deleteP_eq(P_equipregDTO eqDTO) {
        int dto = sqlSession.delete("gkbm.emp.deleteP_eq3", eqDTO);
        System.out.println("deleteP_eq eqDTO" + eqDTO);
        return dto;
    }

    // 수정
    @Override
    public int updateP_eq(P_equipregDTO eqDTO) {
        int dto = sqlSession.update("gkbm.emp.updateP_eq3", eqDTO);
        System.out.println("updateP_eq eqDTO" + eqDTO);
        return dto;
    }
    
    @Override
    public List<P_equipregDTO> selectAllFacilities() {
        return sqlSession.selectList("gkbm.emp.selectAllFacilities");
    }

}
