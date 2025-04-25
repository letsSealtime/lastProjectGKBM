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
		
		ModelAndView select_MV = new ModelAndView();
		select_MV.setViewName("disposal_refurb.tiles");
		
		List<disableDTO> select = service.select(dto);
		select_MV.addObject("select", select);
		select_MV.addObject("line", dto.getLine());
		select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
		select_MV.addObject("viewCount", dto.getViewCount());
		select_MV.addObject("page", dto.getPage());
		select_MV.addObject("begin", dto.getBegin());
		select_MV.addObject("end", dto.getEnd());
		
		
		return select_MV;
	}
}
