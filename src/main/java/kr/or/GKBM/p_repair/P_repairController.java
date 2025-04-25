package kr.or.GKBM.p_repair;

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

import kr.or.GKBM.p_equipreg.P_equipregDAO;
import kr.or.GKBM.p_equipreg.P_equipregDTO;

@Controller
public class P_repairController {

    @Autowired
    P_repairDAO repairDAO;
    
    @Autowired
    P_equipregDAO equipregDAO;

    
    

    // 전체조회 (페이징)
    @RequestMapping(value = "/p_repair", method = RequestMethod.GET)
    public String listRepairs(
            @RequestParam(defaultValue = "1") int currentPage,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String searchKeyword,
            Model model) {

        String trimmedKeyword = (searchKeyword != null) ? searchKeyword.trim() : "";

        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;

        // 검색
        Map<String, Object> params = new HashMap<>();
        params.put("facility_code", trimmedKeyword);
        params.put("repair_details", trimmedKeyword);
        params.put("startRow", startRow);
        params.put("endRow", endRow);

        List<P_repairDTO> resultList = repairDAO.selectP_repairBySearchWithPaging(params);
        int totalCount = repairDAO.selectTotalCount(params);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("resultList", resultList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("searchKeyword", trimmedKeyword);
//        model.addAttribute("searchKeyword", "");

        List<P_equipregDTO> facilityList = equipregDAO.selectAllFacilities();
        model.addAttribute("facilityList", facilityList);

        return "p_repair.tiles";
    }

    // 등록
    @RequestMapping(value = "/p_repair", method = RequestMethod.POST)
    @ResponseBody
    public String insertRepair(@RequestBody P_repairDTO repairDTO) {
        int result = repairDAO.insertP_repair(repairDTO);
        return result > 0 ? "success" : "fail";
    }

    // 삭제
    @RequestMapping(value = "/p_repairDelete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteRepair(@RequestBody List<Integer> repairIds) {
        int totalDeleted = 0;
        for (Integer repairId : repairIds) {
            P_repairDTO dto = new P_repairDTO();
            dto.setRepair_id(repairId);
            totalDeleted += repairDAO.deleteP_repair(dto);
        }
        return totalDeleted > 0 ? "true" : "false";
    }

    // 수정
    @RequestMapping(value = "/p_repairUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String updateRepair(@RequestBody P_repairDTO repairDTO) {
        int result = repairDAO.updateP_repair(repairDTO);
        return result > 0 ? "true" : "false";
    }

    
}
