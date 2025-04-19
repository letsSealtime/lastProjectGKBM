package kr.or.GKBM.Login;

import java.util.List;

public interface LoginService {

	public List<LoginDTO> getLoginList();
	
	public boolean validateUser(String inputId, String inputPw);
	
	public LoginDTO findUserById(String id);
}
