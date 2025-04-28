package kr.or.GKBM.report;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class FinancialDTO {

	int financial_id;
	Date report_date;
	int total_sales;
	int operating_profit;
	int net_profit;
	int ib_id;
	
}
