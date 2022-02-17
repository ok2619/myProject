package kr.product.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;

public class ModifyCartAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session  = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_number");
		
		if(user_num == null) { //로그인 안된경우
			mapAjax.put("result", "logout");	
		}else{ //로그인 되어있는 경우
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			
			//전송된 데이터 반환
			int product_num = Integer.parseInt(request.getParameter("product_num"));
			int cart_count = Integer.parseInt(request.getParameter("cart_count"));
			
			//현재구매하고자하는 상품의 재고수를 구함
			ProductDAO proDao = ProductDAO.getInstance();
			ProductVO product = proDao.getProduct(product_num);
			
			if(product.getStock() < cart_count ) {//재고부족
				mapAjax.put("result", "noQuantity");
			}else {//상품 수량 변경 가능
				CartVO cart = new CartVO();
				cart.setCart_num(Integer.parseInt(request.getParameter("cart_num")));
				cart.setCart_count(cart_count);
				proDao.updateCartByItem_num(cart);							
				mapAjax.put("result", "success");				
			}			
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
