package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//세션객체 구하기 
		HttpSession session = request.getSession();
		//로그인된 상태에서만 myPage에 진입할수있도록 처리
		Integer user_number = (Integer)session.getAttribute("user_num"); //회원번호를 구한다
		//로그인 안 된 경우
		if(user_number==null){//로그인 안된경우
			return "redirect:/member/loginForm.do";
		}		
		//로그인 된 경우
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_number); //세션에 name: "user_number"으로 저장돼있는 value: user_num을 getMember에 넘겨 회원정보를 구해 자바빈에 담는다
		
		request.setAttribute("member", member); //"member"라는 이름으로 회원정보담긴 자바빈인 member를 저장
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/myPage.jsp";
	}

}
