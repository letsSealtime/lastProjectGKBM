package kr.or.GKBM.p_equipreg;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class equipregDAOImpl implements equipregDAO {

    @Autowired
    SqlSession sqlSession;
    
    // 전체 조회
    @Override
    public List<equipregDTO> selectAllP_eq3() {
        return sqlSession.selectList("gkbm.emp.selectP_equipreg");
    }
    
    // 등록
    @Override
    public int insertP_eq(equipregDTO eqDTO) {
        int dto = sqlSession.insert("gkbm.emp.insertP_eq", eqDTO);
        System.out.println("insertP_eq eqDTO"+eqDTO);
        return dto;
    }
    
    // 삭제
    @Override
    public int deleteP_eq(equipregDTO eqDTO) {
    	int dto = sqlSession.delete("gkbm.emp.deleteP_eq3", eqDTO);
        System.out.println("deleteP_eq eqDTO"+eqDTO);
        return dto;
    }
    
    // 수정
    @Override
    public int updateP_eq(equipregDTO eqDTO) {
    	int dto = sqlSession.update("gkbm.emp.updateP_eq3", eqDTO);
        System.out.println("updateP_eq eqDTO"+eqDTO);
        return dto;
    }
    
}
