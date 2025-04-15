package kr.or.GKBM.sku;
import java.sql.Date;
//import java.util.List;

import lombok.Data;


@Data
public class P_skuDTO {

	
	int sku_id;
	String sku_code;
	String sku_name;
	String sku_size;
	String vendor_name;
	int price;
	Date create_date;
	Date modify_date;
	String sku_category;
	

	
}
