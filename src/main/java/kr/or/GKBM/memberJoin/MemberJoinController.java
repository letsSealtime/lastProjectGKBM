package kr.or.GKBM.memberJoin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberJoinController {

	@Autowired
	MemberService MemberServiceImpl;

	@RequestMapping(value = "/memberjoin")
	public ModelAndView memberEnter() {

		ModelAndView enter = new ModelAndView();
		enter.setViewName("memberjoin");

		return enter;

	}

	@RequestMapping(value = "/memberjoin", method = RequestMethod.POST)
	public String memberInsert(@ModelAttribute memberDTO dto) {

		if (dto.getGrade() != 2 || dto.getId().isEmpty() || dto.getPw().isEmpty() || dto.getEmail().isEmpty()) {
			return "joinerror";
		}

		int value = MemberServiceImpl.insert(dto);

		return "redirect:/login";

	}

}
