package kr.product.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.order.dao.OrderDAO;
import kr.product.dao.ProductDAO;
import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;

public class CartBuyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		
		ProductDAO dao = ProductDAO.getInstance();
		
		int all_total = dao.getTotalByMem_num(user_number);
		
		if(all_total<=0) {
			request.setAttribute("notice_msg", 
					     "정상적인 주문이 아니거나 상품의 수량이 부족합니다!");
			request.setAttribute("notice_url", 
					    request.getContextPath()+"/product/productList.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		
		//장바구니에 담겨있는 상품 정보 호출
		List<CartVO> cartList = dao.cartList(user_number);
		for(CartVO cart : cartList) {
			ProductDAO itemDao = ProductDAO.getInstance();
			ProductVO item = itemDao.getProduct(cart.getProduct_num());
			
			
			if(item.getStock() < cart.getCart_count()) {
				//상품 재고 수량 부족
				request.setAttribute("notice_msg", 
						       "[" + item.getProduct_name() + "]재고 수량 부족으로 주문 불가");
				request.setAttribute("notice_url", 
						             request.getContextPath()+"/product/cartList.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
		}
				
		MemberDAO memberDao = MemberDAO.getInstance();
		MemberVO member =  memberDao.getMember(user_number);
		
		request.setAttribute("member", member);
		
		request.setAttribute("list", cartList);
		request.setAttribute("all_total", all_total);
		
		return "/WEB-INF/views/product/cartBuyForm.jsp";
	}

}
