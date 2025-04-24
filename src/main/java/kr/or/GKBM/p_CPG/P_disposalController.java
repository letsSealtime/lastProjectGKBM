package kr.or.GKBM.p_CPG;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.GKBM.p_CMB.P_consumregDAO;
import kr.or.GKBM.p_CMB.P_consumregDTO;

@Controller
public class P_disposalController {

	@Autowired
	P_disposalDAO disposalDAO;

	@Autowired
	P_consumregDAO p_conDAO;

	// [전체조회] 폐기 목록 + 검색 + 페이징
	@RequestMapping(value = "/p_CPG", method = RequestMethod.GET)
	public String list(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int pageSize, @RequestParam(required = false) String searchKeyword,
			Model model) {

		Map<String, Object> params = new HashMap<>();
		params.put("searchKeyword", searchKeyword != null ? searchKeyword.trim() : "");
		params.put("startRow", (currentPage - 1) * pageSize + 1);
		params.put("endRow", currentPage * pageSize);

		List<P_disposalDTO> resultList = disposalDAO.selectDisposalList(params);
		int totalCount = disposalDAO.selectDisposalTotalCount(params);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		model.addAttribute("resultList", resultList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchKeyword", searchKeyword);

		// P_consumregDAO에서 전체 소모품 목록 조회
		List<P_consumregDTO> consumregList = p_conDAO.selectAllConsumreg();
		model.addAttribute("consumregList", consumregList);

		return "/p_CPG";
	}

	// [등록] 폐기 처리
	@RequestMapping(value = "/p_CPGinsert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestBody P_disposalDTO dto) {
		int result = disposalDAO.insertDisposal(dto);
		return result > 0 ? "success" : "fail";
	}

	// [수정] 폐기 정보 수정
	@RequestMapping(value = "/p_CPGupdate", method = RequestMethod.POST)
	@ResponseBody
	public String update(@RequestBody P_disposalDTO dto) {
		try {
			int result = disposalDAO.updateDisposal(dto);
			return result > 0 ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	// [삭제] 폐기 기록 삭제
	@RequestMapping(value = "/p_CPGdelete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestBody Map<String, Object> requestData) {
		try {
			String disposalId = (String) requestData.get("disposal_id");
			String consumablesCode = (String) requestData.get("consumables_code");
			int count = (int) requestData.get("count");

			P_disposalDTO dto = new P_disposalDTO();
			dto.setDisposal_id(disposalId);
			dto.setConsumables_code(consumablesCode);
			dto.setCount(count);

			disposalDAO.deleteDisposal(dto);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
}
