package kr.or.GKBM.p_CMB;


import java.sql.Date;

import lombok.Data;

@Data
public class P_consumregDTO {
    private String consumables_code;    // 소모품 코드 (PK)
    private String consumables_name;    // 소모품명
    private Date create_date;           // 등록일자
    private int p_Con_count;                  // 수량
    private String manager;             // 담당자
    private String remarks;             // 비고

    private int startRow;               // 페이징 시작
    private int endRow;                 // 페이징 끝
}
