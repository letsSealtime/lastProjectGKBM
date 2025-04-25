package kr.or.GKBM.report;

import lombok.Data;

@Data
public class DefectDTO {

	int defectId;
	String defectDate;
	int defectCount;
	int workOrderId;
	
}
