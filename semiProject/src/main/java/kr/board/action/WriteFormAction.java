package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class WriteFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 글쓰기->회원제서비스
		//세션객체 구하기
		HttpSession session = request.getSession();
		//회원번호(user_num)구하기. 세션저장명:"user_number"
		Integer user_num = (Integer)session.getAttribute("user_number"); 
		//로그인 안 된 경우
		if(user_num==null){	
			return "redirect:/member/loginForm.do";
		}		
		//로그인 된 경우
		return "/WEB-INF/views/board/writeForm.jsp";
	}

}
