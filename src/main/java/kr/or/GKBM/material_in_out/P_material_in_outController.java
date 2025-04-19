package kr.or.GKBM.material_in_out;

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
public class P_material_in_outController {
	@Autowired
	P_material_in_outDAO miodao;
	
	// 테이블 전체리스트
		
		@RequestMapping(value = "/material_in_out2", method = { RequestMethod.GET, RequestMethod.POST })
		public String material_in_out(@ModelAttribute P_material_in_outDTO mioDTO, Model model, HttpServletRequest request, HttpServletResponse response)
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
		    mioDTO.setStartRow(startRow);
		    mioDTO.setEndRow(endRow);
		    
		    // 전체 목록을 가져옵니다 (페이지네이션된 결과)
		    List<P_material_in_outDTO> list = miodao.fulltableList2_1(mioDTO);

		    // 전체 데이터의 개수를 가져와서 전체 페이지 수를 계산
		    int totalCount = miodao.Count_2_1(mioDTO); 
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		    // 모델에 필요한 정보를 추가
		    model.addAttribute("list", list);
		    model.addAttribute("mioDTO", mioDTO);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);

		    return "P_material_in_out";
		}
		// 추가
		@RequestMapping(value = "/p_material_in_out", method = { RequestMethod.GET, RequestMethod.POST })
		public String addition(@ModelAttribute P_material_in_outDTO mioDTO) {
			System.out.println(mioDTO);
			int select20 = miodao.addition_2_1(mioDTO);

			return "redirect:material_in_out2";
		}
		
		// 삭제
				@RequestMapping(value = "/p_material_in_outDelete", method = { RequestMethod.GET, RequestMethod.POST })
				public String delete(HttpServletRequest request) {
					String[] ibIds = request.getParameterValues("ib_id");

					if (ibIds != null) {
						for (String idStr : ibIds) {
							int id = Integer.parseInt(idStr);
							P_material_in_outDTO delDto = new P_material_in_outDTO();
							delDto.setIb_id(id);
							miodao.delete_2_1(delDto); 
						}
					}
					return "redirect:material_in_out2";
				}
	
}
