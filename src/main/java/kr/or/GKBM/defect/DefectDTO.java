package kr.or.GKBM.defect;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class DefectDTO {

	// 부적합 번호
	private String c_d;
	// 제품 코드
	private String c_p;
	// 제품명
	private String c_j;
	// 제품 유형
	private String c_type;
	// 회사명
	private String c_m;

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
