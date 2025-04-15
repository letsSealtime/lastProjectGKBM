package kr.or.GKBM.sku;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class P_skuController {
	@Autowired
	P_skuDAO empdao;

	
//	// 테이블 전체리스트
//	@RequestMapping(value = "/emp5", method = { RequestMethod.GET, RequestMethod.POST })
//	public String selectEmpList(@ModelAttribute EmpDTO dto, Model model, HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		
//
//		System.out.println(dto);
//		
//		List<EmpDTO> list = empdao.selectEmpList();
//
//		
//		model.addAttribute("list", list);
//		model.addAttribute("dto", dto);
//
//
//		return "emp";
//	}
	// 테이블 전체리스트
	@RequestMapping(value = "/p_sku2", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectEmpList(@ModelAttribute P_skuDTO skuDTO, Model model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		

		System.out.println(skuDTO);
		
		List<P_skuDTO> list = empdao.selectEmpList();

		
		model.addAttribute("list", list);
		model.addAttribute("skuDTO", skuDTO);


		return "P_sku";
	}

	// dao에서 가져온 추가
		@RequestMapping(value = "/p_sku", method = { RequestMethod.GET, RequestMethod.POST })
		public String addition1(@ModelAttribute P_skuDTO skuDTO) {
			System.out.println(skuDTO);
			int select20 = empdao.addition(skuDTO);

			return "redirect:p_sku2";
		}
		
		// dao에서 가져온 삭제
		@RequestMapping(value = "/p_skuDelete", method = { RequestMethod.GET, RequestMethod.POST })
		public String delete1(HttpServletRequest request) {
			String[] skuIds = request.getParameterValues("sku_id");

			if (skuIds != null) {
				for (String idStr : skuIds) {
					int id = Integer.parseInt(idStr);
					P_skuDTO delDto = new P_skuDTO();
					delDto.setSku_id(id);
					empdao.delete(delDto); 
				}
			}
			return "redirect:p_sku2";
		}

		// sku_code로 조회
		@RequestMapping(value = "/searchBySkuCode", method = { RequestMethod.GET, RequestMethod.POST })
		public String searchBySkuCode(@ModelAttribute P_skuDTO skuDTO, Model model) {
		    List<P_skuDTO> list = empdao.like(skuDTO);
		    model.addAttribute("list", list);
		    model.addAttribute("skuDTO", skuDTO);
		    
		    return "redirect:p_sku2"; // 기존 JSP로 리다이렉트
		}
		

}
