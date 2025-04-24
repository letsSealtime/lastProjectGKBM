package kr.or.GKBM.p_CSB;


import java.sql.Date;

import lombok.Data;

@Data
public class P_csbDTO {
    private String receipt_payment_id;    // 수불 ID (PK)
    private String consumables_code;   // 소모품 코드 (FK)
    private String requester;          // 불출자
    private String importer;           // 수입자
    private int log_count;             // 수량
    private Date receipt_payment_date; // 수불일자
    private String remarks;            // 비고
    
    // 조회용 필드
    private String consumables_name;   // 소모품명 (JOIN)
    private int startRow;
    private int endRow;
}
