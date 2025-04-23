package kr.or.GKBM.defect;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.vendor.VendorDTO;

@Repository
public class DefectDAOImpl implements DefectDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<DefectDTO> code_select(DefectDTO dto) {

		System.out.println("전체 조회 진입");

		List<DefectDTO> select = sqlSession.selectList("gkbm.emp.selectDefect_All_1", dto);
		DefectDTO line = sqlSession.selectOne("gkbm.emp.selectDefectAll_1");

		dto.setLine(line.getLine());

		return select;
	}

	@Override
	public int insert(DefectDTO dto) {
		
		int insert = sqlSession.update("gkbm.emp.insertDefect", dto);
		int update = sqlSession.update("gkbm.emp.defectUpdate", dto);

		System.out.println("work insert행: " + insert);

		return insert;
	}

}
