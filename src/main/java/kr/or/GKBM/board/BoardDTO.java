package kr.or.GKBM.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int boardId;
	private int empno;
	private String title;
	private String boardContent;
	private int notice;
	private Date createDate;
	private Date reserveDate;
	private int views = 0;

	private int page = 1;
	private int viewCount = 10;	
	private int indexStart;
	private int indexEnd;
	
}
