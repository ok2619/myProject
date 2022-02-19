package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.order.dao.OrderDAO;
import kr.util.DBUtil;

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
