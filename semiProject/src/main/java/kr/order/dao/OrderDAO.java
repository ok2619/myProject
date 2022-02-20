package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
//////바로구매 했을때
	public void insertOrder(OrderVO order, OrderDetailVO orderDetail) throws Exception{
		
		//재고수 차감
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		ResultSet rs = null;
		String sql = null;
		int order_num = 0;
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			sql = "SELECT qorder_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order_num = rs.getInt(1);
			}
			
			//order에저장
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
			
			
			//orderdetail에 저장
			sql = "INSERT INTO qorder_detail (orderdetail_num, product_num, product_name, "
					+ "product_price, product_total, cart_count, order_num) "
					+ "VALUES (qorder_detail_seq.nextval,?,?,?,?,?,?)";
				//PreparedStatement 객체 생성
				pstmt3 = conn.prepareStatement(sql);

					//?에 데이터 바인딩
					pstmt3.setInt(1, orderDetail.getProduct_num());
					pstmt3.setString(2, orderDetail.getProduct_name());
					pstmt3.setInt(3, orderDetail.getProduct_price());
					pstmt3.setInt(4, orderDetail.getProduct_total());
					pstmt3.setInt(5, orderDetail.getCart_count());
					pstmt3.setInt(6, order_num);
					
					pstmt3.executeUpdate();
				
				//상품의 재고수 차감
				sql = "UPDATE qproduct SET stock=stock-? WHERE product_num=?";
				//PreparedStatement 객체 생성
				pstmt4 = conn.prepareStatement(sql);

					//?에 데이터 바인딩
				pstmt4.setInt(1, orderDetail.getCart_count());
				pstmt4.setInt(2, orderDetail.getProduct_num());

				pstmt4.executeUpdate();
				
				conn.commit();	
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt4, null);
		}
	}
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//관리자-전체 글 갯수/검색글 갯수
		public int getOrderCount(String keyfield, String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String sub_sql = "";
			int count = 0;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
					if(keyfield.equals("1")) sub_sql = "WHERE order_num = ?"; //주문번호
					else if(keyfield.equals("2")) sub_sql = "WHERE id LIKE ?"; //구매자 아이디
					else if(keyfield.equals("3")) sub_sql = "WHERE product_name LIKE ?"; //상품명
				}
				
				sql = "SELECT COUNT(*) FROM qorder o JOIN qmember m "
					+ "ON o.user_num = m.user_num " + sub_sql;
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				if(keyword != null && !"".equals(keyword)) {
					if(keyfield.equals("1")) {
						pstmt.setString(1, keyword);
					}else {
						pstmt.setString(1, "%" + keyword + "%");
					}
				}
				//SQL문을 실행해서 결과행을 ResultSet에 담음
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return count;
		}
		
		//관리자-목록/검색글 목록
		public List<OrderVO> getListOrder(int startRow, int endRow, 
				                String keyfield, String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderVO> list = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
					if(keyfield.equals("1")) sub_sql = "WHERE order_num = ?";
					else if(keyfield.equals("2")) sub_sql = "WHERE id LIKE ?";
					else if(keyfield.equals("3")) sub_sql = "WHERE product_name LIKE ?";
				}
				
				//SQL문 작성
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM "
					+ "qorder o JOIN qmember m ON o.user_num = m.user_num " + sub_sql 
					+ " ORDER BY order_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
				
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				if(keyword != null && !"".equals(keyword)) {
					if(keyfield.equals("1")) {
						pstmt.setString(++cnt, keyword);
					}else {
						pstmt.setString(++cnt, "%" + keyword + "%");
					}
				}
				pstmt.setInt(++cnt, startRow);
				pstmt.setInt(++cnt, endRow);
				
				//SQL문을 실행해서 결과행들을 ResultSet에 담음
				rs = pstmt.executeQuery();
				
				list = new ArrayList<OrderVO>();
				while(rs.next()) {
					OrderVO order = new OrderVO();
					order.setOrder_num(rs.getInt("order_num"));
					order.setProduct_name(rs.getString("product_name"));
					order.setOrder_total(rs.getInt("order_total"));
					order.setShipping(rs.getInt("shipping"));
					order.setReg_date(rs.getDate("reg_date"));
					order.setId(rs.getString("id"));
					
					list.add(order);
				}
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return list;
		}
		
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		
		//사용자-전체 글 갯수/검새글 갯수
		//사용자-목록/검색글 목록
		//개별 상품 목록
		public List<OrderDetailVO> getListOrderDetail(int order_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDetailVO> list = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//SQL문
				sql = "SELECT * FROM qorder_detail WHERE order_num=? ORDER BY product_num DESC";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터를 바인딩
				pstmt.setInt(1, order_num);
				
				//SQL문을 실행해서 결과행들을 ResultSet에 담음
				rs = pstmt.executeQuery();
				
				list = new ArrayList<OrderDetailVO>();
				while(rs.next()) {
					OrderDetailVO detail = new OrderDetailVO();
					detail.setProduct_name(rs.getString("product_name"));
					detail.setProduct_price(rs.getInt("product_price"));
					detail.setProduct_total(rs.getInt("product_total"));
					detail.setCart_count(rs.getInt("cart_count"));
					
					list.add(detail);
				}
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return list;
		}
		//관리자/사용자 - 주문 상세
		public OrderVO getOrder(int order_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			OrderVO order = null;
			String sql = null;
					
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
							
				//SQL문 작성
				sql = "SELECT * FROM qorder WHERE order_num = ?";
				
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setInt(1, order_num);
							
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					order = new OrderVO();
					order.setOrder_num(rs.getInt("order_num"));
					order.setProduct_name(rs.getString("product_name"));
					order.setOrder_total(rs.getInt("order_total"));
					order.setPayment(rs.getInt("payment"));
					order.setShipping(rs.getInt("shipping"));
					order.setOrder_name(rs.getString("order_name"));
					order.setOrder_post(rs.getString("order_post"));
					order.setOrder_address1(rs.getString("order_address1"));
					order.setOrder_address2(rs.getString("order_address2"));
					order.setOrder_phone(rs.getString("order_phone"));					
					order.setReg_date(rs.getDate("reg_date"));
					order.setUser_num(rs.getInt("user_num"));
				}
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return order;
		}
		//주문 수정
		public void updateOrder(OrderVO order)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
					
			try {
				conn = DBUtil.getConnection();
				sql = "update qorder set order_name = ?,order_post=?,order_address1=?, "
						+ "order_address2=?,order_phone=?,payment=?,shipping=? where order_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, order.getOrder_name());
				pstmt.setString(2, order.getOrder_post());
				pstmt.setString(3, order.getOrder_address1());
				pstmt.setString(4, order.getOrder_address2());
				pstmt.setString(5, order.getOrder_phone());
				pstmt.setInt(6, order.getPayment());
				pstmt.setInt(7, order.getShipping());
				pstmt.setInt(8, order.getOrder_num());
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
				
			}
		}
		//주문 삭제
		public void deleteOrder(int order_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				sql = "delete from qorder where order_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, order_num);
				pstmt.executeUpdate();
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
	
	
} 
