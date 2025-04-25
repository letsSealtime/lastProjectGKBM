package kr.or.GKBM.mainpage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainPageController {

	// 메인 대시보드
	@RequestMapping("/mainpage")
	public String mainPage() {
	    return "mainpageLayout"; // Tiles definition 이름
	}

}
