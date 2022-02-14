package kr.board.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardReplyVO;
import kr.controller.Action;

public class WriteReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		if(user_num == null) {//로그인 안됨
			mapAjax.put("result", "logout");
			
		}else {//로그인 됨
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			
			//전송된 데이터 자바빈(VO)에 저장
			BoardReplyVO reply = new BoardReplyVO();
			reply.setUser_num(user_num);
			reply.setRe_content(request.getParameter("re_content"));
			reply.setRe_ip(request.getRemoteAddr());
			reply.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
			
			BoardDAO dao = BoardDAO.getInstance();
			dao.insertReplyBoard(reply);
			
			mapAjax.put("result", "success");			
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
