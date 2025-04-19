package kr.or.GKBM.vendor;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class VendorDAOImpl implements VendorDAO {

	@Autowired
	SqlSession sqlSession;

	public List<VendorDTO> selectALL(VendorDTO dto) {

		System.out.println("전체 조회 진입");

		List<VendorDTO> select = sqlSession.selectList("gkbm.emp.selectVendor_All_1", dto);
		VendorDTO line = sqlSession.selectOne("gkbm.emp.selectVendorAll_1");

		dto.setLine(line.getLine());

		return select;
	}

	@Override
	public List<VendorDTO> select(VendorDTO dto) {
		System.out.println("부분 조회 진입");
		
		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_m());
		System.out.println(dto.getC_p());
		System.out.println(dto.getC_a());
		System.out.println(dto.getC_i());

		List<VendorDTO> select = sqlSession.selectList("gkbm.emp.selectVendor_Part_1", dto);
		VendorDTO line = sqlSession.selectOne("gkbm.emp.selectVendorPart_1");
		
		System.out.println(select);

		dto.setLine(line.getLine());

		return select;
	}
	
	@Override
	public int insert(VendorDTO dto) {
		
		int insert = sqlSession.insert("gkbm.emp.insertVendor_1", dto);
		
		return insert;
	}
	
	@Override
	public int delete(VendorDTO dto) {
		
		int delete = sqlSession.delete("gkbm.emp.deleteVendor_1", dto);
		
		System.out.println(delete);
		
		return delete;
	}
	
	
	@Override
	public int update(VendorDTO dto) {
		
		int update = sqlSession.update("gkbm.emp.updateVendor_1", dto);
		
		System.out.println(update);
		
		return update;
	}

}
