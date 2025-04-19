package kr.or.GKBM.Login;

import lombok.Data;

@Data
public class LoginDTO {

	private int empNo; // 사원 번호
	private String emp_id; // 아이디
	private String emp_name; // 이름
	private String pw; // 비밀번호
	private String email; // 이메일
	private String phone; // 연락처
	private int grade; // 등급

}
