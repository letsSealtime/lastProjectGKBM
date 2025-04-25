package kr.or.GKBM.report;

import java.util.Date;
import lombok.Data;

@Data
public class ProductionDTO {
	
    private int productionId;
    private Date productionDate;
    private int quantity;
    private String unit;

    private int productCount;
    private int productPrice;
    private String skuType;
    private Date createDate;    
    
}
