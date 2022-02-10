package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class ModifyPasswordAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String origin_passwd = request.getParameter("origin_passwd");
		String passwd = request.getParameter("passwd");
		String user_id = (String)session.getAttribute("user_id");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.checkMember(id);
		boolean check = false;

		if(member!=null && id.equals(user_id)) {
			check = member.isCheckedPassword(origin_passwd);
		}	
		if(check) {
			dao.updatePassword(passwd,user_number);
		}
		
		request.setAttribute("check", check);
		return "/WEB-INF/views/member/modifyPassword.jsp";
	}

}
