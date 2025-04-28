package kr.or.GKBM.bom;

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
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class P_bomController {
	@Autowired
	P_bomDAO wmdao;	
	
	// 테이블 전체리스트
		
		@RequestMapping(value = "/bom2", method = { RequestMethod.GET, RequestMethod.POST })
		public String material_in_out(@ModelAttribute P_bomDTO bDTO, Model model, HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
	
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
		    bDTO.setStartRow(startRow);
		    bDTO.setEndRow(endRow);
		    
		    // 전체 목록을 가져옵니다 (페이지네이션된 결과)
		    List<P_bomDTO> list = wmdao.fulltableList2_7(bDTO);

		    // 전체 데이터의 개수를 가져와서 전체 페이지 수를 계산
		    int totalCount = wmdao.Count_2_7(bDTO); 
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
		    
		    

		    // 모델에 필요한 정보를 추가
		    model.addAttribute("list", list);
		    model.addAttribute("bDTO", bDTO);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);
		    
		    
			

		    return "P_bom.tiles";
		}
		// 추가
		@RequestMapping(value = "/p_bom", method = { RequestMethod.GET, RequestMethod.POST })
		public String addition(@ModelAttribute P_bomDTO bDTO) {
			
			
			System.out.println(bDTO);
			int select20 = wmdao.addition_2_7(bDTO);

			return "redirect:bom2";
		}
		
		// 삭제
				@RequestMapping(value = "/p_bomDelete", method = { RequestMethod.GET, RequestMethod.POST })
				public String delete(HttpServletRequest request) {
					String[] ibIds = request.getParameterValues("bom_id");

					if (ibIds != null) {
						for (String idStr : ibIds) {
							int id = Integer.parseInt(idStr);
							P_bomDTO delDto = new P_bomDTO();
							delDto.setBom_id(id);
							wmdao.delete_2_7(delDto); 
						}
					}
					return "redirect:bom2";
				}
				
				// 수정을위한 업데이트
				@RequestMapping(value = "/p_bomudpateList", method = { RequestMethod.GET, RequestMethod.POST })
				public String udpateList(@ModelAttribute P_bomDTO bDTO) {
					// 실제 업데이트
					System.out.println(bDTO);
					int select20 = wmdao.udpate_2_7(bDTO);
					System.out.println("select20" + select20);

					// 전체목록으로 리턴

					return "redirect:bom2";
				}
				
				
				// 상세보기
				@RequestMapping(value = "/P_work_method_View_details1", method = { RequestMethod.GET, RequestMethod.POST })
				public String empOne99(HttpServletRequest request, Model model) {
					String contentType = request.getParameter("type");
					model.addAttribute("contentType", contentType);
					return "P_work_method_View_details.tiles";
				}
				
				// 완제품 필요한 원자재
				@RequestMapping(value = "/P_bom_View_details", method = { RequestMethod.GET, RequestMethod.POST })
				public String empOne00(
				    HttpServletRequest request, 
				    Model model, 
				    @RequestParam("consumption") int consumption //  consumption 파라미터 추가
				) {
				    String contentType = request.getParameter("type");
				    model.addAttribute("contentType", contentType);

				    // 원자재별 곱셈 계산
				    int bristle = consumption;   // 칫솔모
				    int handle = consumption;    // 칫솔대
				    int rubber = consumption * 2; // 고무

				    model.addAttribute("bristle", bristle);
				    model.addAttribute("handle", handle);
				    model.addAttribute("rubber", rubber);

				    return "P_bom_View_details.tiles";
				}




				
				


}
