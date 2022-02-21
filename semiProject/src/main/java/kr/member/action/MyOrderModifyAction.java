package kr.member.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.order.vo.OrderDetailVO;

public class MyOrderModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		
		if(user_number == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		MemberDAO dao = MemberDAO.getInstance();
		dao.cencelMyOrder(order_num);
		/*
		 * Map<String,String> mapAjax = new HashMap<String,String>(); int shipping =
		 * Integer.parseInt(request.getParameter("shipping"));
		 * 
		 * if(shipping != 5) { mapAjax.put("count", dao.cencelMyOrder(order_num)); }
		 * else if(shipping == 5){ mapAjax.put("count", "nocencel"); }
		 */
		
		/*
		 * return "/WEB-INF/views/common/ajax_view.jsp"; //ajax
		 */	
		return "/WEB-INF/views/member/orderList.jsp"; 
	}
	
}
