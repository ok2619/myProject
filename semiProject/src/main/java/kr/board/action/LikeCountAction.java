package kr.board.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardFavVO;
import kr.board.vo.BoardReplyVO;
import kr.board.vo.BoardVO;
import kr.controller.Action;

public class LikeCountAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> mapAjax = new HashMap<String,Object>();
 
		request.setCharacterEncoding("utf-8");
		int board_num = Integer.parseInt(request.getParameter("board_num"));

		BoardDAO dao = BoardDAO.getInstance();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		if(user_num == null) {//로그인 안됨
			mapAjax.put("result", "success"); //좋아요 표시
			mapAjax.put("status", "noFav"); //빈 하트 표시
			mapAjax.put("count", dao.selectFavCount(board_num)); //좋아요 총 개수 표시
		}else {//로그인 됨
			
			BoardFavVO vo = dao.selectFav(board_num, user_num); //데이터베이스에 추천 정보 저장

			if(vo!=null) { //vo가 null이 아니면 추천을 이미 한 경우
				/* dao.deleteFav(vo.getFav_num()); */
				mapAjax.put("result", "success");
				mapAjax.put("status", "yesFav"); // 추천하트로 표시
				mapAjax.put("count", dao.selectFavCount(board_num)); //좋아요 총 개수 표시
			}else{ // 추천을 안한 경우
				/* dao.insertFav(board_num, user_num); */
				mapAjax.put("result", "success");
				mapAjax.put("status", "noFav"); //빈 하트 표시 
				mapAjax.put("count", dao.selectFavCount(board_num)); //좋아요 총 개수 표시
			}
		}
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);

		request.setAttribute("ajaxData", ajaxData);

		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}