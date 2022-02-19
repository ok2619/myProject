package kr.order.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.product.dao.ProductDAO;
import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;

public class OrderAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		if(user_num == null) {//로그인이 되어 있지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인이 되어 있는 경우
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		ProductDAO dao = ProductDAO.getInstance();
		int all_total = dao.getTotalByMem_num(user_num);
		if(all_total<=0) {
			request.setAttribute("notice_msg", 
					        "정상적인 주문이 아니거나 상품의 수량이 부족합니다!");
			request.setAttribute("notice_url", 
					     request.getContextPath()+"/main/main.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		List<CartVO> cartList = dao.cartList(user_num);
		
		//주문 상품의 대표 상품명 생성
		String product_name;
		if(cartList.size()==1) {
			product_name = cartList.get(0).getProduct().getProduct_name();
		}else {
			product_name = cartList.get(0).getProduct().getProduct_name()+"외 " + (cartList.size()-1)+"건";
		}
		
		//여러 종류의 상품이 있을 수 있기 때문에
		//상품의 정보를 OrderDetailVO에 각각 저장함
		//아래에서 만들어진 데이터는 zorder_detail에 저장함
		List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
		for(CartVO cart : cartList) {
			
			ProductDAO productDAO = ProductDAO.getInstance();
			ProductVO product = productDAO.getProduct(cart.getProduct_num());								
						
			
			if(product.getStock() < cart.getCart_count()) {
				//상품 재고 수량 부족
				request.setAttribute("notice_msg", 
						           "["+product.getProduct_name()+"] 재고 부족으로 주문 불가");
				request.setAttribute("notice_url", 
						                    request.getContextPath()+"/product/cartList.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
			
			OrderDetailVO orderDetail = new OrderDetailVO();
			orderDetail.setProduct_num(cart.getProduct_num());
			orderDetail.setProduct_name(cart.getProduct().getProduct_name());
			orderDetail.setProduct_price(cart.getProduct().getPrice());
			orderDetail.setCart_count(cart.getCart_count());
			orderDetail.setProduct_total(cart.getSub_total());
			
			orderDetailList.add(orderDetail);			
		}
		
		//qorder에 저장할 데이터
		OrderVO order = new OrderVO();
		order.setProduct_name(product_name);
		order.setOrder_total(all_total);
		order.setPayment(Integer.parseInt(request.getParameter("payment")));
		order.setOrder_name(request.getParameter("order_name"));
		order.setOrder_post(request.getParameter("order_post"));
		order.setOrder_address1(request.getParameter("order_address1"));
		order.setOrder_address2(request.getParameter("order_address2"));
		order.setOrder_phone(request.getParameter("order_phone"));		
		order.setUser_num(user_num);
		
		//주문 정보를 테이블에 저장
		OrderDAO orderDao = OrderDAO.getInstance();
		orderDao.insertOrder(order, orderDetailList);
		
		//refresh 정보를 응답 헤더에 저장
		response.addHeader("Refresh", "1;url=../main/main.do");
		request.setAttribute("accessMsg", "주문이 완료되었습니다.");
		request.setAttribute("accessUrl", 
				              request.getContextPath()+"/main/main.do");
		
		return "/WEB-INF/views/common/notice.jsp";
	}

}
