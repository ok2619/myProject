package kr.board.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class WriteFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 글쓰기->회원제서비스
		HttpSession session = request.getSession();		
		Integer user_num = (Integer)session.getAttribute("user_number"); 
		//로그인 안 된 경우
		if(user_num==null){	
			return "redirect:/member/loginForm.do";
		}		
		
		//로그인 된 경우
		return "/WEB-INF/views/board/writeForm.jsp";
	}

}
