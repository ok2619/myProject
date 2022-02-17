package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class DetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//글번호 반환
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		
		//조회수증가
		dao.updateReadcount(board_num);
		BoardVO board = dao.getBoard(board_num);
		
		//HTML태그를 허용하지 않음
		board.setTitle(StringUtil.useNoHtml(board.getTitle()));
		//HTML태그 허용x , 줄바꿈 처리
		board.setB_content(StringUtil.useBrNoHtml(board.getB_content()));
		
		request.setAttribute("board", board); //데이터저장
		
		//JSP경로 반환
		return "/WEB-INF/views/board/detail.jsp";
	}

}
