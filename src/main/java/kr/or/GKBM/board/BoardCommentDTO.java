package kr.or.GKBM.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardCommentDTO {

	int comment_Id;
	int board_Id;
	int empno;
	String writer_name;
	String content;
	Date create_date;
	
	// 대댓글
	int parent_id;
	int depth;
	
	// 삭제 여부
	int is_deleated = 0;
}
