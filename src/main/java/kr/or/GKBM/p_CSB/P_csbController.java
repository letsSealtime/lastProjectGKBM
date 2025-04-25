package kr.or.GKBM.p_CSB;

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
import kr.or.GKBM.p_CPG.P_disposalDTO;

@Controller
public class P_csbController {

	@Autowired
	private P_csbDAO csbDAO;

	@Autowired
	private P_consumregDAO p_conDAO;

	// [전체조회] 수불 목록 (GET)
	@RequestMapping(value = "/p_CSB", method = RequestMethod.GET)
	public String list(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int pageSize, @RequestParam(required = false) String searchKeyword,
			Model model) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("searchKeyword", searchKeyword != null ? searchKeyword.trim() : "");
		params.put("startRow", (currentPage - 1) * pageSize + 1);
		params.put("endRow", currentPage * pageSize);

		List<P_csbDTO> resultList = csbDAO.selectCsbList(params);
		int totalCount = csbDAO.selectCsbTotalCount(params);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		model.addAttribute("resultList", resultList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchKeyword", searchKeyword);


		List<P_consumregDTO> consumregList = p_conDAO.selectAllConsumreg();
		model.addAttribute("consumregList", consumregList);

		return "p_CSB.tiles";
	}

	// [등록] 수불 기록 (POST)
	@RequestMapping(value = "/p_CSBinsert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestBody P_csbDTO dto) {
		try {
			return csbDAO.insertCsb(dto) > 0 ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	// [수정] 수불 기록 (POST)
	@RequestMapping(value = "/p_CSBupdate", method = RequestMethod.POST)
	@ResponseBody
	public String update(@RequestBody P_csbDTO dto) {
		try {
			return csbDAO.updateCsb(dto) > 0 ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	// [삭제] 수불 기록 (POST)
	@RequestMapping(value = "/p_CSBdelete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestBody Map<String, Object> requestData) {
		try {
			String receiptpaymentid = (String) requestData.get("receipt_payment_id");
			String consumablesCode = (String) requestData.get("consumables_code");
			int log_count = (int) requestData.get("log_count");

			P_csbDTO dto = new P_csbDTO();
			dto.setReceipt_payment_id(receiptpaymentid);
			dto.setConsumables_code(consumablesCode);
			dto.setLog_count(log_count);

			csbDAO.deleteCsb(dto);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

}
