package kr.product.action;

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

public class paymentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {//로그인이 되어 있지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//전송된 데이터 인코딩 처리
				request.setCharacterEncoding("utf-8");
				
				ProductDAO dao = ProductDAO.getInstance();
				int all_total = dao.getTotalByMem_num(user_number);
				if(all_total<=0) {
					request.setAttribute("notice_msg", 
							        "정상적인 주문이 아니거나 상품의 수량이 부족합니다!");
					request.setAttribute("notice_url", 
							     request.getContextPath()+"/item/itemList.do");
					return "/WEB-INF/views/common/alert_singleView.jsp";
				}
				
				List<CartVO> cartList = dao.cartList(user_number);
		
				//주문 상품의 대표 상품명 생성
				String item_name;
				if(cartList.size()==1) {
					item_name = cartList.get(0).getProduct().getProduct_name();
				}else {
					item_name = cartList.get(0).getProduct().getProduct_name()+"외 " + (cartList.size()-1)+"건";
				}
				List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
				for(CartVO cart : cartList) {
					ProductDAO itemDao = ProductDAO.getInstance();
					ProductVO item = itemDao.getProduct(cart.getProduct_num());
					
					
					
					if(item.getStock() < cart.getCart_count()) {
						//상품 재고 수량 부족
						request.setAttribute("notice_msg", 
								           "["+item.getProduct_name()+"]재고수량 부족으로 주문 불가");
						request.setAttribute("notice_url", 
								                    request.getContextPath()+"/cart/list.do");
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
				
				//zorder에 저장할 데이터
				OrderVO order = new OrderVO();
				order.setProduct_name(item_name);
				order.setOrder_total(all_total);
				order.setOrder_name(request.getParameter("order_name"));
				order.setOrder_post(request.getParameter("zipcode"));
				order.setOrder_address1(request.getParameter("address1"));
				order.setOrder_address2(request.getParameter("address2"));
				order.setOrder_phone(request.getParameter("phone"));
				order.setUser_num(user_number);
				
				//주문 정보를 테이블에 저장
				OrderDAO orderDao = OrderDAO.getInstance();
				orderDao.insertOrder(order, orderDetailList);
				
				//refresh 정보를 응답 헤더에 저장
				response.addHeader("Refresh", "1;url=../main/main.do");
				request.setAttribute("accessMsg", "주문 작성이 완료되었습니다.");
				request.setAttribute("accessUrl", 
						              request.getContextPath()+"/main/main.do");
				
				return "/WEB-INF/views/product/payment.jsp";
	}

}
