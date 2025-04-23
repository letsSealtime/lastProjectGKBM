package kr.or.GKBM.disposal_refurb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class disableController {

	@RequestMapping(value="/disable", method = RequestMethod.GET)
	public ModelAndView disableEnter(@ModelAttribute disableDTO dto) {
		
		ModelAndView disable = new ModelAndView();
		disable.setViewName("disposal_refurb");
		
		
		return disable;
	}
}
