package kr.or.GKBM.vendor;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class VendorDTO {

	// 업체코드(VENDOR_ID)
	private String c_c;
	// 업체명(VENDOR_NAME)
	private String c_n;
	// 담당자(MGR)
	private String c_m;
	// 연락처(VENDOR_PHONE)
	private String c_p;
	// EMAIL(EMAIL)
	private String c_a;
	// 스큐ID FK(SKU_ID)
	private String c_i;
	
	private String hidden;
	
	private int viewCount = 10;
	private int page = 1;
	private int indexStart;
	private int indexEnd;
	private int line;
	private int begin;
	private int end;
	
	private List check = new ArrayList();

}
