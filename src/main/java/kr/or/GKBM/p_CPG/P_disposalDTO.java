package kr.or.GKBM.p_CPG;

import java.sql.Date;
import lombok.Data;

@Data
public class P_disposalDTO {
     String disposal_id;      // 폐기_id (PK)
     String consumables_code;   // 소모품코드 (FK)
     Date disposal_date;        // 폐기일자
     int count;     // 폐기수량
     String disposal_reason;    // 폐기사유
     String manager;            // 담당자
     String remarks;             // 비고

    // 조회/검색/페이징용
     String consumables_name;   // 소모품명 (조인용)
     int startRow;
     int endRow;
}
