package kr.or.GKBM.work;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WorkController {

	@Autowired
	WorkService WorkServiceImpl;

	@RequestMapping(value = "/work", method = { RequestMethod.GET })
	public ModelAndView workEnter(@ModelAttribute WorkDTO dto) {

		System.out.println("work 페이지 진입");

		ModelAndView select_MV = new ModelAndView();
		select_MV.setViewName("work");

		Map map = WorkServiceImpl.code_select();
		select_MV.addObject("select", map.get("code_select"));
		select_MV.addObject("select_1", map.get("select"));

		return select_MV;
	}
	
	@ResponseBody
	@RequestMapping(value = "/work", method = { RequestMethod.POST })
	public List<WorkDTO> detail(@RequestBody WorkDTO dto) {

		System.out.println("work 세부조건 조회");

		List<WorkDTO> select = WorkServiceImpl.detail_select(dto);
		
		System.out.println(select);

		return select;
	}
	
	@ResponseBody
	@RequestMapping(value = "/work", method = { RequestMethod.PUT })
	public int insert(@RequestBody WorkDTO dto) {
		
		System.out.println("work 삽입 조회");
		
		System.out.println("dto.getC_pn(): " + dto.getC_pn());
		System.out.println("dto.getC_b(): " + dto.getC_b());
		System.out.println("dto.getC_d(): " + dto.getC_d());		

		int insert = WorkServiceImpl.insert(dto);
		
		return insert;
	}

}
