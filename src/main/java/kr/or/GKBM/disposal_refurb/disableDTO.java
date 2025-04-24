package kr.or.GKBM.disposal_refurb;

import lombok.Data;

@Data
public class disableDTO {
	
	// 고유ID
	private String id;
	// 상품코드
	private String code;
	// 상품명
	private String name;
	// 불량종류
	private String type;
	// 불량수량
	private String count;
	// 업체명
	private String vendor;
	
	private int viewCount = 10;
	private int page = 1;
	private int indexStart;
	private int indexEnd;
	private int line;
	private int begin;
	private int end;

}
