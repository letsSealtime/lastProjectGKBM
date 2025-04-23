package kr.or.GKBM.work;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class WorkDTO {

	// 년도
	private String c_y;
	// 주차
	private String c_w;
	// 상품명
	private String c_n;
	// 상품ID
	private Integer c_pn;
	// 계획번호
	private String c_p;
	// 작업 계획 번호
	private String wi;
	// BOM ID
	private String c_b;
	// 상품코드
	private String c_c;
	// 상품명
	private String c_m;
	// 주차생산수량
	private Integer c_cc;
	// 주차잔여
	private Integer c_s;
	// 일일지시수량
	private Integer c_d;
	// 주차잔여수량
	private Integer c_r;
	// 수량
	private Integer q;
	// 완료여부
	private String coml;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date modify_date;

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
