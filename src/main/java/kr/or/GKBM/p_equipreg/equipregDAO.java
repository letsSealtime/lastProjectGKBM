package kr.or.GKBM.p_equipreg;

import java.util.List;

public interface equipregDAO {

	// 전체조회
	List<equipregDTO> selectAllP_eq3();

	// 등록
	int insertP_eq(equipregDTO dto);

	// 삭제
	int deleteP_eq(equipregDTO dto);
	
	// 수정
	int updateP_eq(equipregDTO dto);
}
