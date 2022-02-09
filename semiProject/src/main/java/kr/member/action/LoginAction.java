package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class LoginAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//loginForm에서 전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 반환 
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		//로그인 인증절차
		MemberDAO dao = MemberDAO.getInstance(); 
		//id 존재 여부 확인 (존재하면 MemberVO 객체 생성)
		MemberVO member = dao.checkMember(id);
		boolean check = false;
	
		if(member!=null){ //멤버 VO객체가 있음(생성됨)=아이디 존재
			//사용자가 입력한 비밀번호와 table에 저장된 비밀번호 일치 여부를 확인
			check=member.isCheckedPassword(passwd); //일치하면 check->true로 return
										// 사용자가 입력한 비밀번호 
			//로그인 실패시 auth 체크용
			request.setAttribute("auth", member.getAuth());
		}
		
		if(check){ //인증성공->check가 true되며 블럭 내용 실행(로그인처리)
			//세션객체 구하기(리퀘스트로부터 세션을 구해 세션객체생성을 한다.)
			HttpSession session = request.getSession();
			//세션에 로그인값(회원정보:회원번호,회원아이디,회원등급)저장
			session.setAttribute("user_number",member.getUser_num());
			session.setAttribute("user_id",member.getId());
			session.setAttribute("user_auth",member.getAuth());
			
			//인증 성공시 호출 (리다이렉트로 main.do 호출)
			return "redirect:/main/main.do";
			
		}
		//인증 실패시 호출 (포워드로 login.jsp 화면 호출)	
		return "/WEB-INF/views/member/login.jsp";
	}

}
