package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;

public class CartInsertAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		

		
		CartVO cart = new CartVO();
		cart.setProduct_num(Integer.parseInt(request.getParameter("product_num")));
		cart.setCart_count(Integer.parseInt(request.getParameter("cart_count")));
		
		
		cart.setUser_num(user_number);
		ProductDAO dao = ProductDAO.getInstance();
		CartVO cartItem = dao.getCart(cart);
		
		if(cartItem == null) {//같은 회원번호, 같은 상품번호로 등록한 정보 미존재
			dao.cartInsert(cart);
		}else {//같은 회원번호, 같은 상품번호로 등록한 정보 존재
			ProductDAO itemDao = ProductDAO.getInstance();
			//재고 수량을 확인하기 위해서
			ProductVO item = itemDao.getProduct(cartItem.getProduct_num());
			                     //기존 카트에 저장된 수량            새로 입력한 수량
			int order_quantity = cartItem.getCart_count() + cart.getCart_count();
			
			if(item.getStock()<order_quantity) {
				//상품 재고 수량보다 장바구니에 많이 담으면 오류
				request.setAttribute("notice_msg", 
						            "기존에 주문한 상품입니다. 갯수를 추가하면 재고가 부족합니다.");
				request.setAttribute("notice_url", 
						                     request.getContextPath()+"/product/cartList.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
			
			//같은 회원번호, 같은 상품번호로 등록한 정보가 존재할 때 업데이트
			cart.setCart_count(order_quantity);
			dao.updateCartByItem_num(cart);
		}
		
		return "redirect:/product/cartList.do";
	}

}
