package kr.or.GKBM.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardCommentDTO {

	int comment_id;
	int board_id;
	int empno;
	String writer_name;
	String content;
	Date create_date;
	
	// 대댓글
	Integer parent_id;
	int depth;
	
	// 삭제 여부
	int is_deleted = 0;
}
