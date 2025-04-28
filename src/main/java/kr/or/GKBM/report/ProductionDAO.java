package kr.or.GKBM.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductionDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<ProductionDTO> selectProductionByUnit(Map<String, String> param) {
    	return sqlSession.selectList("gkbm.emp.selectProductionByUnit", param);
    }

    public List<ProductionDTO> selectDetailedProduction() {
        return sqlSession.selectList("gkbm.emp.selectDetailedProduction");
    }
}
