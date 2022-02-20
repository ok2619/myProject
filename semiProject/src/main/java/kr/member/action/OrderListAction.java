package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.order.vo.OrderVO;
import kr.util.PagingUtil;

public class OrderListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//상품명, 금액 , 주문수량
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		
		if(user_number == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인이 된 경우
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		MemberDAO dao = MemberDAO.getInstance();
		int count = dao.getOrderCount(user_number);
				
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,10,10,"myReview.do");

		List<OrderVO> list = null; 
		if(count > 0) {
			list = dao.getMyOrder(page.getStartCount(),page.getEndCount(), keyfield, keyword, user_number);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		request.setAttribute("user_number", user_number);
		
		return "/WEB-INF/views/member/orderList.jsp";
	}

}
