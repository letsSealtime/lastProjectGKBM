package kr.or.GKBM.work;

import java.util.List;

public interface WorkService {

	List<WorkDTO> code_select();

	List<WorkDTO> detail_select();

	List<WorkDTO> insert(WorkDTO dto);

	List<WorkDTO> delete(WorkDTO dto);

	List<WorkDTO> detail_select(WorkDTO dto);

}
