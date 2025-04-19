package kr.or.GKBM.Login;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginDAO loginDAO;

	@Override
	public List<LoginDTO> getLoginList() {
		List<LoginDTO> list = loginDAO.selectP_emp3();

		return list;
	}

	@Override
	public boolean validateUser(String id, String pw) {
		// 1. DAO를 통해 전체 사용자 조회
		List<LoginDTO> allUsers = loginDAO.selectP_emp3();
		System.out.println("DB에서 조회된 전체 사용자: " + allUsers);

		// 2. 입력값과 일치하는 사용자 찾기
		for (LoginDTO user : allUsers) {
			System.out.println("비교 중인 사용자: " + user.getEmp_id() + "/" + user.getPw());

			if (user.getEmp_id().equals(id) && user.getPw().equals(pw)) {
				System.out.println("로그인 성공: " + id);
				return true;
			}
		}

		System.out.println("로그인 실패: " + id);
		return false;
	}
	
	@Override
	public LoginDTO findUserById(String id) {
	    List<LoginDTO> allUsers = loginDAO.selectP_emp3();
	    for (LoginDTO user : allUsers) {
	        if (user.getEmp_id().equals(id)) {
	            return user; // 일치하는 사용자 반환
	        }
	    }
	    return null; // 사용자를 찾지 못한 경우 null 반환
	}

}
