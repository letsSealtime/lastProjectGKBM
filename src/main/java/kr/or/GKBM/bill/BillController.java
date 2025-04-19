package kr.or.GKBM.bill;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BillController {

	@Autowired
	BillService BillServiceImpl;

	@RequestMapping(value = "/bill", method = { RequestMethod.GET })
	public ModelAndView billEnter(@ModelAttribute BillDTO dto) {

		System.out.println("bill 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		ModelAndView select_MV = new ModelAndView();

		if ("select".equals(dto.getHidden())) {

			if ((dto.getC_d() == null || dto.getC_d().isBlank()) && (dto.getC_c() == null || dto.getC_c().isBlank())
					&& (dto.getC_q() == null || 0 > dto.getC_q())
					&& (dto.getC_b() == null || 0 > dto.getC_b())
					&& (dto.getC_i() == null || dto.getC_i().isBlank())
					&& (dto.getC_n() == null || dto.getC_n().isBlank())
					&& (dto.getC_p() == null || dto.getC_p().isBlank())
					&& (dto.getC_j() == null || dto.getC_j().isBlank())) {
				
				List<BillDTO> select = BillServiceImpl.selectALL(dto);
				
				select_MV.setViewName("bill");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			} else {
				List<BillDTO> select = BillServiceImpl.select(dto);
				
				select_MV.setViewName("bill");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			}

		} else {
			List<BillDTO> select = BillServiceImpl.selectALL(dto);
			
			select_MV.setViewName("bill");
			select_MV.addObject("select", select);
			select_MV.addObject("line", dto.getLine());
			select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
			select_MV.addObject("viewCount", dto.getViewCount());
			select_MV.addObject("page", dto.getPage());
			select_MV.addObject("begin", dto.getBegin());
			select_MV.addObject("end", dto.getEnd());
		}

		return select_MV;
	}

	@ResponseBody
	@RequestMapping(value = "/bill", method = RequestMethod.PUT)
	public int billInsert(@RequestBody BillDTO dto) {

		System.out.println("bill 추가 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getC_d());
		System.out.println(dto.getC_c());
		System.out.println(dto.getC_q());
		System.out.println(dto.getC_b());
		System.out.println(dto.getC_i());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_p());
		System.out.println(dto.getC_j());

		int insert = BillServiceImpl.insert(dto);

		return insert;
	}

	@ResponseBody
	@RequestMapping(value = "/bill", method = RequestMethod.DELETE)
	public int billDelete(@RequestBody BillDTO dto) {

		System.out.println("bill 삭제 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getCheck());

		int delete = BillServiceImpl.delete(dto);

		return delete;
	}

	@ResponseBody
	@RequestMapping(value = "/bill", method = RequestMethod.POST)
	public int billUpdate(@RequestBody BillDTO dto) {

		System.out.println("bill 수정 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getC_d());
		System.out.println(dto.getC_c());
		System.out.println(dto.getC_q());
		System.out.println(dto.getC_b());
		System.out.println(dto.getC_i());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_p());
		System.out.println(dto.getC_j());

		int update = BillServiceImpl.update(dto);

		return update;
	}

}