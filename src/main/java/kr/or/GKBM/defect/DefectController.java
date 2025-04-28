package kr.or.GKBM.defect;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.GKBM.work.WorkDTO;

@Controller
public class DefectController {
	
	@Autowired
	DefectService DefectServiceImpl;

	@ResponseBody
	@RequestMapping(value = "/defect", method= {RequestMethod.GET})
	public ModelAndView defectEnter(@ModelAttribute DefectDTO dto) {

		System.out.println("work 페이지 진입");

		ModelAndView select_MV = new ModelAndView();
		select_MV.setViewName("defect.tiles");

		List<DefectDTO> sku_select = DefectServiceImpl.code_select(dto);
		select_MV.addObject("select", sku_select);

		System.out.println(sku_select);
		
		select_MV.addObject("line", dto.getLine());
		select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
		select_MV.addObject("viewCount", dto.getViewCount());
		select_MV.addObject("page", dto.getPage());
		select_MV.addObject("begin", dto.getBegin());
		select_MV.addObject("end", dto.getEnd());

		return select_MV;
	}
	
	@ResponseBody
	@RequestMapping(value = "/defect", method= {RequestMethod.PUT})
	public String defectinsert(@RequestBody DefectDTO dto) {

		System.out.println("defect 삽입 진입");

		ModelAndView select_MV = new ModelAndView();
		select_MV.setViewName("work");

		int insert = DefectServiceImpl.insert(dto);

		return "defect.tiles";
	}

}
