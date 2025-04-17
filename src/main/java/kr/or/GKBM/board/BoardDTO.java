package kr.or.GKBM.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int board_id;
	private int empno;
	private String title;
	private String board_content;
	private int notice;
	private Date create_date;
	private Date reserve_date;
	private int views = 0;

	private int page = 1;
	private int viewCount = 10;	
	private int indexStart;
	private int indexEnd;
	
}
