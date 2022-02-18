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

public class CartInAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
			Map<String,String> mapAjax = new HashMap<String,String>();
			
			HttpSession session = request.getSession();
			Integer user_num = (Integer)session.getAttribute("user_number");
			if(user_num == null) {
				mapAjax.put("result", "logout");
				
			}	 
				CartVO cart = new CartVO();
				cart.setProduct_num(Integer.parseInt(request.getParameter("product_num")));
				cart.setCart_count(1);
				
				cart.setUser_num(user_num);
				ProductDAO dao = ProductDAO.getInstance();
				CartVO cartItem = dao.getCart(cart);
				
				if(cartItem == null) {//같은 회원번호, 같은 상품번호로 등록한 정보 미존재
					dao.cartInsert(cart);
					
					mapAjax.put("result", "success");
					
				}else {//같은 회원번호, 같은 상품번호로 등록한 정보 존재
					ProductDAO itemDao = ProductDAO.getInstance();
					//재고 수량을 확인하기 위해서
					ProductVO item = itemDao.getProduct(cartItem.getProduct_num());
					                     //기존 카트에 저장된 수량            새로 입력한 수량
					int order_quantity = cartItem.getCart_count() + cart.getCart_count();
					
					if(item.getStock()<order_quantity) {
						mapAjax.put("result", "noQuantity");
					}
					
					//같은 회원번호, 같은 상품번호로 등록한 정보가 존재할 때 업데이트
					cart.setCart_count(order_quantity);
					dao.updateCartByItem_num(cart);
					
					mapAjax.put("result", "success2");
				}
							
		
				ObjectMapper mapper = new ObjectMapper();
				String ajaxData = mapper.writeValueAsString(mapAjax);
				
				request.setAttribute("ajaxData", ajaxData);
				
				return "/WEB-INF/views/common/ajax_view.jsp";
		}

	}

