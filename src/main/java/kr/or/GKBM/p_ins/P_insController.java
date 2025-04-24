package kr.or.GKBM.p_ins;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.GKBM.p_equipreg.P_equipregDAO;
import kr.or.GKBM.p_equipreg.P_equipregDTO;
import kr.or.GKBM.p_repair.P_repairDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 설비점검 Controller
@Controller
public class P_insController {

	@Autowired
	private P_insDAO p_insDAO;

	@Autowired
	P_equipregDAO equipregDAO;

	// 설비점검 전체조회 및 검색(페이징)
	@RequestMapping(value = "/p_ins", method = RequestMethod.GET)
	public String list(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int pageSize, @RequestParam(required = false) String searchKeyword,
			Model model) {

		String trimmedKeyword = (searchKeyword != null) ? searchKeyword.trim() : "";

		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;

		// 검색
		Map<String, Object> params = new HashMap<>();
		params.put("facility_code", trimmedKeyword);
		params.put("inspection_content", trimmedKeyword);
		params.put("startRow", startRow);
		params.put("endRow", endRow);

		// 점검 목록 및 페이징 정보 조회
		List<P_insDTO> resultList = p_insDAO.selectP_insBySearchWithPaging(params);
		int totalCount = p_insDAO.selectTotalCount(params);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		model.addAttribute("resultList", resultList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchKeyword", trimmedKeyword);
//		model.addAttribute("searchKeyword", "");

		List facilityList = equipregDAO.selectAllFacilities();
		model.addAttribute("facilityList", facilityList);

		return "p_ins";
	}

	// 설비점검 등록
	@RequestMapping(value = "/p_insInsert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestBody P_insDTO dto) {
		int result = p_insDAO.insertP_ins(dto);
		return result > 0 ? "success" : "fail";
	}

	// 설비점검 수정
	@RequestMapping(value = "/p_insUpdate", method = RequestMethod.POST)
	@ResponseBody
	public String update(@RequestBody P_insDTO dto) {
		int result = p_insDAO.updateP_ins(dto);
		return result > 0 ? "success" : "fail";
	}

	// 설비점검 삭제
	@RequestMapping(value = "/p_insDelete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestBody List<Integer> inspectionIds) {
		int totalDeleted = 0;
		for (Integer id : inspectionIds) {
            P_insDTO dto = new P_insDTO();
            dto.setInspection_id(id);
            totalDeleted += p_insDAO.deleteP_ins(dto);
        }
		return totalDeleted > 0 ? "success" : "fail";
	}
}
