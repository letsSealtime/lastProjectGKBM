package kr.or.GKBM.week;

import java.util.List;

import kr.or.GKBM.vendor.VendorDTO;

public interface WeekDAO {

	List<WeekDTO> sku_select();

	List<WeekDTO> selectALL(WeekDTO dto);

	List<WeekDTO> select(WeekDTO dto);

	int insert(WeekDTO dto);

	int delete(WeekDTO dto);

	int update(WeekDTO dto);

}
