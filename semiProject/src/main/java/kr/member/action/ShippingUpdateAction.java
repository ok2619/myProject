package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;

public class ShippingUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		request.setCharacterEncoding("utf-8");
		
int order_num = Integer.parseInt(request.getParameter("order_num"));
		
		OrderVO order = new OrderVO();
		order.setOrder_num(order_num);
		order.setUser_num(user_number);
		order.setOrder_name(request.getParameter("order_name"));
		order.setOrder_post(request.getParameter("order_post"));
		order.setOrder_address1(request.getParameter("order_address1"));
		order.setOrder_address2(request.getParameter("order_address2"));
		order.setOrder_phone(request.getParameter("order_phone"));
		order.setPayment(Integer.parseInt(request.getParameter("payment")));
		order.setShipping(Integer.parseInt(request.getParameter("shipping")));
		
		OrderDAO dao = OrderDAO.getInstance();
		dao.updateOrder(order);
		
		return "/WEB-INF/views/member/shippingModifyForm.jsp";
	}

}
