package kr.or.GKBM.p_ins;

import java.sql.Date;
import lombok.Data;

@Data
public class P_insDTO {
    private int inspection_id;           // 점검ID (PK)
    private String facility_code;        // 설비코드 (FK, p_facility 참조)
    private Date inspection_date;        // 점검일자
    private String inspector;           // 점검자
    private String inspection_item;      // 점검항목
    private String inspection_content;   // 점검내용
    private String remarks;             // 비고사항
    
    private String facility_name;        // 설비명 (조인으로 조회)
    
    private int startRow;               // 페이징 시작
    private int endRow;                 // 페이징 끝
}
