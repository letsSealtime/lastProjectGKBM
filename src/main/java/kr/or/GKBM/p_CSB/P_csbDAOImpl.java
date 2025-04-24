package kr.or.GKBM.p_CSB;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class P_csbDAOImpl implements P_csbDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<P_csbDTO> selectCsbList(Map<String, Object> params) {
		return sqlSession.selectList("gkbm.emp.selectCsbList", params);
	}

	@Override
	public int selectCsbTotalCount(Map<String, Object> params) {
		return sqlSession.selectOne("gkbm.emp.selectCsbTotalCount", params);
	}

	// 등록
	@Override
	@Transactional
	public int insertCsb(P_csbDTO dto) {
		sqlSession.insert("gkbm.emp.insertCsb", dto);
		Map<String, Object> params = new HashMap<>();
		params.put("consumables_code", dto.getConsumables_code());
		params.put("adjustment", -dto.getLog_count());
		return sqlSession.update("gkbm.emp.adjustConsumable", params);
	}

	// 수정
	@Override
	@Transactional
	public int updateCsb(P_csbDTO dto) {
		// 1. 기존 수량 조회
		int originalCount = sqlSession.selectOne("gkbm.emp.selectOriginalCsbCount", dto.getReceipt_payment_id());

		// 2. 차이 계산 (기존 수량 - 새 수량)
		int adjustment = originalCount - dto.getLog_count();

		// 3. 재고 조정
		Map<String, Object> params = new HashMap<>();
		params.put("consumables_code", dto.getConsumables_code());
		params.put("adjustment", adjustment);
		sqlSession.update("gkbm.emp.adjustConsumable", params);

		// 4. 수불 기록 업데이트
		return sqlSession.update("gkbm.emp.updateCsb", dto);
	}

	// 삭제
	@Override
	@Transactional
	public int deleteCsb(P_csbDTO dto) {
		// 1. 재고 복원
		sqlSession.update("restoreP_CSB", dto);

		// 2. 폐기 기록 삭제
		return sqlSession.delete("deleteP_CSB", dto.getReceipt_payment_id());
	}

	// 소모품 수불 id 조회
	@Override
	public P_csbDTO selectCsbById(int receipt_payment_id) {
		return sqlSession.selectOne("gkbm.emp.selectCsbById", receipt_payment_id);
	}
}
