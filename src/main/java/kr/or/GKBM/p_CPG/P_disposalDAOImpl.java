package kr.or.GKBM.p_CPG;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class P_disposalDAOImpl implements P_disposalDAO {

	@Autowired
	SqlSession sqlSession;

	
	// [등록] 폐기 기록 추가 + 수량 차감
	@Override
	public int insertDisposal(P_disposalDTO dto) {
		int result = sqlSession.insert("gkbm.emp.insertP_disposal", dto);
		sqlSession.update("gkbm.emp.decreaseConsumable", dto);
		return result;
	}

	
	// 소모품 폐기 수정 (재고 조정 포함)
	@Override
	@Transactional
	public int updateDisposal(P_disposalDTO dto) {
		// 1. 기존 폐기 수량 조회
		int originalCount = sqlSession.selectOne("selectOriginalDisposalCount", dto.getDisposal_id());

		// 2. 차이 계산
		int adjustment = originalCount - dto.getCount();

		// 3. 재고 조정
		Map<String, Object> params = new HashMap<>();
		params.put("consumables_code", dto.getConsumables_code());
		params.put("adjustment", adjustment);
		sqlSession.update("adjustConsumable", params);

		// 4. 폐기 정보 업데이트
		return sqlSession.update("updateP_disposal", dto);
	}

	
	// 소모품 폐기 삭제 (재고 복원)
	@Override
	@Transactional
	public int deleteDisposal(P_disposalDTO dto) {
		// 1. 재고 복원
		sqlSession.update("restoreConsumableOnDelete", dto);

		// 2. 폐기 기록 삭제
		return sqlSession.delete("deleteP_disposal", dto.getDisposal_id());
	}

	
	// [조회] 폐기 목록 조회
	@Override
	public List<P_disposalDTO> selectDisposalList(Map<String, Object> params) {
		return sqlSession.selectList("gkbm.emp.selectP_disposal", params);
	}

	// [전체 레코드 수] 페이징용
	@Override
	public int selectDisposalTotalCount(Map<String, Object> params) {
		return sqlSession.selectOne("gkbm.emp.selectDisposalTotalCount", params);
	}

}
