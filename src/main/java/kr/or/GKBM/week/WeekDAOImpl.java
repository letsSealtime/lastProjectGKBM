package kr.or.GKBM.week;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.GKBM.vendor.VendorDTO;

@Repository
public class WeekDAOImpl implements WeekDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<WeekDTO> sku_select() {

		List<WeekDTO> sku_select = sqlSession.selectList("gkbm.emp.sku_select");

		return sku_select;
	}

	@Override
	public List<WeekDTO> selectALL(WeekDTO dto) {

		System.out.println("전체 조회 진입");

		List<WeekDTO> select = sqlSession.selectList("gkbm.emp.selectWeek_All_1", dto);
		WeekDTO line = sqlSession.selectOne("gkbm.emp.selectWeekAll_1");

		dto.setLine(line.getLine());

		return select;
	}

	@Override
	public List<WeekDTO> select(WeekDTO dto) {
		System.out.println("부분 조회 진입");

		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_w());
		System.out.println(dto.getC_y());
		System.out.println(dto.getC_i());

		List<WeekDTO> select = sqlSession.selectList("gkbm.emp.selectWeek_Part_1", dto);
		WeekDTO line = sqlSession.selectOne("gkbm.emp.selectWeekPart_1");

		System.out.println(select);

		dto.setLine(line.getLine());

		return select;
	}

	@Override
	public int insert(WeekDTO dto) {

		int insert = sqlSession.insert("gkbm.emp.insertWeek_1", dto);

		return insert;
	}

	@Override
	public int delete(WeekDTO dto) {

		int delete = sqlSession.delete("gkbm.emp.deleteWeek_1", dto);

		System.out.println(delete);

		return delete;
	}

	@Override
	public int update(WeekDTO dto) {

		int update = sqlSession.update("gkbm.emp.updateWeek_1", dto);

		System.out.println(update);

		return update;
	}
}
