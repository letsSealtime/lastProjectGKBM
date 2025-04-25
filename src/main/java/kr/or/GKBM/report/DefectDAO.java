package kr.or.GKBM.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DefectDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<DefectDTO> selectDefectRateByUnit(Map<String, String> param) {
        return sqlSession.selectList("gkbm.emp.selectDefectRateByUnit", param);
    }
}