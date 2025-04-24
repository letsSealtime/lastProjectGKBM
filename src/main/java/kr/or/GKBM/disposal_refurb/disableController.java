package kr.or.GKBM.disposal_refurb;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@ResponseBody
@Controller
public class disableController {

	@Autowired
	disableService service;
	
	@RequestMapping(value="/disable", method = RequestMethod.GET)
	public ModelAndView disableEnter(@ModelAttribute disableDTO dto) {
		
		ModelAndView disable = new ModelAndView();
		disable.setViewName("disposal_refurb");
		
		List<disableDTO> select = service.select(dto);
		disable.addObject("select", select);
		
		
		return disable;
	}
}
