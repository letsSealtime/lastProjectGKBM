package kr.or.GKBM.p_CMB;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class P_consumregDAOImpl implements P_consumregDAO {

    @Autowired
    SqlSession sqlSession;

    @Override
    public List<P_consumregDTO> selectP_consumregBySearchWithPaging(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_consumreg", params);
    }

    @Override
    public int selectTotalCount(Map<String, Object> params) {
        return sqlSession.selectOne("gkbm.emp.selectTotalCountConsum", params);
    }

    @Override
    public List<P_consumregDTO> selectP_consumregBySearch(Map<String, Object> params) {
        return sqlSession.selectList("gkbm.emp.selectP_consumreg", params);
    }

    @Override
    public int insertP_con(P_consumregDTO dto) {
        return sqlSession.insert("gkbm.emp.insertP_con", dto);
    }

    @Override
    public int deleteP_con(P_consumregDTO dto) {
        return sqlSession.delete("gkbm.emp.deleteP_con", dto);
    }

    @Override
    public int updateP_con(P_consumregDTO dto) {
        return sqlSession.update("gkbm.emp.updateP_con", dto);
    }
    
    @Override
    public List<P_consumregDTO> selectAllConsumreg() {
        return sqlSession.selectList("gkbm.emp.selectAllConsumreg");
    }
}
