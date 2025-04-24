package kr.or.GKBM.material_in_out3;

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
public class P_material_in_outController3 {
	@Autowired
	P_material_in_outDAO3 miodao;
	
	// 테이블 전체리스트
		
		@RequestMapping(value = "/material_in_out2_3", method = { RequestMethod.GET, RequestMethod.POST })
		public String material_in_out(@ModelAttribute P_material_in_outDTO3 mioDTO3, Model model, HttpServletRequest request, HttpServletResponse response)
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
		    mioDTO3.setStartRow(startRow);
		    mioDTO3.setEndRow(endRow);
		    
		    // 전체 목록을 가져옵니다 (페이지네이션된 결과)
		    List<P_material_in_outDTO3> list = miodao.fulltableList2_3(mioDTO3);

		    // 전체 데이터의 개수를 가져와서 전체 페이지 수를 계산
		    int totalCount = miodao.Count_2_3(mioDTO3); 
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		    // 모델에 필요한 정보를 추가
		    model.addAttribute("list", list);
		    model.addAttribute("mioDTO3", mioDTO3);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);

		    return "P_material_in_out3.tiles";
		}
		

	
}
