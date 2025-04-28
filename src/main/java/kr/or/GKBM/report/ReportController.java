package kr.or.GKBM.report;

import org.springframework.stereotype.Controller;

import java.util.HashMap;
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
    
    
    // 리포팅 : 기본 경영 실적 페이지 
    @GetMapping("")
    public String ReportPage() {
        return "report_financial";
    }
    
    // 경영 실적 페이지
    @GetMapping("/page")
    public String showReportPage() {
        return "report_financial";
    }
    
    // 생산 실적 페이지
    @GetMapping("/production/page")
    public String showProductionPage() {
        return "report_production"; 
    }
    
    // 불량품 추이 페이지
    @GetMapping("/defect/page")
    public String showDefectPage() {
        return "report_defect"; 
    }
    
    // 경영 실적
    @GetMapping("/financial")
    @ResponseBody
    public List<FinancialDTO> getFinancialData(@RequestParam(required = false) String startDate,
                                               @RequestParam(required = false) String endDate) {
        if (startDate != null && endDate != null) {
            Map<String, String> params = new HashMap<>();
            params.put("startDate", startDate);
            params.put("endDate", endDate);
            return financialDAO.selectByPeriod(params);
        }
        return financialDAO.selectAll();
    }
    
    // 메인 대시 페이지
    @GetMapping("/main")
    public String showMainDashBoard() {
        return "mainpage_dashboard"; 
    }
    
    // 생산 실적
    @GetMapping("/production")
    @ResponseBody
    public List<ProductionDTO> getProductionData(@RequestParam Map<String, String> param) {
    	return productionDAO.selectProductionByUnit(param); // 전체 불러오기용 (필요 시 파라미터 전달)
    }
    
    // 생산 실적 (상세)
    @GetMapping("production/detailed")
    @ResponseBody
    public List<ProductionDTO> getDetailedProductionData() {
        return productionDAO.selectDetailedProduction();
    }

    // 불량품 상황
    @GetMapping("/defect")
    @ResponseBody
    public List<DefectDTO> getDefectRateData(@RequestParam(value = "unit", defaultValue = "month") String unit) {
        Map<String, String> param = new HashMap<>();
        param.put("unit", unit);
        return defectDAO.selectDefectRateByUnit(param);
    }
}
