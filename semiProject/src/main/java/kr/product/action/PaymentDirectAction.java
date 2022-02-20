package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;

public class PaymentDirectAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {//로그인이 되어 있지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		String product_name = request.getParameter("product_name");
		int price = Integer.parseInt(request.getParameter("price"));
		request.setCharacterEncoding("utf-8");

		OrderDetailVO orderDetail = new OrderDetailVO();
		orderDetail.setProduct_num(Integer.parseInt(request.getParameter("product_num")));
		orderDetail.setProduct_name(product_name);
		orderDetail.setProduct_price(price);
		orderDetail.setCart_count(Integer.parseInt(request.getParameter("cart_count")));
		orderDetail.setProduct_total(price);
		
		OrderVO order = new OrderVO();
		order.setProduct_name(request.getParameter("product_name"));
		order.setOrder_total(price);
		order.setOrder_name(request.getParameter("order_name"));
		order.setOrder_post(request.getParameter("zipcode"));
		order.setOrder_address1(request.getParameter("address1"));
		order.setOrder_address2(request.getParameter("address2"));
		order.setOrder_phone(request.getParameter("phone"));
		order.setUser_num(user_number);
		
		
		ProductDAO itemDao = ProductDAO.getInstance();
		ProductVO item = itemDao.getProduct(Integer.parseInt(request.getParameter("product_num")));
		if(item.getStock() < Integer.parseInt(request.getParameter("cart_count"))) {
			//상품 재고 수량 부족
			request.setAttribute("notice_msg", 
					       "[" + item.getProduct_name() + "]재고 수량 부족으로 주문 불가");
			request.setAttribute("notice_url", 
					             request.getContextPath()+"/product/cartList.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		
		//주문 정보를 테이블에 저장
		OrderDAO orderDao = OrderDAO.getInstance();
		orderDao.insertOrder(order, orderDetail);
		
		
		//refresh 정보를 응답 헤더에 저장
		response.addHeader("Refresh", "1;url=../main/main.do");
		request.setAttribute("accessMsg", "주문 작성이 완료되었습니다.");
		request.setAttribute("accessUrl", 
				              request.getContextPath()+"/main/main.do");
		
		return "/WEB-INF/views/common/notice.jsp";
	}

	}
