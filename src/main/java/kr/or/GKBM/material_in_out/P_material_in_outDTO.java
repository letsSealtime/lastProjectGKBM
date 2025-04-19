package kr.or.GKBM.material_in_out;

import java.sql.Date;


import lombok.Data;
@Data
public class P_material_in_outDTO {
	int ib_id;
	int material_count;
	int material_price;
	String sku_type;
	Date create_date;
	Date modify_date;
	String remarks;
	int sku_id;
	int bill_id;
	 String sku_code;
     String sku_name;
     String sku_size;
     
     int startRow;       //시작
  	 int endRow;			 // 끝
}
