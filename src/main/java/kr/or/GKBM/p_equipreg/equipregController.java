package kr.or.GKBM.p_equipreg;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class equipregController {

    @Autowired
    equipregDAO eqDAO;

    // 전체 조회
    @RequestMapping(value = "/p_equipreg", method = RequestMethod.GET)
    public String listEquipments(@ModelAttribute equipregDTO dto, Model model) {
    	
        List<equipregDTO> list = eqDAO.selectAllP_eq3();
        
        model.addAttribute("resultList", list);
        model.addAttribute("dto", dto);
        
        return "p_equipreg";
    }

    // 등록
    @RequestMapping(value = "/p_equipreg", method = RequestMethod.POST)
    public String insertEquipment(@ModelAttribute equipregDTO eqDTO) {
        int result = eqDAO.insertP_eq(eqDTO);
        
        return "redirect:/p_equipreg";
    }
    
    // 삭제
    @RequestMapping(value = "/p_eqDelete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteEquipment(@RequestBody List<String> codes) {
        int totalDeleted = 0;
        for (String code : codes) {
            equipregDTO dto = new equipregDTO();
            dto.setFacility_code(code);
            totalDeleted += eqDAO.deleteP_eq(dto);
        }
        return totalDeleted > 0 ? "true" : "false";
    }

    // 수정
    @RequestMapping(value = "/p_eqUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String updateEquipment(@RequestBody equipregDTO eqDTO) {
        int result = eqDAO.updateP_eq(eqDTO);
        return result > 0 ? "true" : "false";
    }

}

