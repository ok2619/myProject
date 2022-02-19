package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.util.DBUtil;

public class OrderDAO {
	private static OrderDAO instance = new OrderDAO();
	public static OrderDAO getInstance() {
		return instance;
	}
	private OrderDAO() {}
	
	//주문 등록
	public void insertOrder(OrderVO order, List<OrderDetailVO> orderDetailList)
	                                            throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		ResultSet rs = null;
		String sql = null;
		int order_num = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//오토 커밋 해제
			conn.setAutoCommit(false);
			
			//SQL문 작성
			sql = "SELECT qorder_seq.nextval FROM dual";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//SQL문을 실행해서 결과행을 ResultSet에 담음
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				order_num = rs.getInt(1);
			}
			
			//zorder에 주문 정보 삽입
			sql = "INSERT INTO qorder (order_num, product_name, order_total, payment,"
				+ "order_name, order_post, order_address1, order_address2,"
				+ "order_phone, user_num) VALUES (?,?,?,?,?,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt2 = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt2.setInt(1, order_num);
			pstmt2.setString(2, order.getProduct_name());
			pstmt2.setInt(3, order.getOrder_total());
			pstmt2.setInt(4, order.getPayment());
			pstmt2.setString(5, order.getOrder_name());
			pstmt2.setString(6, order.getOrder_post());
			pstmt2.setString(7, order.getOrder_address1());
			pstmt2.setString(8, order.getOrder_address2());
			pstmt2.setString(9, order.getOrder_phone());
			pstmt2.setInt(10, order.getUser_num());
			//SQL문 실행
			pstmt2.executeUpdate();
			
			//zorder_detail에 주문 상세 정보 삽입
			sql = "INSERT INTO qorder_detail (orderdetail_num, product_num, product_name,"
				+ "product_price, product_total, cart_count, order_num) "
				+ "VALUES (qorder_detail_seq.nextval,?,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt3 = conn.prepareStatement(sql);
			
			for(int i=0;i<orderDetailList.size();i++) {
				OrderDetailVO orderDetail = orderDetailList.get(i);
				//?에 데이터 바인딩
				pstmt3.setInt(1, orderDetail.getProduct_num());
				pstmt3.setString(2, orderDetail.getProduct_name());
				pstmt3.setInt(3, orderDetail.getProduct_price());
				pstmt3.setInt(4, orderDetail.getProduct_total());
				pstmt3.setInt(5, orderDetail.getCart_count());
				pstmt3.setInt(6, order_num);
				pstmt3.addBatch(); //쿼리를 메모리에 올림
				
				//계속 추가하면 outOfMemory 발생, 1000개 단위로 executeBatch()
				if(i % 1000 == 0) {
					pstmt3.executeBatch();
				}
			}
			pstmt3.executeBatch();//쿼리를 전송
			
			//상품의 재고수 차감
			sql = "UPDATE qproduct SET stock=stock-? WHERE product_num=?";
			//PreparedStatement 객체 생성
			pstmt4 = conn.prepareStatement(sql);
			
			for(int i=0;i<orderDetailList.size();i++) {
				OrderDetailVO orderDetail = orderDetailList.get(i);
				//?에 데이터 바인딩
				pstmt4.setInt(1, orderDetail.getCart_count());
				pstmt4.setInt(2, orderDetail.getProduct_num());
				pstmt4.addBatch();//쿼리를 메모리에 올림
				
				//계속 추가하면 outOfMemory 발생, 1000개 단위로 executeBatch()
				if(i % 1000 == 0) {
					pstmt4.executeBatch();
				}
			}
			pstmt4.executeBatch();//쿼리 전송
			
			//카트에서 주문 상품 삭제
			sql = "DELETE FROM qcart WHERE user_num=?";
			//PreparedStatement 객체 생성
			pstmt5 = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt5.setInt(1, order.getUser_num());
			//SQL문 실행
			pstmt5.executeUpdate();
			
			//모든 SQL문이 성공하면
			conn.commit();			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면
			conn.rollback();
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt5, null);
			DBUtil.executeClose(null, pstmt4, null);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
	}
	
	
	//관리자-전체 글 갯수/검색글 갯수
	
	
} 
