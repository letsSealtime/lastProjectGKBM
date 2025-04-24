package kr.or.GKBM.report;

import java.sql.Date;

import lombok.Data;

@Data
public class FinancialDTO {

	int financialId;
	Date reportDate;
	int totalSales;
	int operatingProfit;
	int netProfit;
	int ibId;
	
}
