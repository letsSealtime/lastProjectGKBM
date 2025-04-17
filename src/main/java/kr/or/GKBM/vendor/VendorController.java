package kr.or.GKBM.vendor;

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
public class VendorController {

	@Autowired
	VendorService VendorServiceImpl;

	@RequestMapping(value = "/vendor", method = { RequestMethod.GET })
	public ModelAndView vendorEnter(@ModelAttribute VendorDTO dto) {

		System.out.println("Vendor 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		ModelAndView select_MV = new ModelAndView();

		if ("select".equals(dto.getHidden())) {

			if ((dto.getC_c() == null || dto.getC_c().trim().isEmpty())
					&& (dto.getC_n() == null || dto.getC_n().trim().isEmpty())
					&& (dto.getC_m() == null || dto.getC_m().trim().isEmpty())
					&& (dto.getC_p() == null || dto.getC_p().trim().isEmpty())
					&& (dto.getC_a() == null || dto.getC_a().trim().isEmpty())
					&& (dto.getC_i() == null || dto.getC_i().trim().isEmpty())) {
				List<VendorDTO> select = VendorServiceImpl.selectALL(dto);
				select_MV.setViewName("vendor");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			} else {
				List<VendorDTO> select = VendorServiceImpl.select(dto);
				select_MV.setViewName("vendor");
				select_MV.addObject("select", select);
				select_MV.addObject("line", dto.getLine());
				select_MV.addObject("lastpage", dto.getLine() / dto.getViewCount());
				select_MV.addObject("viewCount", dto.getViewCount());
				select_MV.addObject("page", dto.getPage());
				select_MV.addObject("begin", dto.getBegin());
				select_MV.addObject("end", dto.getEnd());
			}

		} else {
			List<VendorDTO> select = VendorServiceImpl.selectALL(dto);
			select_MV.setViewName("vendor");
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
	@RequestMapping(value = "/vendor", method = RequestMethod.PUT)
	public int vendorInsert(@RequestBody VendorDTO dto) {

		System.out.println("Vendor 추가 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());
		
		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_m());
		System.out.println(dto.getC_p());
		System.out.println(dto.getC_a());
		System.out.println(dto.getC_i());

		int insert = VendorServiceImpl.insert(dto);

		return insert;
	}
	
	@ResponseBody
	@RequestMapping(value = "/vendor", method = RequestMethod.DELETE)
	public int vendorDelete(@RequestBody VendorDTO dto) {

		System.out.println("Vendor 삭제 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());
		
		System.out.println(dto.getCheck());
		
		int delete = VendorServiceImpl.delete(dto);

		return delete;
	}
	
	@ResponseBody
	@RequestMapping(value = "/vendor", method = RequestMethod.POST)
	public int vendorUpdate(@RequestBody VendorDTO dto) {

		System.out.println("Vendor 수정 페이지 진입");
		System.out.println("진입 방법: " + dto.getHidden());

		System.out.println(dto.getC_c());
		System.out.println(dto.getC_n());
		System.out.println(dto.getC_m());
		System.out.println(dto.getC_p());
		System.out.println(dto.getC_a());
		System.out.println(dto.getC_i());
		
		int update = VendorServiceImpl.update(dto);

		return update;
	}



}
