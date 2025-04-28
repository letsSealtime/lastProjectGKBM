package kr.or.GKBM.bom;
import java.sql.Date;
//import java.util.List;

import lombok.Data;


@Data
public class P_bomDTO {

	
	int bom_id;
	String sku_code;
	String sku_name;
	String sku_size;	
	String sku_id_material;
	int consumption;
	Date create_date;
	Date modify_date;
	int sku_id;
	String work_method;
	String work;
	String work_file;
	
	int startRow;      //시작
	int endRow;			// 끝
	
	
	private String searchKeyword; 
	
	
	
	
	
	
	
}
