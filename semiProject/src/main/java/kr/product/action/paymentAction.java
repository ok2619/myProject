package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;

public class paymentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		//카카오페이 결제시 카카오톡문자로 결제메세지가 올때 해당 상품의 상품명,가격,종류 등이 출력되기 위해서
		//세션으로 저장한 후 payment.jsp내부 자바스크립트 안에서 세션을 불러와야함
		request.setCharacterEncoding("utf-8");
				
		String product_name = request.getParameter("product_name");
		String price = request.getParameter("price");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String zipcode = request.getParameter("zipcode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		/* int cart_count = Integer.parseInt(request.getParameter("cart_count")); */
		
		HttpSession session = request.getSession();
		session.setAttribute("product_name", product_name); //상품명
		session.setAttribute("price", price); //상품명
		session.setAttribute("name", name);
		session.setAttribute("phone", phone);
		session.setAttribute("zipcode", zipcode);
		session.setAttribute("address1", address1);
		session.setAttribute("address2", address2);
		
		session.setAttribute("product_num", product_num);
		/*
		 * session.setAttribute("cart_count", cart_count); //구매수량
		 */		
		//자바로 저장한 세션값을 자바스크립트에서 불러오려면
		
		
		return "/WEB-INF/views/product/payment.jsp";
	}

}
