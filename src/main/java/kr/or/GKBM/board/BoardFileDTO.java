package kr.or.GKBM.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardFileDTO {

	int file_id;
	int board_id;
	String file_name;
	String file_path;
	Date upload_date;
	
}
