package kr.or.GKBM.report;

import lombok.Data;

@Data
public class DefectDTO {

	int defect_id;
	String defect_date;
	int defect_count;
	int work_order_id;
	private String period;
	private double defect_rate;
	
}
