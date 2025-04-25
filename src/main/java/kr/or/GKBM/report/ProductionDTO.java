package kr.or.GKBM.report;

import java.util.Date;
import lombok.Data;

@Data
public class ProductionDTO {
	
    private int production_id;
    private Date production_date;
    private int quantity;
    private String unit;

    private int product_count;
    private int product_price;
    private String sku_type;
    private Date create_date;    
    
    private String sku_id;              
    private String sku_name;           
    private int production_value;   
    
}
