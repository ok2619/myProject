package kr.member.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;

public class MyOrderModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		
		if(user_number == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		OrderVO order = new OrderVO();
		MemberDAO dao = MemberDAO.getInstance();
		dao.cencelMyOrder(order);

		//return "/WEB-INF/views/member/orderList.jsp"; 
		return "redirect:/member/orderList.do";
	}
	
}
