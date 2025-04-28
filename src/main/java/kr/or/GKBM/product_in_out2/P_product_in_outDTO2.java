package kr.or.GKBM.product_in_out2;

import java.sql.Date;


import lombok.Data;


@Data
public class P_product_in_outDTO2 {
	int ib_id;
	int product_count;
	int product_price;
	String sku_type;
	Date create_date;
	Date modify_date;
	String remarks;
	int sku_id;
	int empno;
	 String sku_code;
     String sku_name;
     String sku_size;
     
     int startRow;       //시작
 	int endRow;			 //끝
 	
 	
 	private String searchKeyword; 
     
     
}
