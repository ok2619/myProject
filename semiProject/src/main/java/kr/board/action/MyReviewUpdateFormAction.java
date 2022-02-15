package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;

public class MyReviewUpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardVO db_board = dao.getBoard(board_num);
		if(user_num!=db_board.getUser_num()) {//로그인한회원번호와 작성자회원번호가 불일치한 경우			
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인 되어있고 로그인한 회원번호와 작성자 회원번호 일치
		request.setAttribute("board", db_board);
		
		return "/WEB-INF/views/board/myReviewUpdateForm.jsp";
	}

}
