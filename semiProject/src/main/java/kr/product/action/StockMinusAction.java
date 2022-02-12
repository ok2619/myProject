package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.product.dao.ProductDAO;

public class StockMinusAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer cart_count = (Integer)session.getAttribute("cart_count");
		Integer product_num = (Integer)session.getAttribute("product_num");

		ProductDAO dao = ProductDAO.getInstance();
		dao.StockAll(product_num,cart_count);
		
		return "/WEB-INF/views/product/stockMinus.jsp";
	}

}
