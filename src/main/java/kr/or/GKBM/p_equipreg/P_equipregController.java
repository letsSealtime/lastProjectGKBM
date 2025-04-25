package kr.or.GKBM.p_equipreg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class P_equipregController {

    @Autowired
    P_equipregDAO eqDAO;
    
    
    @RequestMapping(value = "/p_equipreg", method = RequestMethod.GET)
    public String listEquipments(
        @RequestParam(defaultValue = "1") int currentPage,
        @RequestParam(defaultValue = "10") int pageSize,
        @RequestParam(required = false) String searchKeyword,
        Model model) {

        // 검색어 공백 제거
        String trimmedKeyword = (searchKeyword != null) ? searchKeyword.trim() : "";

        // 파라미터 계산
        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;

        Map<String, Object> params = new HashMap<>();
        params.put("facility_code", trimmedKeyword);
        params.put("facility_name", trimmedKeyword);
        params.put("startRow", startRow);
        params.put("endRow", endRow);

        // 데이터 조회
        List<P_equipregDTO> resultList = eqDAO.selectP_equipregBySearchWithPaging(params);
        
        // 전체 레코드 수 조회
        int totalCount = eqDAO.selectTotalCount(params);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("resultList", resultList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("searchKeyword", trimmedKeyword); // 공백 제거된 검색어 전달
//        model.addAttribute("searchKeyword", "");


        return "p_equipreg.tiles";
    }

    
	// 검색
	@RequestMapping(value = "/p_eqsearch", method = RequestMethod.GET)
	public String listEquipments(@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			Model model) {
		Map<String, Object> params = new HashMap<>();
		params.put("facility_code", searchKeyword == null ? "" : searchKeyword);
		params.put("facility_name", searchKeyword == null ? "" : searchKeyword);

		List resultList = eqDAO.selectP_equipregBySearch(params);
		model.addAttribute("resultList", resultList);
		model.addAttribute("dto", new P_equipregDTO()); // 폼 초기화용
		return "p_equipreg";
	}


    // 등록

	@RequestMapping(value = "/p_equipreg", method = RequestMethod.POST)
	@ResponseBody
	public String insertEquipment(@RequestBody P_equipregDTO eqDTO) {
	    try {
	        int result = eqDAO.insertP_eq(eqDTO);
	        return result > 0 ? "success" : "fail";
	    } catch (DuplicateKeyException e) {
	        return "duplicate";
	    } catch (Exception e) {
	        return "fail";
	    }
	}

    
    // 삭제
    @RequestMapping(value = "/p_eqDelete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteEquipment(@RequestBody List<String> codes) {
        int totalDeleted = 0;
        for (String code : codes) {
            P_equipregDTO dto = new P_equipregDTO();
            dto.setFacility_code(code);
            totalDeleted += eqDAO.deleteP_eq(dto);
        }
        return totalDeleted > 0 ? "true" : "false";
    }

    // 수정
    @RequestMapping(value = "/p_eqUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String updateEquipment(@RequestBody P_equipregDTO eqDTO) {
        int result = eqDAO.updateP_eq(eqDTO);
        return result > 0 ? "true" : "false";
    }

}

