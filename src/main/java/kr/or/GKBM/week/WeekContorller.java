package kr.or.GKBM.week;

import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.GKBM.vendor.VendorDTO;

@Controller
public class WeekContorller {

	@Autowired
	WeekService WeekServiceImpl;

	@RequestMapping(value = "/week", method = { RequestMethod.GET })
	public ModelAndView weekEnter(@ModelAttribute WeekDTO dto) {

		System.out.println("week 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		List<WeekDTO> sku_select = WeekServiceImpl.sku_select(dto);

		ModelAndView select_MV = new ModelAndView();
		select_MV.addObject("list", sku_select);
		
		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_w());
		System.out.println(dto.getC_y());
		System.out.println(dto.getC_k());
		System.out.println(dto.getC_i());

		if ("search".equals(dto.getHidden())) {

			if ((dto.getC_c() == null) && (dto.getC_i() == null) && (dto.getC_s() == null) && (dto.getC_y() == null)
					&& (dto.getC_w() == null)) {
				List<WeekDTO> select = WeekServiceImpl.selectALL(dto);
				select_MV.setViewName("week.tiles");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			} else {
				List<WeekDTO> select = WeekServiceImpl.select(dto);
				select_MV.setViewName("week.tiles");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			}

		} else {
			List<WeekDTO> select = WeekServiceImpl.selectALL(dto);
			select_MV.setViewName("week.tiles");
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
	@RequestMapping(value = "/week", method = { RequestMethod.PUT })
	public int weekInsert(@RequestBody WeekDTO dto) {

		System.out.println("Week 추가 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_w());
		System.out.println(dto.getC_y());
		System.out.println(dto.getC_k());
		System.out.println(dto.getC_i());

		LocalDate today = LocalDate.now();
		WeekFields weekFields = WeekFields.of(Locale.KOREA);

		dto.setC_y(today.getYear());
		dto.setC_w(today.get(weekFields.weekOfWeekBasedYear()));

		int insert = WeekServiceImpl.insert(dto);

		return insert;

	}

	@ResponseBody
	@RequestMapping(value = "/week", method = RequestMethod.DELETE)
	public int vendorDelete(@RequestBody WeekDTO dto) {

		System.out.println("week 삭제 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getCheck());

		int delete = WeekServiceImpl.delete(dto);

		return delete;
	}

	@ResponseBody
	@RequestMapping(value = "/week", method = RequestMethod.POST)
	public int vendorUpdate(@RequestBody WeekDTO dto) {

		System.out.println("week 수정 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_w());
		System.out.println(dto.getC_y());
		System.out.println(dto.getC_k());
		System.out.println(dto.getC_i());

		int update = WeekServiceImpl.update(dto);

		return update;
	}

}
