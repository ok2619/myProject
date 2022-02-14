package kr.board.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardReplyVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		//count를 읽어와야 페이지처리가능
		BoardDAO dao = BoardDAO.getInstance();
		int count = dao.getReplyBoardCount(board_num);
					
		int rowCount = 10;
		
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,rowCount,1,null);
		
		List<BoardReplyVO> list = null;
		if(count > 0) {
			list = dao.getListReplyBoard(page.getStartCount(),page.getEndCount(),board_num);
		}else {
			list = Collections.emptyList(); //count=0일땐 list가 null로 보내지기때문에 null말고 비어있는 형식으로 보내주기위해
		}
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		mapAjax.put("count", count);
		mapAjax.put("rowCount", rowCount);
		mapAjax.put("list", list);
		mapAjax.put("user_num", user_num);
						
		//JSON 데이터로 반환
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
