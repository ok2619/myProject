package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.product.dao.ProductDAO;

public class MainCartAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductDAO dao = ProductDAO.getInstance();
		
		
		dao.cartInsert(product_num,user_number,1);

		return "/WEB-INF/views/product/cartInsert.jsp";
	}

}
