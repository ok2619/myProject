package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class DetailUserAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 3) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//관리자로 로그인 한 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		MemberVO member = new MemberVO();
		member.setUser_num(Integer.parseInt(request.getParameter("user_num")));
		member.setAuth(Integer.parseInt(request.getParameter("auth")));
		member.setName(request.getParameter("name"));
		member.setPhone(request.getParameter("phone"));
		member.setZipcode(request.getParameter("zipcode"));
		member.setAddress1(request.getParameter("address1"));
		member.setAddress2(request.getParameter("address2"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.updateMemberByAdmin(member);
		
		return "/WEB-INF/views/member/detailUser.jsp";
	}

}
