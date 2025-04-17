package kr.or.GKBM.vendor;

import java.util.List;

public interface VendorDAO {

	public List<VendorDTO> selectALL(VendorDTO dto);
	public List<VendorDTO> select(VendorDTO dto);
	int insert(VendorDTO dto);
	int delete(VendorDTO dto);
	int update(VendorDTO dto);
	
}
