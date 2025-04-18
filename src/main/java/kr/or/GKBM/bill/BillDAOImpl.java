package kr.or.GKBM.bill;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BillDAOImpl implements BillDAO {

	@Autowired
	SqlSession sqlSession;

	public List<BillDTO> selectALL(BillDTO dto) {

		System.out.println("전체 조회 진입");

		List<BillDTO> select = sqlSession.selectList("gkbm.emp.selectbill_All_1", dto);
		BillDTO line = sqlSession.selectOne("gkbm.emp.selectbillAll_1");

		dto.setLine(line.getLine());

		return select;
	}

	@Override
	public List<BillDTO> select(BillDTO dto) {
		System.out.println("부분 조회 진입");

		List<BillDTO> select = sqlSession.selectList("gkbm.emp.selectbill_Part_1", dto);
		BillDTO line = sqlSession.selectOne("gkbm.emp.selectbillPart_1");
		
		System.out.println(select);

		dto.setLine(line.getLine());

		return select;
	}
	
	@Override
	public int insert(BillDTO dto) {
		
		int insert = sqlSession.insert("gkbm.emp.insertbill_1", dto);
		
		return insert;
	}
	
	@Override
	public int delete(BillDTO dto) {
		
		int delete = sqlSession.delete("gkbm.emp.deletebill_1", dto);
		
		System.out.println(delete);
		
		return delete;
	}
	
	
	@Override
	public int update(BillDTO dto) {
		
		int update = sqlSession.update("gkbm.emp.updatebill_1", dto);
		
		System.out.println(update);
		
		return update;
	}

	
}
