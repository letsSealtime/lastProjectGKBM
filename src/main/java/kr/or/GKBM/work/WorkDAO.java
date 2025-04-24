package kr.or.GKBM.work;

import java.util.List;
import java.util.Map;

public interface WorkDAO {

	int insert(WorkDTO dto);

	List<WorkDTO> detail_select(WorkDTO dto);

	Map code_select(WorkDTO dto);

}
