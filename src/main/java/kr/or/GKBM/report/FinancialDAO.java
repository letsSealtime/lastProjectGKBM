package kr.or.GKBM.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FinancialDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<FinancialDTO> selectAll() {
        return sqlSession.selectList("gkbm.emp.selectAllFinancial");
    }

    public List<FinancialDTO> selectByPeriod(Map<String, String> dateRange) {
        return sqlSession.selectList("gkbm.emp.selectFinancialByPeriod", dateRange);
    }
}
