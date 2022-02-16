package kr.product.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;

public class CartListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		ProductDAO dao = ProductDAO.getInstance();
		
		List<CartVO> cart = dao.cartList(user_number); 
		
		request.setAttribute("product", cart);
		return "/WEB-INF/views/product/cartList.jsp";
	}

}
