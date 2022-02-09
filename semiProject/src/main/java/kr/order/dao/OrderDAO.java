package kr.order.dao;

import kr.order.dao.OrderDAO;

public class OrderDAO {
	private static OrderDAO instance = new OrderDAO();
	public static OrderDAO getInstance() {
		return instance;
	}
	private OrderDAO() {}
	
	
	//상품주문
	//주문수정
	//주문취소
	//카트담기
	//카트삭제
	
}
