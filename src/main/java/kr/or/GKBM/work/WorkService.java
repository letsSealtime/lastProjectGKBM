package kr.or.GKBM.work;

import java.util.List;
import java.util.Map;

public interface WorkService {

	Map code_select();

	int insert(WorkDTO dto);

	List<WorkDTO> detail_select(WorkDTO dto);

}
