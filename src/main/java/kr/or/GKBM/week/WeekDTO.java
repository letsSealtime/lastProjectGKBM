package kr.or.GKBM.week;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class WeekDTO {

	// 생산관리번호
	private Integer c_i;
	// 주차 생산 수량
	private Integer c_c;
	// 상품ID
	private Integer c_s;
	// 년도
	private Integer c_y;
	// 주차
	private Integer c_w;
	// 날짜
	private String c_d;
	// 상품이름
	private String c_n;
	// 상품코드
	private String c_k;

	// 타입
	private String hidden;
	
	private int viewCount = 10;
	private int page = 1;
	private int indexStart;
	private int indexEnd;
	private int line;
	private int begin;
	private int end;
	
	private List check;
	
}
