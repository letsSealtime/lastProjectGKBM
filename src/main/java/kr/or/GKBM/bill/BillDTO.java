package kr.or.GKBM.bill;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class BillDTO {

	// 날짜
	private String c_d;
	// 등록번호
	private String c_c;
	// 수량
	private Integer c_q;
	// 가격
	private Integer c_b;
	// 상품번호
	private String c_i;
	// 공급자
	private String c_n;
	// 연락처
	private String c_p;
	// 주소
	private String c_j;
	// 상태
	private String c_a;

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
