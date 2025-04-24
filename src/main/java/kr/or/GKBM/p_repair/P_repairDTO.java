package kr.or.GKBM.p_repair;

import java.sql.Date;
import lombok.Data;

@Data
public class P_repairDTO {
    private int repair_id; // 설비수리 id (PK)
    private String facility_code; // 설비코드 (FK, p_facility의 PK 참조)
    private String facility_name; // 설비명
    private Date repair_request_date; // 의뢰일자
    private String repair_details; // 수리내역
    private String repair_requester; // 의뢰자
    private String repair_item; // 수리항목
    private String remarks; // 비고사항

    private int startRow; // 페이징 시작
    private int endRow;   // 페이징 끝
}
