package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class DetailUserFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 3) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//관리자로 로그인 한 경우
		int user_num = Integer.parseInt(request.getParameter("user_num"));
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		request.setAttribute("member", member);
		
		//JSP경로 반환
		return "/WEB-INF/views/member/detailUserForm.jsp";
	}

}
