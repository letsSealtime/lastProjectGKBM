package kr.or.GKBM.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {

	@Autowired
	BoardDAO boardDAO;
	
	@RequestMapping(value = "/board")
	public String SelectBoardList(
			@ModelAttribute
			BoardDTO boardDTO, Model model, HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {
		
		
		return "board";
		
	}
	
	
	
}
