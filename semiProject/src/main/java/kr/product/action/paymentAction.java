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
		//상품명,이름,연락처,주소지,우편번호
		request.setCharacterEncoding("utf-8");
				
		String product_name = request.getParameter("product_name");
		String price = request.getParameter("price");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String zipcode = request.getParameter("zipcode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int cart_count = Integer.parseInt(request.getParameter("cart_count"));
		
		HttpSession session = request.getSession();
		session.setAttribute("product_name", product_name);
		session.setAttribute("name", name);
		session.setAttribute("phone", phone);
		session.setAttribute("zipcode", zipcode);
		session.setAttribute("address1", address1);
		session.setAttribute("address2", address2);
		
		session.setAttribute("product_num", product_num);
		session.setAttribute("cart_count", cart_count);
		
		//자바로 저장한 세션값을 자바스크립트에서 불러오려면
		
		
		return "/WEB-INF/views/product/payment.jsp";
	}

}
