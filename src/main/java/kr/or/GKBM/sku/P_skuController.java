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

	// 테이블 전체리스트
	// 및 부분조회 select30
//	@RequestMapping(value = "/p_sku2", method = { RequestMethod.GET, RequestMethod.POST })
//	public String selectEmpList(@ModelAttribute P_skuDTO skuDTO, Model model, HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		
//
//		System.out.println(skuDTO);
//		
//		List<P_skuDTO> list = empdao.fulltableList(skuDTO);
//
//		
//		model.addAttribute("list", list);
//		model.addAttribute("skuDTO", skuDTO);
//		model.addAttribute("select30", skuDTO);
//
//
//		return "P_sku";
//	}
	// 지금이건 전체조회를 하는데 페이징네이션때문에 1부터 10까지만 나온다
	// 그리고 조회도 가능
	@RequestMapping(value = "/p_sku2", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectEmpList(@ModelAttribute P_skuDTO skuDTO, Model model, HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    // 현재 페이지 번호를 받아옵니다. 기본값은 1입니다.
	    int currentPage = 1;
	    if (request.getParameter("currentPage") != null) {
	        currentPage = Integer.parseInt(request.getParameter("currentPage"));
	    }
	    
	    // 페이지 크기 10개씩 표시
	    int pageSize = 10;  
	    
	    // startRow와 endRow 계산
	    int startRow = (currentPage - 1) * pageSize + 1;
	    int endRow = currentPage * pageSize;

	    // P_skuDTO에 startRow와 endRow를 설정
	    skuDTO.setStartRow(startRow);
	    skuDTO.setEndRow(endRow);
	    
	    // 전체 목록을 가져옵니다 (페이지네이션된 결과)
	    List<P_skuDTO> list = empdao.fulltableList(skuDTO);

	    // 전체 데이터의 개수를 가져와서 전체 페이지 수를 계산
	    int totalCount = empdao.Count(skuDTO); 
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    // 모델에 필요한 정보를 추가
	    model.addAttribute("list", list);
	    model.addAttribute("skuDTO", skuDTO);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);

	    return "P_sku";
	}

	
	

	// dao에서 가져온 추가
		@RequestMapping(value = "/p_sku", method = { RequestMethod.GET, RequestMethod.POST })
		public String addition(@ModelAttribute P_skuDTO skuDTO) {
			System.out.println(skuDTO);
			int select20 = empdao.addition(skuDTO);

			return "redirect:p_sku2";
		}
		
		// dao에서 가져온 삭제
		@RequestMapping(value = "/p_skuDelete", method = { RequestMethod.GET, RequestMethod.POST })
		public String delete(HttpServletRequest request) {
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

		
		
		// 수정을위한 업데이트
		@RequestMapping(value = "/udpateList", method = { RequestMethod.GET, RequestMethod.POST })
		public String udpateList(@ModelAttribute P_skuDTO skuDTO) {
			// 실제 업데이트
			System.out.println(skuDTO);
			int select20 = empdao.udpate(skuDTO);
			System.out.println("select20" + select20);

			// 전체목록으로 리턴

			return "redirect:p_sku2";
		}
		
		
		

}
