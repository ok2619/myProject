package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;

public class BuyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		System.out.println(product_num);
		
		return "/WEB-INF/views/product/buyForm.jsp";
	}

}
