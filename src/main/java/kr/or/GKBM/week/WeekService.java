package kr.or.GKBM.week;

import java.util.List;

import kr.or.GKBM.bill.BillDTO;
import kr.or.GKBM.vendor.VendorDTO;

public interface WeekService {

	List<WeekDTO> selectALL(WeekDTO dto);

	List<WeekDTO> select(WeekDTO dto);

	int insert(WeekDTO dto);

	int delete(WeekDTO dto);

	int update(WeekDTO dto);

	List<WeekDTO> sku_select(WeekDTO dto);

}
