package kr.or.GKBM.defect;

import java.util.List;

public interface DefectService {

	List<DefectDTO> code_select(DefectDTO dto);

	int insert(DefectDTO dto);

}
