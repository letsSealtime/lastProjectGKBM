package kr.or.GKBM.report;

import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ProductionDAO productionDAO;

    @Autowired
    private FinancialDAO financialDAO;

    @Autowired
    private DefectDAO defectDAO;

    @GetMapping("")
    public String showReportPage() {
        return "reporting";
    }
    
    @GetMapping("/production")
    @ResponseBody
    public List<ProductionDTO> getProductionData() {
        return productionDAO.selectProductionByUnit(null); // 전체 불러오기용 (필요 시 파라미터 전달)
    }

    @GetMapping("/financial")
    @ResponseBody
    public List<FinancialDTO> getFinancialData() {
        return financialDAO.selectAll(); // 전체 매출 및 영업이익
    }

    @GetMapping("/defect")
    @ResponseBody
    public List<DefectDTO> getDefectData() {
        return defectDAO.selectDefectByUnit(null); // 전체 불량률
    }
}
