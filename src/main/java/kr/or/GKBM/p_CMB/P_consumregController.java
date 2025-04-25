package kr.or.GKBM.p_CMB;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class P_consumregController {

    @Autowired
    P_consumregDAO conDAO;

    // 전체조회 및 검색(페이징)
    @RequestMapping(value = "/p_CMB", method = RequestMethod.GET)
    public String listConsumables(
        @RequestParam(defaultValue = "1") int currentPage,
        @RequestParam(defaultValue = "10") int pageSize,
        @RequestParam(required = false) String searchKeyword,
        Model model) {

        String trimmedKeyword = (searchKeyword != null) ? searchKeyword.trim() : "";
        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;

        Map<String, Object> params = new HashMap<>();
        params.put("consumables_code", trimmedKeyword);
        params.put("consumables_name", trimmedKeyword);
        params.put("startRow", startRow);
        params.put("endRow", endRow);

        List<P_consumregDTO> resultList = conDAO.selectP_consumregBySearchWithPaging(params);
        int totalCount = conDAO.selectTotalCount(params);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("resultList", resultList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("searchKeyword", trimmedKeyword);
        // 검색 초기화
//        model.addAttribute("searchKeyword", "");

        return "p_CMB.tiles";
    }

    // 등록
    @RequestMapping(value = "/p_CMB", method = RequestMethod.POST)
    @ResponseBody
    public String insertConsumable(@RequestBody P_consumregDTO conDTO) {
        try {
            int result = conDAO.insertP_con(conDTO);
            return result > 0 ? "success" : "fail";
        } catch (org.springframework.dao.DuplicateKeyException e) {
            return "duplicate";
        } catch (Exception e) {
            return "fail";
        }
    }


    // 삭제
    @RequestMapping(value = "/p_conDelete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteConsumable(@RequestBody List<String> codes) {
        int totalDeleted = 0;
        for (String code : codes) {
            P_consumregDTO dto = new P_consumregDTO();
            dto.setConsumables_code(code);
            totalDeleted += conDAO.deleteP_con(dto);
        }
        return totalDeleted > 0 ? "true" : "false";
    }

    // 수정
    @RequestMapping(value = "/p_conUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String updateConsumable(@RequestBody P_consumregDTO conDTO) {
        int result = conDAO.updateP_con(conDTO);
        return result > 0 ? "true" : "false";
    }
}
