package kr.or.GKBM.work_method;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class P_work_methodController {
	@Autowired
	P_work_methodDAO wmdao;

	// 테이블 전체리스트

	@RequestMapping(value = "/work_method2", method = { RequestMethod.GET, RequestMethod.POST })
	public String material_in_out(@ModelAttribute P_work_methodDTO wmDTO, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

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
		wmDTO.setStartRow(startRow);
		wmDTO.setEndRow(endRow);

		// 전체 목록을 가져옵니다 (페이지네이션된 결과)
		List<P_work_methodDTO> list = wmdao.fulltableList2_6(wmDTO);

		// 전체 데이터의 개수를 가져와서 전체 페이지 수를 계산
		int totalCount = wmdao.Count_2_6(wmDTO);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		// 모델에 필요한 정보를 추가
		model.addAttribute("list", list);
		model.addAttribute("wmDTO", wmDTO);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);

		return "P_work_method.tiles";
	}

	// 추가
	@RequestMapping(value = "/p_work_method", method = { RequestMethod.GET, RequestMethod.POST })
	public String addition(MultipartHttpServletRequest request, HttpServletResponse response)
			throws Exception, ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		// 1. 파일 꺼내기
		MultipartFile file = request.getFile("work_file");

		// 2. 나머지 폼 데이터 꺼내기
		String work = request.getParameter("work");
		int consumption = Integer.parseInt(request.getParameter("consumption"));
		int sku_id = Integer.parseInt(request.getParameter("sku_id"));

		// 3. 파일 저장
		String filePath = null;
		if (file != null && !file.isEmpty()) {
			String uploadDir = "D:\\last_project\\src\\main\\webapp\\resources\\img1";
			File dir = new File(uploadDir);
			if (!dir.exists())
				dir.mkdirs();

			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			File dest = new File(dir, fileName);
			file.transferTo(dest);

			filePath = "/resources/img1/" + fileName;
		}

		// 4. DTO에 값 세팅
		P_work_methodDTO wmDTO = new P_work_methodDTO();
		wmDTO.setWork(work);
		wmDTO.setConsumption(consumption);
		wmDTO.setSku_id(sku_id);
		wmDTO.setWork_file(filePath);
		int select20 = wmdao.addition_2_6(wmDTO);

		return "redirect:work_method2";
	}

	// 삭제
	@RequestMapping(value = "/p_work_methodDelete", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(HttpServletRequest request) {
		String[] ibIds = request.getParameterValues("work_method");

		if (ibIds != null) {
			for (String idStr : ibIds) {
				String id = (idStr);
				P_work_methodDTO delDto = new P_work_methodDTO();
				delDto.setWork_method(id);
				wmdao.delete_2_6(delDto);
			}
		}
		return "redirect:work_method2";
	}

	// 수정을위한 업데이트
//	@RequestMapping(value = "/p_work_methodudpateList", method = RequestMethod.POST)
//	public String udpateList(P_work_methodDTO wmDTO){
//		
//		
//		 
//		// DB 업데이트
//		int select20 = wmdao.udpate_2_6(wmDTO);
//		System.out.println("select20" + select20);
//
//		return "redirect:work_method2";
//	}
	
	// 수정(업데이트) 처리 메서드 (파일 업로드 지원 버전)
	@RequestMapping(value = "/p_work_methodudpateList", method = RequestMethod.POST)
	public String udpateList(MultipartHttpServletRequest request) throws Exception {
	    // 1. 파일 파라미터 추출
	    MultipartFile file = request.getFile("work_file");
	    
	    // 2. 텍스트 파라미터 추출
	    String work_method = request.getParameter("work_method");
	    String work = request.getParameter("work");
	    int consumption = Integer.parseInt(request.getParameter("consumption"));
	    int sku_id = Integer.parseInt(request.getParameter("sku_id"));
	    
	    // 3. DTO 객체 생성 및 값 설정
	    P_work_methodDTO wmDTO = new P_work_methodDTO();
	    wmDTO.setWork_method(work_method);
	    wmDTO.setWork(work);
	    wmDTO.setConsumption(consumption);
	    wmDTO.setSku_id(sku_id);
	    
	    // 4. 파일 처리 로직
	    if (file != null && !file.isEmpty()) {
	        String uploadDir = "D:\\last_project\\src\\main\\webapp\\resources\\img1";
	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs();
	        
	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        File dest = new File(dir, fileName);
	        try {
	            file.transferTo(dest); // dest 위치에 새 파일을 만듭니다.
	        } catch (IOException e) {
	            throw new RuntimeException("파일 저장 실패: " + e.getMessage());
	        }
	        
	        wmDTO.setWork_file("/resources/img1/" + fileName);
	    } else {
	        // 파일이 첨부되지 않았을 경우 기존 파일 경로 유지
	        String existingFilePath = request.getParameter("existing_file");
	        wmDTO.setWork_file(existingFilePath);
	    }
	    
	    // 5. DB 업데이트 실행
	    wmdao.udpate_2_6(wmDTO);
	    
	    return "redirect:work_method2";
	}

	//다운로드
	@GetMapping("/downloadWorkFile")
	public ResponseEntity<Resource> downloadFile(@RequestParam("filePath") String filePath) throws Exception {
		// filePath는 DB에 저장된 경로 (예: /resources/img1/12345_filename.jpg)
		String baseDir = "D:\\last_project\\src\\main\\webapp";
		String fullPath = baseDir + filePath.replace("/", File.separator);

		File file = new File(fullPath);
		if (!file.exists()) {
			throw new RuntimeException("파일이 존재하지 않습니다: " + fullPath);
		}

		// 파일명 추출
		String fileName = file.getName();
		String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

		Resource resource = new FileSystemResource(file);

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
				.contentType(MediaType.APPLICATION_OCTET_STREAM).body(resource);
	}

	// 상세보기
	@RequestMapping(value = "/P_work_method_View_details", method = { RequestMethod.GET, RequestMethod.POST })
	public String empOne99(HttpServletRequest request, Model model) {
		String contentType = request.getParameter("type");
		model.addAttribute("contentType", contentType);
		return "P_work_method_View_details.tiles";
	}

	// 원자재상세보기
	@RequestMapping(value = "/P_bom_View_details1", method = { RequestMethod.GET, RequestMethod.POST })
	public String empOne00(HttpServletRequest request, Model model, P_work_methodDTO wmDTO) {
		String contentType = request.getParameter("type");
		model.addAttribute("contentType", contentType);
		List<P_work_methodDTO> list00 = wmdao.fulltableList2_6(wmDTO);

		model.addAttribute("list00", list00);

		return "P_bom_View_details.tiles";
	}

}
