package kr.or.GKBM.p_equipreg;



import java.sql.Date;

import lombok.Data;

@Data
public class P_equipregDTO {

	private String facility_code; // 시설 코드 (Primary Key)
	private String facility_manager; // 시설 관리자
	private Date installation_date; // 설치 날짜
	private String facility_name; // 시설 이름
	private String facility_location; // 시설 위치
	private String inspection_cycle; // 점검 주기
	private String remarks; // 비고
	
	int startRow;   // 시작      
	int endRow;		// 끝
	
}
