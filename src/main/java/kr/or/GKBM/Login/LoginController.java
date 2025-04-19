package kr.or.GKBM.Login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;

	// 로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String listLogin(Model model, HttpServletRequest request) {

		return "login";

	}

	// Service에서 로그인시 true면 메인페이지 이동 false면 다시 로그인페이지로 이동
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String processLogin(HttpServletRequest request, Model model) {
		String id = request.getParameter("empId");
		String pw = request.getParameter("pw");

		boolean isValidUser = loginService.validateUser(id, pw);
		System.out.println("id : " + id);
		System.out.println("pw : " + pw);

		if (isValidUser) {
			HttpSession session = request.getSession();
			LoginDTO user = loginService.findUserById(id); // ID로 사용자 정보 조회
			session.setAttribute("user", user); // DTO 객체 저장
			return "redirect:/mainpage"; // 성공 시 메인 페이지로 이동
		} else {
			model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
			return "/login"; // 실패 시 다시 로그인 페이지로 이동
		}
	}

	// 로그인 성공시 메인페이지로 이동
	@RequestMapping(value = "/mainpage", method = RequestMethod.GET)
	public String mainPage() {
		return "mainpage";
	}
	
	// 로그아웃시 세션 무효화
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/login";
	}

}
