package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;

public class BuyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {
			return "redirect:/member/loginForm.do";
		}
		request.setCharacterEncoding("utf-8");
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int cart_count = Integer.parseInt(request.getParameter("cart_count"));
		
		/////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////
		session.setAttribute("cart_count",cart_count);

		
		ProductDAO dao = ProductDAO.getInstance();
		ProductVO product = dao.getProduct(product_num);
		
		MemberDAO memberDao = MemberDAO.getInstance();
		MemberVO member =  memberDao.getMember(user_number);
		
		request.setAttribute("member", member);
		
		request.setAttribute("product", product);
		
		return "/WEB-INF/views/product/buyForm.jsp";
	}

}
