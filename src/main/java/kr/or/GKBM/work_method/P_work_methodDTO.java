package kr.or.GKBM.work_method;
import java.sql.Date;
//import java.util.List;

import lombok.Data;


@Data
public class P_work_methodDTO {

	
	String work_method;
	String sku_code;
	String sku_name;
	String sku_size;	
	String work;
	int consumption;
	int sku_id;
	String work_file;
	Date create_date;
	Date modify_date;
	
	int startRow;      //시작
	int endRow;			// 끝
	
	
	
	
	
	
	
}
