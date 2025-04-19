package kr.or.GKBM.bill;

import java.util.List;

public interface BillService {

	List<BillDTO> selectALL(BillDTO dto);

	List<BillDTO> select(BillDTO dto);

	int insert(BillDTO dto);

	int delete(BillDTO dto);

	int update(BillDTO dto);

}
